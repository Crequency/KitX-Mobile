library kitx_moblie.config;

import 'package:shared_preferences/shared_preferences.dart';

import 'package:kitx_mobile/models/enums/device_os_type.dart';
import 'package:kitx_mobile/utils/global.dart';
import 'package:kitx_mobile/converters/theme_mode_2_int.dart';

class _Config {
  var WebService_UdpBroadcastAddress = '224.0.0.0';
  var WebService_UdpPortReceive = 24040;
  var WebService_UdpPortSend = 23404;
  var WebService_UdpSendFrequency = 1;
  var WebService_DeviceInfoCheckTTLSeconds = 1;
  var WebService_DeviceInfoTTLSeconds = 7;
  var WebService_DeviceOSType = DeviceOSTypeEnum.Android;

  Future<void> loadAsync() async {
    final prefs = await SharedPreferences.getInstance();

    WebService_UdpBroadcastAddress = prefs.getString('WebService_UdpBroadcastAddress') ?? '224.0.0.0';
    WebService_UdpPortReceive = prefs.getInt('WebService_UdpPortReceive') ?? 24040;
    WebService_UdpPortSend = prefs.getInt('WebService_UdpPortSend') ?? 23404;
    WebService_UdpSendFrequency = prefs.getInt('WebService_UdpSendFrequency') ?? 1;
    WebService_DeviceInfoCheckTTLSeconds = prefs.getInt('WebService_DeviceInfoCheckTTLSeconds') ?? 1;
    WebService_DeviceInfoTTLSeconds = prefs.getInt('WebService_DeviceInfoTTLSeconds') ?? 7;

    Global.themeModeNotifier.value = ConvertBack(prefs.getInt('AppThemeMode') ?? 0);
    Global.material3enabled = prefs.getBool('Material3Enabled') ?? true;
    Global.animationEnabled.value = prefs.getBool('AnimationEnabled') ?? true;
  }

  Future<void> saveAsync() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('WebService_UdpBroadcastAddress', WebService_UdpBroadcastAddress);
    await prefs.setInt('WebService_UdpPortReceive', WebService_UdpPortReceive);
    await prefs.setInt('WebService_UdpPortSend', WebService_UdpPortSend);
    await prefs.setInt('WebService_UdpSendFrequency', WebService_UdpSendFrequency);
    await prefs.setInt('WebService_DeviceInfoCheckTTLSeconds', WebService_DeviceInfoCheckTTLSeconds);
    await prefs.setInt('WebService_DeviceInfoTTLSeconds', WebService_DeviceInfoTTLSeconds);

    await prefs.setInt('AppThemeMode', Convert(Global.themeModeNotifier.value));
    await prefs.setBool('Material3Enabled', Global.material3enabled);
    await prefs.setBool('AnimationEnabled', Global.animationEnabled.value);
  }
}

var Config = _Config();
