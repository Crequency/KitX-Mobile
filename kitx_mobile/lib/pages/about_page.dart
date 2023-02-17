import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  final version = "getting ...".obs;
  final iconEntering = false.obs;
  final iconEntered = false.obs;
  final titleEntered = false.obs;
  bool contentEntering = false;

  @override
  void initState() {
    var packageInfo = PackageInfo.fromPlatform();
    packageInfo.then((value) => version.value = value.version);
    Future.delayed(Duration(milliseconds: 150))
        .then((value) => iconEntering.value = true);
    Future.delayed(Duration(milliseconds: 400))
        .then((value) => iconEntered.value = true);
    Future.delayed(Duration(milliseconds: 600))
        .then((value) => titleEntered.value = true);
    Future.delayed(Duration(milliseconds: 0))
        .then((value) => super.setState(() {
              contentEntering = true;
            }));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            snap: false,
            floating: false,
            // expandedHeight: entered ? 380.0 : 380.0,
            expandedHeight: 320.0,
            title: Text("AboutPage_Title".tr),
            flexibleSpace: FlexibleSpaceBar(
              // title: Text("AboutPage_Title".tr),
              centerTitle: true,
              collapseMode: CollapseMode.parallax,
              background: ListView(
                children: [
                  Container(height: 30),
                  Obx(() => AnimatedContainer(
                      duration: const Duration(milliseconds: 800),
                      curve: Curves.easeInOutCubicEmphasized,
                      alignment: Alignment.topCenter,
                      padding: iconEntering.value
                          ? EdgeInsets.fromLTRB(100, 0, 100, 0)
                          : EdgeInsets.all(0),
                      // onEnd: () => super.setState(() {
                      //       entered = true;
                      //     }),
                      child: InkWell(
                          splashColor: context.iconColor?.withOpacity(0.3),
                          child: const Image(
                            alignment: Alignment.center,
                            image: AssetImage(
                                "assets/KitX-Icon-1920x-margin-2x.png"),
                            fit: BoxFit.cover,
                          )))),
                  Container(
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        Obx(() => AnimatedOpacity(
                              opacity: iconEntered.value ? 1 : 0,
                              duration: Duration(milliseconds: 300),
                              curve: Curves.easeInCubic,
                              child: const Text(
                                "KitX",
                                style: TextStyle(
                                  fontSize: 50,
                                ),
                              ),
                            )),
                        Obx(() => AnimatedOpacity(
                            opacity: titleEntered.value ? 1 : 0,
                            duration: Duration(milliseconds: 500),
                            curve: Curves.easeInOutCubic,
                            child: Text(
                                "${"AboutPage_Version".tr}: ${version.value}"))),
                        // Divider(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return ListView(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    AnimatedContainer(
                      duration: Duration(milliseconds: 1000),
                      curve: Curves.easeInOutCubicEmphasized,
                      height: contentEntering ? 0 : 800,
                    ),
                    Container(
                        alignment: Alignment.center,
                        child: Text("AboutPage_Contributors".tr,
                            style: TextStyle(fontSize: 20))),
                    Divider(),
                    Container(
                        height: 40,
                        alignment: Alignment.center,
                        child: ListView(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            children: [
                              Chip(label: const Text("Dynesshely")),
                              Container(width: 10),
                              Chip(label: const Text("LYF511")),
                              Container(width: 10),
                              Chip(label: const Text("orzMaster")),
                            ])),
                    Divider(),
                    AnimatedContainer(
                      duration: Duration(milliseconds: 1000),
                      curve: Curves.easeInOutCubicEmphasized,
                      height: contentEntering ? 20 : 1600,
                    ),
                    Container(
                        alignment: Alignment.center,
                        child: Text("AboutPage_Repos".tr,
                            style: TextStyle(fontSize: 20))),
                    Divider(),
                    Container(
                        height: 60,
                        alignment: Alignment.center,
                        child: ListView(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            padding: EdgeInsets.all(10),
                            children: [
                              ElevatedButton(
                                  onPressed: () => launchUrl(Uri.parse(
                                      "https://github.com/Crequency/KitX")),
                                  child: Text("GitHub")),
                              Container(width: 10),
                              ElevatedButton(
                                  onPressed: () => launchUrl(Uri.parse(
                                      "https://gitee.com/Crequency/KitX")),
                                  child: Text("Gitee")),
                            ])),
                    Divider(),
                    Container(height: 500),
                  ],
                );
              },
              childCount: 1,
            ),
          ),
        ],
      ),
    );

    // return Scaffold(
    //     appBar: AppBar(
    //       title: Text("AboutPage_Title".tr),
    //     ),
    //     body: Center(
    //         child: ListView(
    //       padding: EdgeInsets.all(20),
    //       children: [
    //         Obx(() => AnimatedContainer(
    //             duration: const Duration(milliseconds: 1000),
    //             curve: Curves.easeInOutCubicEmphasized,
    //             alignment: Alignment.topCenter,
    //             padding: entering.value
    //                 ? EdgeInsets.fromLTRB(80, 0, 80, 0)
    //                 : EdgeInsets.all(40),
    //             // onEnd: () => entering = true,
    //             child: InkWell(
    //                 splashColor: context.iconColor?.withOpacity(0.3),
    //                 child: const Image(
    //                   alignment: Alignment.center,
    //                   image: AssetImage("assets/KitX-Icon-1920x-margin-2x.png"),
    //                   fit: BoxFit.cover,
    //                 )))),
    //         Container(
    //           alignment: Alignment.center,
    //           child: Column(
    //             children: [
    //               const Text(
    //                 "KitX",
    //                 style: TextStyle(
    //                   fontSize: 50,
    //                 ),
    //               ),
    //               Obx(() => Text("${"AboutPage_Version".tr}: ${version.value}")),
    //               Divider(),
    //             ],
    //           ),
    //         ),
    //         Container(height: 20),
    //         Container(
    //             alignment: Alignment.center,
    //             child: Text("AboutPage_Contributors".tr, style: TextStyle(fontSize: 20))),
    //         Divider(),
    //         Container(
    //             height: 40,
    //             alignment: Alignment.center,
    //             child: ListView(
    //                 // Wrap(
    //                 //   spacing: 8.0,
    //                 //   runSpacing: -4.0,
    //                 //   alignment: WrapAlignment.center,
    //
    //                 shrinkWrap: true,
    //                 scrollDirection: Axis.horizontal,
    //                 // physics: NeverScrollableScrollPhysics(),
    //
    //                 children: [
    //                   Chip(label: const Text("Dynesshely")),
    //                   Container(width: 10),
    //                   Chip(label: const Text("LYF511")),
    //                   Container(width: 10),
    //                   Chip(label: const Text("orzMaster")),
    //                 ])),
    //         Divider(),
    //         Container(height: 20),
    //         Container(
    //             alignment: Alignment.center,
    //             child: Text("AboutPage_Repos".tr, style: TextStyle(fontSize: 20))),
    //         Divider(),
    //         Container(
    //             height: 60,
    //             alignment: Alignment.center,
    //             child: ListView(
    //                 // Wrap(
    //                 //   spacing: 8.0,
    //                 //   runSpacing: -4.0,
    //                 //   alignment: WrapAlignment.center,
    //
    //                 shrinkWrap: true,
    //                 scrollDirection: Axis.horizontal,
    //                 padding: EdgeInsets.all(10),
    //                 // physics: NeverScrollableScrollPhysics(),
    //
    //                 children: [
    //                   ElevatedButton(
    //                       onPressed: () => launchUrl(
    //                           Uri.parse("https://github.com/Crequency/KitX")),
    //                       child: Text("GitHub")),
    //                   Container(width: 10),
    //                   ElevatedButton(
    //                       onPressed: () => launchUrl(
    //                           Uri.parse("https://gitee.com/Crequency/KitX")),
    //                       child: Text("Gitee")),
    //                 ])),
    //         Divider(),
    //         Container(height: 300),
    //       ],
    //     )));
  }
}
