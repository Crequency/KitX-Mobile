import 'dart:async';

// import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/config.dart';
import '../utils/global.dart' as global;
// import '../rules/device_info_struct.dart';
import '../models/device_info.dart';

class Devices {
  final deviceInfoList = RxList<DeviceInfoStruct>([]);
  bool lock = true;
  // late Widget widget;

  Devices();

  Future<void> addDevice(DeviceInfoStruct info) async {
    if (deviceInfoList.length == 0) {
      deviceInfoList.add(info);
    } else {
      List<DeviceInfoStruct> _tempList = deviceInfoList.toList();
      bool _tag = true;
      _tempList.forEach((each) {
        if (each.IPv4 == info.IPv4 || each.DeviceMacAddress == info.DeviceMacAddress) {
          deviceInfoList[deviceInfoList.indexOf(each)] = each.rebuild((b) => b..SendTime = info.SendTime);
          deviceInfoList.refresh();
          _tag = false;
        }
      });
      if (_tag) {
        if (info.DeviceName == global.DeviceName) {
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
      List<DeviceInfoStruct> _tempList = deviceInfoList.toList();
      _tempList.forEach((each) {
        DateTime now = DateTime.now();
        DateTime time = each.SendTime;
        if (now.difference(time).inSeconds > Config.WebService_DeviceInfoTTLSeconds) {
          deviceInfoList.remove(each);
        }
      });
      deviceInfoList.refresh();
    });
  }

  int get length => deviceInfoList.length;
}
