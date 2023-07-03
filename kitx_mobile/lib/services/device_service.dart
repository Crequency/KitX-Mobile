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

    if (deviceInfoList.isEmpty) {
      Log.info('Add ${info.deviceOSType} device to first.');

      deviceInfoList.add(info);
    } else {
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

          Log.info('Insert local device to 0.');

          deviceInfoList.insert(0, info);
          localDeviceCardAdded = true;
        } else if (info.isMainDevice) {
          // Main device.

          if (localDeviceCardAdded) {
            Log.info('Insert main device to 1.');

            deviceInfoList.insert(1, info);
          } else {
            Log.info('Insert main device to 0.');

            deviceInfoList.insert(0, info);
          }
          mainDeviceCardAdded = true;
        } else {
          // Other device.

          var previousOS = (DeviceOSTypeEnum source) {
            switch (source) {
              case DeviceOSTypeEnum.iOS:
                return DeviceOSTypeEnum.Android;
              case DeviceOSTypeEnum.Android:
                return DeviceOSTypeEnum.MacOS;
              case DeviceOSTypeEnum.MacOS:
                return DeviceOSTypeEnum.Linux;
              case DeviceOSTypeEnum.Linux:
                return DeviceOSTypeEnum.Windows;
              default:
                return DeviceOSTypeEnum.Windows;
            }
          };

          var nextOS = (DeviceOSTypeEnum source) {
            switch (source) {
              case DeviceOSTypeEnum.Windows:
                return DeviceOSTypeEnum.Linux;
              case DeviceOSTypeEnum.Linux:
                return DeviceOSTypeEnum.MacOS;
              case DeviceOSTypeEnum.MacOS:
                return DeviceOSTypeEnum.Android;
              case DeviceOSTypeEnum.Android:
                return DeviceOSTypeEnum.iOS;
              default:
                return DeviceOSTypeEnum.iOS;
            }
          };

          var preOS = previousOS(info.deviceOSType);
          var nxtOS = nextOS(info.deviceOSType);
          var fixedCardsCount = (localDeviceCardAdded ? 1 : 0) + (mainDeviceCardAdded ? 1 : 0);

          var sameIndex = _tempList.lastIndexWhere(
            (element) => element.deviceOSType == info.deviceOSType,
            fixedCardsCount,
          ); // Same OS last item index.
          var lastIndex = _tempList.lastIndexWhere(
            (element) => element.deviceOSType == preOS,
            fixedCardsCount,
          ); // Previous OS last item index.
          var instIndex = _tempList.indexWhere(
            (element) => element.deviceOSType == nxtOS,
            fixedCardsCount,
          ); // Next OS first item index.

          var ttlLast = 5;
          while (lastIndex == -1) {
            lastIndex = _tempList.lastIndexWhere(
              (element) => element.deviceOSType == previousOS(preOS),
              fixedCardsCount,
            );
            --ttlLast;
            if (ttlLast <= 0) {
              break;
            }
          }

          var ttlInst = 5;
          while (instIndex == -1) {
            instIndex = _tempList.indexWhere(
              (element) => element.deviceOSType == nextOS(nxtOS),
              fixedCardsCount,
            );
            --ttlInst;
            if (ttlInst <= 0) {
              break;
            }
          }

          if (sameIndex != -1) {
            var index = sameIndex + 1;

            Log.info(
                'Insert ${info.deviceOSType} device to $index, sameIndex = $sameIndex, lastIndex = $lastIndex, instIndex = $instIndex');

            deviceInfoList.insert(index, info);
          } else if (lastIndex != -1) {
            var index = lastIndex + 1;

            Log.info(
                'Insert ${info.deviceOSType} device to $index, sameIndex = $sameIndex, lastIndex = $lastIndex, instIndex = $instIndex');

            deviceInfoList.insert(index, info);
          } else if (instIndex != -1) {
            Log.info(
                'Insert ${info.deviceOSType} device to $instIndex, sameIndex = $sameIndex, lastIndex = $lastIndex, instIndex = $instIndex');

            deviceInfoList.insert(instIndex, info);
          } else {
            if (info.deviceOSType == DeviceOSTypeEnum.Windows) {
              var index = (localDeviceCardAdded ? 1 : 0) + (mainDeviceCardAdded ? 1 : 0) + 1;

              Log.info(
                  'Insert ${info.deviceOSType} device to $index, sameIndex = $sameIndex, lastIndex = $lastIndex, instIndex = $instIndex');

              deviceInfoList.insert(index, info);
            } else {
              Log.info(
                  'Append ${info.deviceOSType} device to last, sameIndex = $sameIndex, lastIndex = $lastIndex, instIndex = $instIndex');

              deviceInfoList.add(info);
            }
          }
        }
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
