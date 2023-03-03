import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher_string.dart';

import 'package:kitx_mobile/services/devices.dart';

import 'package:kitx_mobile/themes/light_theme.dart';
import 'package:kitx_mobile/themes/dark_theme.dart';

class _Global {
  static final _Global _singleton = _Global._internal();

  bool get isRelease => bool.fromEnvironment('dart.vm.product');

  bool get isDebug => !isRelease;

  var deviceName = '';
  var devices = Devices();
  var DeviceError = false;

  var themeNotifier = ValueNotifier(ThemeMode.system);
  var themeMode = ThemeMode.system;

  var animationEnabled = true.obs;

  final version = ''.obs;
  final versionString = ''.obs;

  var packageInfo = PackageInfo.fromPlatform();

  Future<void> init() async {
    await packageInfo.then((value) => version.value = value.version);

    versionString.value = '${version.value}${(isRelease ? ' (Release)' : ' (Debug)')}';
  }

  void delay(Function func, int milliseconds) {
    Future.delayed(Duration(milliseconds: milliseconds)).then((value) => func.call());
  }

  void openUrl(String url, {int delayMilliseconds = 0, LaunchMode mode = LaunchMode.externalApplication}) {
    delay(() => launchUrlString(url, mode: mode), delayMilliseconds);
  }

  void updateTheme({bool useMaterial3 = true}) {
    lightThemeData.value = ThemeData(
      useMaterial3: useMaterial3,
      primarySwatch: Colors.blue,
      brightness: Brightness.light,
    );
    darkThemeData.value = ThemeData(
      useMaterial3: useMaterial3,
      primarySwatch: Colors.blueGrey,
      brightness: Brightness.dark,
    );
  }

  factory _Global() {
    return _singleton;
  }

  _Global._internal();
}

var Global = _Global();
