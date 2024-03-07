import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:kitx_mobile/instances.dart';
import 'package:kitx_mobile/services/public/service_status.dart';
import 'package:kitx_mobile/services/service.dart';
import 'package:kitx_mobile/utils/config.dart';
import 'package:kitx_mobile/utils/extensions/null_value_checker.dart';
import 'package:kitx_mobile/utils/handlers/tasks/delayed_task.dart';
import 'package:kitx_mobile/utils/log.dart';
import 'package:kitx_mobile_internal_plugins/kitx_mobile_internal_plugins.dart';
import 'package:kitx_shared_dart/kitx_shared_dart.dart';

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

    var connection = await instances.connectivity.checkConnectivity();

    if (connection != ConnectivityResult.wifi) {
      log.error('No wifi connection, WebService will not start.');
      serviceException = Exception('No Wi-Fi connection, current is ${connection.toString()}');
      serviceStatus.value = ServiceStatus.error;
      return this;
    }

    _isExitPackageSent = false;

    serviceStatus.value = ServiceStatus.running;

    try {
      var deviceInfo = DeviceInfo(
        ((b) => b
          ..device = DeviceLocator(((l) => l
            ..deviceName = instances.deviceInfo.deviceName.ifNull('')
            ..iPv4 = instances.networkInfo.ipv4.ifNull('')
            ..iPv6 = instances.networkInfo.ipv6.ifNull('')
            ..macAddress = instances.networkInfo.mac.ifNull(''))).toBuilder()
          ..deviceOSVersion = instances.deviceInfo.osDescription.ifNull('')
          ..pluginsServerPort = 0
          ..pluginsCount = 0
          ..sendTime = DateTime.now().toUtc()
          ..isMainDevice = false
          ..devicesServerPort = 0
          ..devicesServerBuildTime = DateTime.now().toUtc()
          ..deviceOSType = config.webServiceDeviceOSType),
      );

      log.info('Get device info: ${deviceInfo.toString()}');

      // UDP Sending
      await RawDatagramSocket.bind(
        InternetAddress.anyIPv4,
        _udpPortSend,
      ).then(
        (socket) {
          sendSocket = socket;

          socket.broadcastEnabled = true;
          socket.joinMulticast(InternetAddress(_udpBroadcastAddress));

          Timer.periodic(Duration(seconds: config.webServiceUdpSendFrequency), (timer) {
            sendTimer = timer;

            try {
              deviceInfo = deviceInfo.rebuild(
                (b) => b
                  ..sendTime = DateTime.now().toUtc()
                  ..pluginsCount = InternalPluginsManager.enabledLength,
              );

              if (_isExitPackageSent) {
                deviceInfo = deviceInfo.rebuild(
                  (b) => b..sendTime = DateTime.now().add(Duration(seconds: -20)).toUtc(),
                );
              }

              var _data = deviceInfo.toString();
              socket.send(
                utf8.encode(_data),
                InternetAddress(_udpBroadcastAddress),
                _udpPortReceive,
              );
            } catch (e, stack) {
              log.info('UDP send error: $e $stack. Try to restart the service in 5 seconds.');

              timer.cancel();
              socket.close();
              serviceException = e as Exception;
              serviceStatus.value = ServiceStatus.error;

              Future.delayed(const Duration(seconds: 5), () => init());
            }
          });

          log.info('UDP send service started.');
        },
      );

      // UDP Receiving
      await RawDatagramSocket.bind(
        InternetAddress.anyIPv4,
        _udpPortReceive,
        ttl: 1,
      ).then(
        (socket) {
          receiveSocket = socket;

          socket.joinMulticast(
            InternetAddress(_udpBroadcastAddress),
          );
          socket.listen(
            (event) async {
              var d = socket.receive();
              if (d == null) return;

              var _data = utf8.decode(d.data);
              log.info('UDP receive: $_data');

              try {
                var _deviceInfo = DeviceInfo.fromString(_data);
                if (_deviceInfo != null) await instances.devicesService.addDevice(_deviceInfo);
              } catch (e, stack) {
                log.error('Can not deserialize device info pack: `$_data`. Error: $e $stack');

                serviceException = e as Exception;
                serviceStatus.value = ServiceStatus.error;
              }
            },
          );
        },
      );

      (() => serviceStatus.value = ServiceStatus.running).delay(milliseconds: 500).execute();
    } catch (e, stack) {
      log.error('Catch an error: $e On: $stack');

      serviceException = e as Exception;
      serviceStatus.value = ServiceStatus.error;
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

    var inErrState = serviceStatus.value == ServiceStatus.error;

    instances.devicesService.serviceStatus.value = ServiceStatus.pending;
    instances.devicesService.deviceInfoList.clear();

    serviceStatus.value = ServiceStatus.stopping;

    if (inErrState) {
      serviceStatus.value = ServiceStatus.pending;
    } else if (sendExitPackage) {
      _isExitPackageSent = true;

      stopAction.delay(milliseconds: 1500).execute();
    } else {
      stopAction();
    }

    return this;
  }
}
