import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DeviceInfoTestPage extends StatefulWidget {
  const DeviceInfoTestPage({Key? key}) : super(key: key);

  @override
  State<DeviceInfoTestPage> createState() => _DeviceInfoTestPageState();
}

class _DeviceInfoTestPageState extends State<DeviceInfoTestPage> {
  static final deviceInfoPlugin = DeviceInfoPlugin();
  var _deviceData = <String, dynamic>{};

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  void initPlatformState() async {
    var deviceData = <String, dynamic>{};

    try {
      if (Platform.isAndroid) {
        deviceData = _readAndroidDeviceInfo(await deviceInfoPlugin.androidInfo);
      } else if (Platform.isIOS) {
        deviceData = _readIosDeviceInfo(await deviceInfoPlugin.iosInfo);
      }
    } on PlatformException {
      deviceData = <String, dynamic>{"Error:": "Failed to get platform version."};
    }

    if (!mounted) return;

    setState(() => _deviceData = deviceData);
  }

  Map<String, dynamic> _readAndroidDeviceInfo(AndroidDeviceInfo build) {
    return <String, dynamic>{
      "Security Patch": build.version.securityPatch,
      "SDK Version": build.version.sdkInt,
      "Android Release": build.version.release,
      "Preview SDK Version": build.version.previewSdkInt,
      "Version Incremental": build.version.incremental,
      "Version Codename": build.version.codename,
      "Base OS": build.version.baseOS,
      "Board": build.board,
      "BootLoader": build.bootloader,
      "Brand": build.brand,
      "Device": build.device,
      "Display": build.display,
      "Fingerprint": build.fingerprint,
      "Hardware": build.hardware,
      "Host": build.host,
      "ID": build.id,
      "Manufacturer": build.manufacturer,
      "Model": build.model,
      "Product": build.product,
      "Supported 32bit ABIs": build.supported32BitAbis,
      "Supported 64bit ABIs": build.supported64BitAbis,
      "Supported ABIs": build.supportedAbis,
      "Build Tags": build.tags,
      "Build Type": build.type,
      "Is physical device": build.isPhysicalDevice,
      "System Features": build.systemFeatures,
      "Display Size Inches": ((build.displayMetrics.sizeInches * 10).roundToDouble() / 10),
      "Display Width Pixels": build.displayMetrics.widthPx,
      "Display Width Inches": build.displayMetrics.widthInches,
      "Display Height Pixels": build.displayMetrics.heightPx,
      "Display Height Inches": build.displayMetrics.heightInches,
      "Display X DPI": build.displayMetrics.xDpi,
      "Display Y DPI": build.displayMetrics.yDpi,
    };
  }

  Map<String, dynamic> _readIosDeviceInfo(IosDeviceInfo data) {
    return <String, dynamic>{
      "Name": data.name,
      "System Name": data.systemName,
      "System Version": data.systemVersion,
      "Model": data.model,
      "Localized Model": data.localizedModel,
      "Identifier for Vendor": data.identifierForVendor,
      "Is physical device": data.isPhysicalDevice,
      "[uts name] System Name": data.utsname.sysname,
      "[uts name] Node Name": data.utsname.nodename,
      "[uts name] Release": data.utsname.release,
      "[uts name] Version": data.utsname.version,
      "[uts name] Machine": data.utsname.machine,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: _deviceData.keys.map(
          (property) {
            return Row(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.fromLTRB(30, 10, 10, 10),
                  child: Text(
                    property,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(10, 10, 30, 10),
                    child: Text(
                      '${_deviceData[property]}',
                      maxLines: 10,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            );
          },
        ).toList(),
      ),
    );
  }
}
