import 'dart:async';

// import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../rules/device_info_struct.dart';


class Devices {
  final deviceInfoList = RxList<DeviceInfo>([]);
  bool lock = true;
  // late Widget widget;

  Devices();

  void addDevice(DeviceInfo info) {
    if (deviceInfoList.length == 0) {
      deviceInfoList.add(info);
    } else {
      List<DeviceInfo> _tempList = deviceInfoList.toList();
      bool _tag = true;
      _tempList.forEach((each) {
        if (each.iPv4 == info.iPv4 || each.deviceMacAddress == info.deviceMacAddress) {
          _tag = false;
        }
      });
      if (_tag) {
        deviceInfoList.add(info);
        deviceInfoList.refresh();
      }
    }
  }

  Future<void> init() async {
    Timer.periodic(Duration(seconds: 10), (_) {
      List<DeviceInfo> _tempList = deviceInfoList.toList();
      _tempList.forEach((each) {
        DateTime now = DateTime.now();
        DateTime time = DateTime.parse(each.sendTime);
        if (now.difference(time).inSeconds > 10) {
          deviceInfoList.remove(each);
          deviceInfoList.refresh();
        }
      });
    });
  }

  int get length => deviceInfoList.length;
}
