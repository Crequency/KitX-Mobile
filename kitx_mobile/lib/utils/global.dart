import 'package:flutter/material.dart';

import '../services/devices.dart';

class _Global {
  static final _Global _singleton = _Global._internal();
  static bool get isRelease => bool.fromEnvironment("dart.vm.product");
  static bool get isDebug => !isRelease;
  String deviceName = "";
  Devices devices = Devices();
  bool DeviceError = false;

  ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.system);

  ThemeMode themeMode = ThemeMode.system;

  void delay(Function func, int milliseconds) {
    Future.delayed(Duration(milliseconds: milliseconds))
        .then((value) => func.call());
  }

  factory _Global() {
    return _singleton;
  }

  _Global._internal();
}

_Global Global = _Global();
