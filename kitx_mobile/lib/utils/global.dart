import '../services/devices.dart';

class _Global {
  static final _Global _singleton = _Global._internal();
  static bool get isRelease => bool.fromEnvironment("dart.vm.product");
  static bool get isDebug => !isRelease;
  String deviceName = "";
  Devices devices = Devices();

  factory _Global() {
    return _singleton;
  }

  _Global._internal();
}

_Global Global = _Global();
