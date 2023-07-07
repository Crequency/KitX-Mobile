import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:kitx_mobile/instances.dart';
import 'package:kitx_mobile/models/device_info.dart';
import 'package:kitx_mobile/services/public/service_status.dart';
import 'package:kitx_mobile/services/service.dart';
import 'package:kitx_mobile/utils/config.dart';
import 'package:kitx_mobile/utils/log.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  var server = DevicesDiscoveryService()
    ..udpPortSend = 23404
    ..udpPortReceive = 24040
    ..udpBroadcastAddress = '224.0.0.0';

  server.init();
}

/// [DevicesDiscoveryService] class
class DevicesDiscoveryService implements Service {
  var _udpPortSend = config.webServiceUdpPortSend;
  var _udpPortReceive = config.webServiceUdpPortReceive;
  var _udpBroadcastAddress = config.webServiceUdpBroadcastAddress;

  var _isExitPackageSent = false;

  /// Socket Object
  late RawDatagramSocket socket;

  /// Set UdpPortSend
  set udpPortSend(int value) => _udpPortSend = value;

  /// Set UdpPortReceive
  set udpPortReceive(int value) => _udpPortReceive = value;

  /// Set UdpBroadcastAddress
  set udpBroadcastAddress(String value) => _udpBroadcastAddress = value;

  /// 发送及接收定时器的指针
  late Timer? sendTimer;

  /// 发送及接收套接字的指针
  late RawDatagramSocket? sendSocket, receiveSocket;

  @override
  var serviceStatus = ServiceStatus.pending.obs;

  @override
  var serviceException;

  @override
  Future<DevicesDiscoveryService> init() async {
    serviceStatus.value = ServiceStatus.starting;

    _isExitPackageSent = false;

    instances.devicesService.serviceStatus.value = ServiceStatus.running;

    try {
      if (kIsWeb) {
        log.info('This is a web application, WebService will not start.');
        return this;
      }

      // deviceInfo 初始值
      var deviceInfo = DeviceInfoStruct(
        ((b) => b
          ..deviceName = instances.deviceInfo.deviceName
          ..deviceOSVersion = instances.deviceInfo.osDescription
          ..iPv4 = instances.networkInfo.ipv4
          ..iPv6 = instances.networkInfo.ipv6
          ..deviceMacAddress = instances.networkInfo.mac
          ..pluginServerPort = 0
          ..pluginsCount = 0
          ..sendTime = DateTime.now().toUtc()
          ..isMainDevice = false
          ..deviceServerPort = 0
          ..deviceServerBuildTime = DateTime.now().toUtc()
          ..deviceOSType = config.webServiceDeviceOSType),
      );

      log.info('Get device info: ${deviceInfo.toString()}');

      // 启动 UDP 服务

      // UDP 发送
      await RawDatagramSocket.bind(InternetAddress.anyIPv4, _udpPortSend).then(
        (socket) {
          sendSocket = socket;

          socket.broadcastEnabled = true;
          socket.joinMulticast(InternetAddress(_udpBroadcastAddress));

          Timer.periodic(Duration(seconds: config.webServiceUdpSendFrequency), (timer) {
            sendTimer = timer;

            try {
              deviceInfo = deviceInfo.rebuild((b) => b..sendTime = DateTime.now().toUtc());

              if (_isExitPackageSent) {
                deviceInfo = deviceInfo.rebuild(
                  (b) => b..sendTime = DateTime.now().add(Duration(seconds: -20)).toUtc(),
                );
              }

              var _data = deviceInfo.toString();
              // Log.info('UDP send: $_data');
              socket.send(utf8.encode(_data), InternetAddress(_udpBroadcastAddress), _udpPortReceive);
            } catch (e, stack) {
              timer.cancel();
              socket.close();
              log.info('UDP send error: $e $stack. Try to restart the service in 5 seconds.');
              Future.delayed(const Duration(seconds: 5), () => init());
              throw e;
            }
          });
          log.info('UDP send service started.');
        },
      );

      // UDP 接收
      await RawDatagramSocket.bind(InternetAddress.anyIPv4, _udpPortReceive, ttl: 1).then(
        (socket) {
          receiveSocket = socket;

          socket.joinMulticast(InternetAddress(_udpBroadcastAddress));
          socket.listen(
            (event) async {
              var d = socket.receive();
              if (d == null) return;

              var _data = utf8.decode(d.data);
              log.info('UDP receive: $_data');

              try {
                var _deviceInfo = DeviceInfoStruct.fromString(_data);
                if (_deviceInfo != null) await instances.devicesService.addDevice(_deviceInfo);
              } catch (e, stack) {
                log.error('Can not deserialize device info pack: `$_data`. Error: $e $stack');
              }
            },
          );
        },
      );

      instances.taskHandler.delay(() => serviceStatus.value = ServiceStatus.running, 500);
    } catch (e, stack) {
      log.error('Catch an error: $e On: $stack');
      serviceStatus.value = ServiceStatus.error;
      serviceException = e as Exception;
    }

    return this;
  }

  @override
  Future<DevicesDiscoveryService> restart() async {
    // TODO: implement restart
    throw UnimplementedError();
  }

  @override
  Future<DevicesDiscoveryService> stop({bool sendExitPackage = true}) async {
    void stopAction() {
      sendTimer?.cancel();
      sendTimer = null;

      receiveSocket?.close();

      sendSocket?.close();

      receiveSocket = null;
      sendSocket = null;

      serviceStatus.value = ServiceStatus.pending;
    }

    instances.devicesService.serviceStatus.value = ServiceStatus.pending;
    instances.devicesService.deviceInfoList.clear();

    serviceStatus.value = ServiceStatus.stopping;

    if (sendExitPackage) {
      _isExitPackageSent = true;

      instances.taskHandler.delay(stopAction, 1500);
    } else {
      stopAction();
    }

    return this;
  }
}
