import 'dart:async';

// import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/config.dart';
import '../utils/global.dart' as global;
import '../rules/device_info_struct.dart';


class Devices {
    final deviceInfoList = RxList<DeviceInfo>([]);
    bool lock = true;
    // late Widget widget;

    Devices();

    Future<void> addDevice(DeviceInfo info) async {
        if (deviceInfoList.length == 0) {
            deviceInfoList.add(info);
        } else {
            List<DeviceInfo> _tempList = deviceInfoList.toList();
            bool _tag = true;
            _tempList.forEach((each) {
                if (each.iPv4 == info.iPv4 || each.deviceMacAddress == info.deviceMacAddress) {
                    deviceInfoList[deviceInfoList.indexOf(each)].sendTime = info.sendTime;
                    deviceInfoList.refresh();
                    _tag = false;
                }
            });
            if (_tag) {
                if (info.deviceName == global.DeviceName) {
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
            List<DeviceInfo> _tempList = deviceInfoList.toList();
            _tempList.forEach((each) {
                DateTime now = DateTime.now();
                DateTime time = each.sendTime;
                if (now.difference(time).inSeconds > Config.WebService_DeviceInfoTTLSeconds) {
                    deviceInfoList.remove(each);
                    deviceInfoList.refresh();
                }
            });
        });
    }

    int get length => deviceInfoList.length;
}
