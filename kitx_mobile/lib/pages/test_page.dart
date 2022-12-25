import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'test_pages/device_test.dart';
import 'test_pages/network_info_test.dart';

class TestPage extends StatefulWidget {
    const TestPage({Key? key}) : super(key: key);

    @override
    State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
    // int _counter = 0;
    //
    // void _incrementCounter() {
    //     setState(() {
    //         _counter++;
    //     });
    // }

    @override
    Widget build(BuildContext context) {
        return DefaultTabController(
            initialIndex: 0,
            length: 3,
            child: Scaffold(
                appBar: AppBar(
                    title: Text("TestPage_Title".tr),
                    bottom: TabBar(
                        tabs: <Widget>[
                            Tab(
                                text: "Device Info",
                                icon: Icon(Icons.devices),
                            ),
                            Tab(
                                text: "NetworkInfo",
                                icon: Icon(Icons.wifi),
                            ),
                            Tab(
                                icon: Icon(Icons.brightness_5_sharp),
                            ),
                        ],
                    ),
                ),
                body: TabBarView(
                    children: <Widget>[
                        Center(
                            child: DeviceTestPage(),
                        ),
                        Center(
                            child: networkInfoTestPage(),
                        ),
                        Center(
                            child: Text("It's sunny here"),
                        ),
                    ],
                ),
            ),
        );
    }
}
