import 'package:flutter/material.dart';

import 'package:package_info_plus/package_info_plus.dart';
import 'package:get/get.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  final version = "getting ...".obs;

  @override
  void initState() {
    var packageInfo = PackageInfo.fromPlatform();
    packageInfo.then((value) => version.value = value.version);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("AboutPage_Title".tr),
        ),
        body: Center(
            child: ListView(
          padding: EdgeInsets.all(20),
          children: [
            Container(
                padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
                child: InkWell(
                    splashColor: context.iconColor?.withOpacity(0.3),
                    child: const Image(
                      alignment: Alignment.topCenter,
                      image: AssetImage("assets/KitX-Icon-1920x-margin-2x.png"),
                      fit: BoxFit.cover,
                    ))),
            Container(
              alignment: Alignment.center,
              child: Column(
                children: [
                  const Text(
                    "KitX",
                    style: TextStyle(
                      fontSize: 50,
                    ),
                  ),
                  Obx(() => Text("Version: ${version.value}")),
                ],
              ),
            ),
          ],
        )));
  }
}
