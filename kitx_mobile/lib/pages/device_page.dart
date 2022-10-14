import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import '../rules/device_info_struct.dart';

class DevicePage extends StatefulWidget {
  const DevicePage({Key? key}) : super(key: key);

  @override
  State<DevicePage> createState() => _DevicePage();
}

class _DevicePage extends State<DevicePage> {
  // void _onPressed() {}

  @override
  Widget build(BuildContext context) {
    imageCache.clear();
    return Scaffold(
      appBar: AppBar(
        title: Text(FlutterI18n.translate(context, "devicePage.title")),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        // mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(3, (index) => getItemContainer(index)),
      ),
      // ),
    );
  }
}

Widget createDeviceCard(DeviceInfo info) {
  Icon _icon = Icon(Icons.help);
  switch (info.deviceOSType) {
    case 0 :{
      _icon = Icon(Icons.android);
    }
  }
  return Padding(
    padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
    child: Row(
        // mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Card(
            child: Container(
              margin: EdgeInsets.all(10),
              child: Column(

                crossAxisAlignment: CrossAxisAlignment.center,
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                // mainAxisSize: MainAxisSize.max,
                // children: <Widget>[
                //   Column(
                children: <Widget>[
                  Row(
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    // mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      _icon,
                      Column(
                        children: [
                          Text(info.deviceName),
                          Text(info.deviceOSVersion),
                        ],
                      ),
                    ],
                  ),
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  // children: [
                  Text(
                    info.sendTime,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    FlutterI18n.translate(context, "devicePage.title"),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    info.iPv4,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 10,
                    ),
                  ),
                  Text(
                    info.iPv6,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
          )
        ]),
  );
}
