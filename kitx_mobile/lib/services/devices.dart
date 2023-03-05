import 'dart:async';

import 'package:get/get.dart';

import 'package:kitx_mobile/utils/config.dart';
import 'package:kitx_mobile/utils/global.dart';
import 'package:kitx_mobile/models/device_info.dart';

class Devices {
  final deviceInfoList = RxList<DeviceInfoStruct>([]);
  var lock = true;

  Devices();

  Future<void> addDevice(DeviceInfoStruct info) async {
    if (deviceInfoList.length == 0) {
      deviceInfoList.add(info);
    } else {
      var _tempList = deviceInfoList.toList();
      var _tag = true;

      _tempList.forEach(
        (each) {
          if (each.iPv4 == info.iPv4 || each.deviceMacAddress == info.deviceMacAddress) {
            deviceInfoList[deviceInfoList.indexOf(each)] = each.rebuild(
              (b) {
                b
                  ..sendTime = info.sendTime
                  ..isMainDevice = info.isMainDevice;
              },
            );
            deviceInfoList.refresh();
            _tag = false;
          }
        },
      );

      if (_tag) {
        if (info.deviceName == Global.deviceName) {
          deviceInfoList.insert(0, info);
        } else {
          deviceInfoList.add(info);
        }
        deviceInfoList.refresh();
      }
    }
  }

  Future<void> init() async {
    Timer.periodic(Duration(seconds: Config.WebService_DeviceInfoCheckTTLSeconds), (_) {
      var _tempList = deviceInfoList.toList();

      _tempList.forEach((each) {
        var now = DateTime.now();
        var time = each.sendTime;

        if (now.difference(time).inSeconds > Config.WebService_DeviceInfoTTLSeconds) {
          deviceInfoList.remove(each);
        }
      });

      deviceInfoList.refresh();
    });
  }

  int get length => deviceInfoList.length;
}
