import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

class DevicePage extends StatefulWidget {
  const DevicePage({Key? key}) : super(key: key);

  @override
  State<DevicePage> createState() => _DevicePage();
}

class _DevicePage extends State<DevicePage> {
  void _onPressed() {}

  @override
  Widget build(BuildContext context) {
    imageCache.clear();
    return Scaffold(
      appBar: AppBar(
        title: Text(FlutterI18n.translate(context, "devicePage.title")),
      ),
      // body: ListView(
      //   children: <Widget>[
      //     Card(
      //       margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
      //       child: Column(
      //         children: <Widget>[
      //           const ListTile(
      //             leading: Icon(Icons.android),
      //             title: Text("Android"),
      //             subtitle: Text("Android"),
      //           ),
      //           // Row(
      //           //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //           //   // mainAxisSize: MainAxisSize.max,
      //           //   children: <Widget>[
      //           //     Column(
      //           //       // mainAxisSize: MainAxisSize.max,
      //           //       // crossAxisAlignment: CrossAxisAlignment.start,
      //           //       children: <Widget>[
      //           //         Text(
      //           //           "2020.10.07",
      //           //           // textAlign: TextAlign.left,
      //           //         ),
      //           //         Text(
      //           //           "在线插件数量:0",
      //           //           // textAlign: TextAlign.left,
      //           //         )
      //           //       ],
      //           //     ),
      //           //     TextButton(
      //           //       style: ButtonStyle(
      //           //         alignment: Alignment(0, 0),
      //           //       ),
      //           //       onPressed: _onPressed,
      //           //       child: Text(
      //           //         "从控",
      //           //         textAlign: TextAlign.right,
      //           //       ),
      //           //     ),
      //           //   ],
      //           // )
      //         ],
      //       ),
      //     )
      //   ],
      // ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        // mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(2, (index) => getItemContainer()),
      ),
      // ),
    );
  }
}

Widget getItemContainer() {
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
                children: [
                  Row(
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    // mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Icon(Icons.android, size: 36,),
                      Column(
                        children: [
                          Text("Android 8"),
                          Text("Android SDK 8"),
                        ],
                      ),
                    ],
                  ),
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  // children: [
                  Text(
                    "2022.10.07 21:19:14",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    "在线插件数: 0",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    "192.168.1.1",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 10,
                    ),
                  ),
                  Text(
                    "2001:0db8:85a3:08d3:1319:8a2e:0370:7344",
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
