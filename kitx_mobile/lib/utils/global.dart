import 'package:flutter/material.dart';

import 'package:kitx_mobile/services/devices.dart';

class _Global {
  static final _Global _singleton = _Global._internal();

  static bool get isRelease => bool.fromEnvironment("dart.vm.product");
  static bool get isDebug => !isRelease;

  var deviceName = "";
  var devices = Devices();
  var DeviceError = false;

  var themeNotifier = ValueNotifier(ThemeMode.system);
  var themeMode = ThemeMode.system;

  void delay(Function func, int milliseconds) {
    Future.delayed(Duration(milliseconds: milliseconds)).then((value) => func.call());
  }

  factory _Global() {
    return _singleton;
  }

  _Global._internal();
}

var Global = _Global();
