import 'dart:async';

import 'package:get/get.dart';
import 'package:kitx_mobile/models/device_info.dart';
import 'package:kitx_mobile/services/public/service_status.dart';
import 'package:kitx_mobile/utils/config.dart';
import 'package:kitx_mobile/utils/global.dart';

/// Device Service
class DeviceService {
  /// Device Info List
  final deviceInfoList = RxList<DeviceInfoStruct>([]);

  /// Device Info List Lock
  var lock = true;

  /// Device Service Status
  var deviceServiceStatus = ServiceStatus.pending;

  /// Local Device Card Added
  var localDeviceCardAdded = false;

  /// Main Device Card Added
  var mainDeviceCardAdded = false;

  /// Add a device by [DeviceInfoStruct]
  Future<void> addDevice(DeviceInfoStruct info) async {
    if (deviceInfoList.isEmpty) {
      deviceInfoList.add(info);
    } else {
      var _tempList = deviceInfoList.toList();
      var _tag = true;

      for (var each in _tempList) {
        if (each.iPv4 == info.iPv4 || each.deviceMacAddress == info.deviceMacAddress) {
          deviceInfoList[deviceInfoList.indexOf(each)] = each.rebuild(
            (b) {
              b
                ..sendTime = info.sendTime
                ..isMainDevice = info.isMainDevice
                ..deviceOSVersion = info.deviceOSVersion
                ..deviceServerPort = info.deviceServerPort
                ..pluginServerPort = info.pluginServerPort
                ..pluginsCount = info.pluginsCount;
            },
          );
          deviceInfoList.refresh();
          _tag = false;
        }
      }

      if (_tag) {
        if (info.deviceName == Global.deviceName) {
          deviceInfoList.insert(0, info);
          localDeviceCardAdded = true;
        } else if (info.isMainDevice) {
          if (localDeviceCardAdded) {
            deviceInfoList.insert(1, info);
          } else {
            deviceInfoList.insert(0, info);
          }
          mainDeviceCardAdded = true;
        } else {
          deviceInfoList.add(info);
        }
        deviceInfoList.refresh();
      }
    }
  }

  /// 停止服务
  Future<void> stopService() async {
    deviceServiceStatus = ServiceStatus.stopping;

    deviceInfoList.clear();

    localDeviceCardAdded = false;

    mainDeviceCardAdded = false;

    deviceServiceStatus = ServiceStatus.pending;
  }

  /// Remove a device by [DeviceInfoStruct]
  Future<void> initService() async {
    deviceServiceStatus = ServiceStatus.starting;

    localDeviceCardAdded = false;

    mainDeviceCardAdded = false;

    Timer.periodic(Duration(seconds: Config.WebService_DeviceInfoCheckTTLSeconds), (_) {
      var _tempList = deviceInfoList.toList();

      for (var each in _tempList) {
        var now = DateTime.now();
        var time = each.sendTime;

        if (now.difference(time).inSeconds > Config.WebService_DeviceInfoTTLSeconds) {
          deviceInfoList.remove(each);
        }
      }

      deviceInfoList.refresh();
    });

    deviceServiceStatus = ServiceStatus.running;
  }

  /// Get device info list length
  int get length => deviceInfoList.length;
}
