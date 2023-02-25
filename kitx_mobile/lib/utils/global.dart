library kitx_moblie.global;

import 'package:flutter/material.dart';

import '../services/devices.dart';

Devices devices = Devices();

String DeviceName = "";

bool get isRelease => bool.fromEnvironment("dart.vm.product");

bool DeviceError = false;

ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.system);

ThemeMode themeMode = ThemeMode.system;
