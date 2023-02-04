library kitx_moblie.global;

import '../services/devices.dart';

Devices devices = Devices();

String DeviceName = "";

bool get isRelease => bool.fromEnvironment("dart.vm.product");

bool DeviceError = false;
