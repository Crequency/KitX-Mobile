import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../data/third_party_licenses_provider.dart';

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

  final thirdPartyDataDisplayCount = 1.obs;

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

  Widget getFlexibleSpaceControl(BuildContext context) {
    return FlexibleSpaceBar(
      // title: Text("AboutPage_Title".tr),
      centerTitle: true,
      collapseMode: CollapseMode.parallax,
      background: ListView(
        physics: NeverScrollableScrollPhysics(),
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
              child: AnimatedOpacity(
                  duration: Duration(milliseconds: 500),
                  curve: Curves.easeInCirc,
                  opacity: iconEntering.value ? 1 : 0,
                  child: InkWell(
                      splashColor: context.iconColor?.withOpacity(0.3),
                      child: const Image(
                        alignment: Alignment.center,
                        image:
                            AssetImage("assets/KitX-Icon-1920x-margin-2x.png"),
                        fit: BoxFit.cover,
                      ))))),
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
                    child:
                        Text("${"AboutPage_Version".tr}: ${version.value}"))),
                // Divider(),
              ],
            ),
          ),
        ],
      ),
    );
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
            flexibleSpace: getFlexibleSpaceControl(context),
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
                    AnimatedOpacity(
                      duration: Duration(milliseconds: 800),
                      curve: Curves.easeInCubic,
                      opacity: contentEntering ? 1 : 0,
                      child: Container(
                          alignment: Alignment.center,
                          child: Text("AboutPage_Contributors".tr,
                              style: TextStyle(fontSize: 20))),
                    ),
                    Divider(),
                    AnimatedOpacity(
                      duration: Duration(milliseconds: 800),
                      curve: Curves.easeInCubic,
                      opacity: contentEntering ? 1 : 0,
                      child: Container(
                          height: 40,
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          alignment: Alignment.center,
                          child: ListView(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              physics: BouncingScrollPhysics(),
                              children: [
                                Chip(label: const Text("Dynesshely")),
                                Container(width: 10),
                                Chip(label: const Text("LYF511")),
                                Container(width: 10),
                                Chip(label: const Text("orzMaster")),
                              ])),
                    ),
                    Divider(),
                    AnimatedContainer(
                      duration: Duration(milliseconds: 1000),
                      curve: Curves.easeInOutCubicEmphasized,
                      height: contentEntering ? 20 : 1600,
                    ),
                    AnimatedOpacity(
                      duration: Duration(milliseconds: 1100),
                      curve: Curves.easeInCubic,
                      opacity: contentEntering ? 1 : 0,
                      child: Container(
                          alignment: Alignment.center,
                          child: Text("AboutPage_Repos".tr,
                              style: TextStyle(fontSize: 20))),
                    ),
                    Divider(),
                    AnimatedOpacity(
                      duration: Duration(milliseconds: 1100),
                      curve: Curves.easeInCubic,
                      opacity: contentEntering ? 1 : 0,
                      child: Container(
                          height: 60,
                          alignment: Alignment.center,
                          child: ListView(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              physics: BouncingScrollPhysics(),
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
                    ),
                    Divider(),
                    AnimatedContainer(
                      duration: Duration(milliseconds: 1000),
                      curve: Curves.easeInOutCubicEmphasized,
                      height: contentEntering ? 20 : 2400,
                    ),
                    AnimatedOpacity(
                      duration: Duration(milliseconds: 1400),
                      curve: Curves.easeInCubic,
                      opacity: contentEntering ? 1 : 0,
                      child: Container(
                          alignment: Alignment.center,
                          child: Text("AboutPage_ThirdPartyLicenses".tr,
                              style: TextStyle(fontSize: 20))),
                    ),
                    Divider(),
                    AnimatedOpacity(
                      duration: Duration(milliseconds: 1400),
                      curve: Curves.easeInCubic,
                      opacity: contentEntering ? 1 : 0,
                      child: Container(
                        padding: EdgeInsets.all(15),
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: thirdPartyDataDisplayCount.value,
                          itemBuilder: thirdPartyLicenseBuilder,
                        ),
                        // child: Text("AboutPage_JoinUS_Text".tr),
                      ),
                    ),
                    AnimatedContainer(
                        height: thirdPartyDataDisplayCount.value !=
                                thirdPartyDataList.length
                            ? 55
                            : 0,
                        duration: Duration(milliseconds: 1000),
                        padding: EdgeInsets.fromLTRB(20, 0, 20, 15),
                        child: ElevatedButton(
                            onPressed: () => super.setState(() {
                                  thirdPartyDataDisplayCount.value =
                                      thirdPartyDataList.length;
                                }),
                            child: Text(
                                "AboutPage_ThirdPartyLicenses_DisplayAll".tr))),
                    Divider(),
                    AnimatedContainer(
                      duration: Duration(milliseconds: 1000),
                      curve: Curves.easeInOutCubicEmphasized,
                      height: contentEntering ? 20 : 3200,
                    ),
                    Container(
                        alignment: Alignment.center,
                        child: Text("AboutPage_JoinUS".tr,
                            style: TextStyle(fontSize: 20))),
                    Divider(),
                    Container(
                        padding: EdgeInsets.all(20),
                        child: Text("AboutPage_JoinUS_Text".tr)),
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
  }

  Widget thirdPartyLicenseBuilder(BuildContext context, int index) {
    var thirdPartyData = thirdPartyDataList[index];
    var url = thirdPartyData.ThirdPartyUrl;
    var repo = thirdPartyData.ThirdPartyRepo;
    return Card(
        child: SizedBox(
            width: 300,
            height: 50,
            child: InkWell(
              splashColor: Colors.blue.withAlpha(30),
              onTap: () => print("${thirdPartyData.ThirdPartyName} tapped."),
              child: ListView(
                  shrinkWrap: true,
                  padding: EdgeInsets.all(10),
                  scrollDirection: Axis.horizontal,
                  physics: BouncingScrollPhysics(),
                  children: [
                    IconButton(
                      alignment: Alignment.center,
                      splashRadius: 20,
                      padding: const EdgeInsets.all(0),
                      iconSize: 24,
                      icon: url?.contains("pub.dev") ?? false
                          ? const Icon(CommunityMaterialIcons.link)
                          : const Icon(CommunityMaterialIcons.link),
                      onPressed: () => launchUrl(
                          Uri.parse(thirdPartyData.ThirdPartyUrl ?? "")),
                    ),
                    IconButton(
                      alignment: Alignment.center,
                      splashRadius: 20,
                      padding: const EdgeInsets.all(0),
                      iconSize: 24,
                      icon: repo?.contains("github.com") ?? false
                          ? const Icon(CommunityMaterialIcons.github)
                          : const Icon(CommunityMaterialIcons.link),
                      onPressed: () => launchUrl(
                          Uri.parse(thirdPartyData.ThirdPartyRepo ?? "")),
                    ),
                    Container(
                        alignment: Alignment.center,
                        child: Text(
                          thirdPartyData.ThirdPartyName ?? "null",
                          style: TextStyle(fontSize: 20),
                        )),
                    Text(
                      thirdPartyData.ThirdPartyVersion ?? "null",
                      style: TextStyle(fontSize: 12),
                    ),
                  ]),
            )));
  }
}
