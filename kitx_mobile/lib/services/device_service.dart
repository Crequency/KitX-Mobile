import 'dart:async';

import 'package:get/get.dart';
import 'package:kitx_mobile/models/device_info.dart';
import 'package:kitx_mobile/models/enums/device_os_type.dart';
import 'package:kitx_mobile/services/public/service_status.dart';
import 'package:kitx_mobile/utils/config.dart';
import 'package:kitx_mobile/utils/global.dart';
import 'package:kitx_mobile/utils/log.dart';

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
    if (deviceServiceStatus != ServiceStatus.running) return;

    var _tempList = deviceInfoList.toList();

    var findIndex = _tempList.indexWhere(
      (element) => element.iPv4 == info.iPv4 || element.deviceMacAddress == info.deviceMacAddress,
    );

    if (findIndex != -1) {
      // Update existing device.

      deviceInfoList[findIndex] = info;
    } else {
      // Add new device.

      if (info.deviceName == Global.deviceName) {
        // Local device.

        deviceInfoList.insert(0, info);
        localDeviceCardAdded = true;

        Log.info('Insert local device to 0.');
      } else if (info.isMainDevice) {
        // Main device.

        var index = localDeviceCardAdded ? 1 : 0;
        deviceInfoList.insert(index, info);
        mainDeviceCardAdded = true;

        Log.info('Insert main device to $index.');
      } else {
        // Other device.

        var fixedCardsCount = (localDeviceCardAdded ? 1 : 0) + (mainDeviceCardAdded ? 1 : 0);

        var countDevices = (osType) => _tempList.where((element) => element.deviceOSType == osType).length;

        var devicesCountPerOS = <DeviceOSTypeEnum, int>{};
        for (var osType in DeviceOSTypeEnum.values) {
          devicesCountPerOS[osType] = countDevices(osType);
        }

        var localDeviceOS = _tempList.firstWhereOrNull((element) => element.deviceName == Global.deviceName);
        var mainDeviceOS = _tempList.firstWhereOrNull((element) => element.isMainDevice);

        if (localDeviceOS != null) {
          devicesCountPerOS[localDeviceOS.deviceOSType] = devicesCountPerOS[localDeviceOS.deviceOSType]! - 1;
        }
        if (mainDeviceOS != null) {
          devicesCountPerOS[mainDeviceOS.deviceOSType] = devicesCountPerOS[mainDeviceOS.deviceOSType]! - 1;
        }

        var instIndex = fixedCardsCount;

        var sortList = [
          DeviceOSTypeEnum.Windows,
          DeviceOSTypeEnum.Linux,
          DeviceOSTypeEnum.MacOS,
          DeviceOSTypeEnum.Android,
          DeviceOSTypeEnum.iOS,
        ];

        for (var element in sortList) {
          instIndex += devicesCountPerOS[element]!;
          if (element == info.deviceOSType) break;
        }

        var targetIndex = instIndex > deviceInfoList.length ? deviceInfoList.length : instIndex;

        deviceInfoList.insert(targetIndex, info);
      }
    }

    deviceInfoList.refresh();
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

          if (each.deviceName == Global.deviceName) {
            localDeviceCardAdded = false;

            // If local device removed, restart devices server.
            Global.restartDevicesServer();
          } else if (each.isMainDevice) {
            mainDeviceCardAdded = false;
          }
        }
      }

      deviceInfoList.refresh();
    });

    deviceServiceStatus = ServiceStatus.running;
  }

  /// Get device info list length
  int get length => deviceInfoList.length;
}
