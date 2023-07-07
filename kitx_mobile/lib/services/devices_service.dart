import 'dart:async';

import 'package:get/get.dart';
import 'package:kitx_mobile/instances.dart';
import 'package:kitx_mobile/models/device_info.dart';
import 'package:kitx_mobile/models/enums/device_os_type.dart';
import 'package:kitx_mobile/services/public/service_status.dart';
import 'package:kitx_mobile/services/service.dart';
import 'package:kitx_mobile/utils/config.dart';
import 'package:kitx_mobile/utils/log.dart';

/// Device Service
class DeviceService implements Service {
  /// Device Info List
  final deviceInfoList = RxList<DeviceInfoStruct>([]);

  /// Local Device Card Added
  var localDeviceCardAdded = false;

  /// Main Device Card Added
  var mainDeviceCardAdded = false;

  /// Add a device by [DeviceInfoStruct]
  Future<void> addDevice(DeviceInfoStruct info) async {
    if (serviceStatus != ServiceStatus.running) return;

    var _tempList = deviceInfoList.toList();

    var findIndex = _tempList.indexWhere(
      (element) => element.iPv4 == info.iPv4 || element.deviceMacAddress == info.deviceMacAddress,
    );

    if (findIndex != -1) {
      // Update existing device.

      deviceInfoList[findIndex] = info;
    } else {
      // Add new device.

      if (info.deviceName == instances.deviceInfo.deviceName) {
        // Local device.

        deviceInfoList.insert(0, info);
        localDeviceCardAdded = true;

        log.info('Insert local device to 0.');
      } else if (info.isMainDevice) {
        // Main device.

        var index = localDeviceCardAdded ? 1 : 0;
        deviceInfoList.insert(index, info);
        mainDeviceCardAdded = true;

        log.info('Insert main device to $index.');
      } else {
        // Other device.

        var fixedCardsCount = (localDeviceCardAdded ? 1 : 0) + (mainDeviceCardAdded ? 1 : 0);

        var countDevices = (osType) => _tempList.where((element) => element.deviceOSType == osType).length;

        var devicesCountPerOS = <DeviceOSTypeEnum, int>{};
        for (var osType in DeviceOSTypeEnum.values) {
          devicesCountPerOS[osType] = countDevices(osType);
        }

        var localDeviceOS = _tempList
            .firstWhereOrNull((element) => element.deviceName == instances.deviceInfo.deviceName)
            ?.deviceOSType;
        var mainDeviceOS = _tempList.firstWhereOrNull((element) => element.isMainDevice)?.deviceOSType;

        if (localDeviceOS != null) devicesCountPerOS[localDeviceOS] = devicesCountPerOS[localDeviceOS]! - 1;
        if (mainDeviceOS != null) devicesCountPerOS[mainDeviceOS] = devicesCountPerOS[mainDeviceOS]! - 1;

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

  /// Get device info list length
  int get length => deviceInfoList.length;

  @override
  var serviceStatus = ServiceStatus.pending.obs;

  @override
  var serviceException;

  @override
  Future<DeviceService> init() async {
    serviceStatus.value = ServiceStatus.starting;

    localDeviceCardAdded = false;
    mainDeviceCardAdded = false;

    Timer.periodic(Duration(seconds: config.webServiceDeviceInfoCheckTTLSeconds), (_) {
      var _tempList = deviceInfoList.toList();

      for (var each in _tempList) {
        var now = DateTime.now();
        var time = each.sendTime;

        if (now.difference(time).inSeconds > config.webServiceDeviceInfoTTLSeconds) {
          deviceInfoList.remove(each);

          if (each.deviceName == instances.deviceInfo.deviceName) {
            localDeviceCardAdded = false;

            // If local device removed, restart devices server.
            instances.restartDevicesServer();
          } else if (each.isMainDevice) {
            mainDeviceCardAdded = false;
          }
        }
      }

      deviceInfoList.refresh();
    });

    serviceStatus.value = ServiceStatus.running;

    return this;
  }

  @override
  Future<DeviceService> restart() async {
    return this;
  }

  @override
  Future<DeviceService> stop() async {
    serviceStatus.value = ServiceStatus.stopping;
    deviceInfoList.clear();

    localDeviceCardAdded = false;
    mainDeviceCardAdded = false;

    serviceStatus.value = ServiceStatus.pending;

    return this;
  }
}