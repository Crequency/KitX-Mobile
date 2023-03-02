import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:vibration/vibration.dart';

import 'package:kitx_mobile/data/third_party_licenses_provider.dart';
import 'package:kitx_mobile/utils/global.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  final iconEntering = false.obs;
  final iconEntered = false.obs;
  final titleEntered = false.obs;

  final titleDisplay = true.obs;
  final versionDisplay = true.obs;

  var contentEntering = false;

  var _scrollController = ScrollController();

  final thirdPartyDataDisplayCount = 1.obs;

  Future<void> vibrate() async {
    if (await Vibration.hasCustomVibrationsSupport() ?? false) {
      Vibration.vibrate(duration: 200);
    } else if (await Vibration.hasVibrator() ?? false) {
      Vibration.vibrate();
    }
  }

  @override
  void initState() {
    _scrollController.addListener(() {
      // print('Scroller offset: ${_scrollController.offset}');

      var offset = _scrollController.offset;

      if (offset >= 50) {
        if (titleDisplay.value) titleDisplay.value = false;
      } else if (offset >= 5) {
        if (!titleDisplay.value) titleDisplay.value = true;
        if (versionDisplay.value) versionDisplay.value = false;
      } else {
        if (!titleDisplay.value) titleDisplay.value = true;
        if (!versionDisplay.value) versionDisplay.value = true;
      }
    });

    Future.delayed(Duration(milliseconds: 150)).then((value) => iconEntering.value = true);

    Future.delayed(Duration(milliseconds: 400)).then((value) => iconEntered.value = true);

    Future.delayed(Duration(milliseconds: 600)).then((value) => titleEntered.value = true);

    Future.delayed(Duration(milliseconds: 0)).then((value) => super.setState(() {
          contentEntering = true;
        }));

    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();

    super.dispose();
  }

  Widget getFlexibleSpaceControl(BuildContext context) {
    return FlexibleSpaceBar(
      // title: Text('AboutPage_Title'.tr),
      centerTitle: true,
      collapseMode: CollapseMode.parallax,
      background: ListView(
        physics: NeverScrollableScrollPhysics(),
        children: [
          SizedBox(height: 30),
          Obx(
            () => AnimatedContainer(
              duration: const Duration(milliseconds: 800),
              curve: Curves.easeInOutCubicEmphasized,
              alignment: Alignment.topCenter,
              margin: EdgeInsets.only(top: 25),
              width: iconEntering.value ? 184 : 384,
              height: iconEntering.value ? 184 : 384,
              // padding: iconEntering.value
              //     ? EdgeInsets.fromLTRB(100, 0, 100, 0)
              //     : EdgeInsets.all(0),
              // onEnd: () => super.setState(() {
              //       entered = true;
              //     }),
              child: AnimatedOpacity(
                duration: Duration(milliseconds: 500),
                curve: Curves.easeInCirc,
                opacity: iconEntering.value ? 1 : 0,
                child: InkWell(
                  borderRadius: BorderRadius.all(Radius.elliptical(15, 15)),
                  onTap: () async => await vibrate(),
                  child: const Image(
                    alignment: Alignment.center,
                    image: AssetImage('assets/KitX-Icon-1920x-margin-2x.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: Column(
              children: [
                Obx(
                  () => AnimatedOpacity(
                    opacity: iconEntered.value && titleDisplay.value ? 1 : 0,
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInCubic,
                    child: const Text(
                      'KitX',
                      style: TextStyle(
                        // color: Colors.white,
                        fontSize: 50,
                      ),
                    ),
                  ),
                ),
                Obx(
                  () => AnimatedOpacity(
                    opacity: titleEntered.value && versionDisplay.value ? 1 : 0,
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeInOutCubic,
                    child: Text(
                      '${'AboutPage_Version'.tr}: ${Global.versionString.value}',
                      // style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
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
        controller: _scrollController,
        slivers: [
          SliverAppBar(
            pinned: true,
            snap: false,
            floating: false,
            // expandedHeight: entered ? 380.0 : 380.0,
            expandedHeight: 345.0,
            title: Text('AboutPage_Title'.tr),
            flexibleSpace: getFlexibleSpaceControl(context),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              childCount: 1,
              (context, index) {
                return ListView(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    AnimatedContainer(
                      duration: Duration(milliseconds: 1000),
                      curve: Curves.easeInOutCubicEmphasized,
                      height: contentEntering ? 0 : 800,
                    ),
                    SizedBox(height: 30),
                    AnimatedOpacity(
                      duration: Duration(milliseconds: 800),
                      curve: Curves.easeInCubic,
                      opacity: contentEntering ? 1 : 0,
                      child: Container(
                        alignment: Alignment.center,
                        child: Text(
                          'AboutPage_Contributors'.tr,
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                    SizedBox(height: 60),
                    AnimatedOpacity(
                      duration: Duration(milliseconds: 800),
                      curve: Curves.easeInCubic,
                      opacity: contentEntering ? 1 : 0,
                      child: Container(
                        height: 40,
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        alignment: Alignment.center,
                        child: ShaderMask(
                          shaderCallback: (Rect rect) {
                            return LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [
                                Colors.indigo,
                                Colors.transparent,
                                Colors.transparent,
                                Colors.indigo,
                              ],
                              stops: [0.0, 0.05, 0.95, 1.0], // 10% indigo, 80% transparent, 10% purple
                            ).createShader(rect);
                          },
                          blendMode: BlendMode.dstOut,
                          child: ListView(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              physics: BouncingScrollPhysics(),
                              children: [
                                AnimatedContainer(
                                  duration: const Duration(milliseconds: 1200),
                                  curve: Curves.easeInOutCubicEmphasized,
                                  width: contentEntering ? 15 : 800,
                                ),
                                Chip(
                                  label: const Text('Dynesshely'),
                                  deleteIcon: const Icon(Icons.open_in_new),
                                  onDeleted: () => Global.openUrl('https://github.com/Dynesshely'),
                                  deleteButtonTooltipMessage: '',
                                ),
                                SizedBox(width: 10),
                                Chip(
                                  label: const Text('LYF511'),
                                  deleteIcon: const Icon(Icons.open_in_new),
                                  onDeleted: () => Global.openUrl('https://github.com/LYF511'),
                                  deleteButtonTooltipMessage: '',
                                ),
                                SizedBox(width: 10),
                                Chip(
                                  label: const Text('orzMaster'),
                                  deleteIcon: const Icon(Icons.open_in_new),
                                  onDeleted: () => Global.openUrl('https://github.com/orzMaster'),
                                  deleteButtonTooltipMessage: '',
                                ),
                                SizedBox(width: 15),
                              ]),
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    Divider(),
                    AnimatedContainer(
                      duration: Duration(milliseconds: 1000),
                      curve: Curves.easeInOutCubicEmphasized,
                      height: contentEntering ? 20 : 1600,
                    ),
                    SizedBox(height: 60),
                    AnimatedOpacity(
                      duration: Duration(milliseconds: 1100),
                      curve: Curves.easeInCubic,
                      opacity: contentEntering ? 1 : 0,
                      child: Container(
                        alignment: Alignment.center,
                        child: Text(
                          'AboutPage_Repos'.tr,
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
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
                                onPressed: () => Global.openUrl('https://github.com/Crequency/KitX'),
                                child: Text('GitHub'),
                              ),
                              Container(width: 10),
                              ElevatedButton(
                                onPressed: () => Global.openUrl('https://gitee.com/Crequency/KitX'),
                                child: Text('Gitee'),
                              ),
                            ]),
                      ),
                    ),
                    SizedBox(height: 30),
                    Divider(),
                    AnimatedContainer(
                      duration: Duration(milliseconds: 1000),
                      curve: Curves.easeInOutCubicEmphasized,
                      height: contentEntering ? 20 : 2400,
                    ),
                    SizedBox(height: 60),
                    AnimatedOpacity(
                      duration: Duration(milliseconds: 1400),
                      curve: Curves.easeInCubic,
                      opacity: contentEntering ? 1 : 0,
                      child: Container(
                        alignment: Alignment.center,
                        child: Text(
                          'AboutPage_ThirdPartyLicenses'.tr,
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
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
                      ),
                    ),
                    AnimatedContainer(
                      height: thirdPartyDataDisplayCount.value != thirdPartyDataList.length ? 55 : 0,
                      duration: Duration(milliseconds: 1000),
                      padding: EdgeInsets.fromLTRB(20, 0, 20, 15),
                      child: ElevatedButton(
                        onPressed: () => Global.delay(
                            () => super.setState(() {
                                  thirdPartyDataDisplayCount.value = thirdPartyDataList.length;
                                }),
                            200),
                        child: Text('AboutPage_ThirdPartyLicenses_DisplayAll'.tr),
                      ),
                    ),
                    SizedBox(height: 30),
                    Divider(),
                    AnimatedContainer(
                      duration: Duration(milliseconds: 1000),
                      curve: Curves.easeInOutCubicEmphasized,
                      height: contentEntering ? 20 : 3200,
                    ),
                    SizedBox(height: 60),
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        'AboutPage_JoinUS'.tr,
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    Divider(),
                    Container(
                      padding: EdgeInsets.all(20),
                      child: Text('AboutPage_JoinUS_Text'.tr),
                    ),
                    Divider(),
                    SizedBox(height: 500),
                  ],
                );
              },
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
      clipBehavior: Clip.hardEdge,
      child: SizedBox(
        width: 300,
        height: 50,
        child: InkWell(
          splashColor: context.iconColor?.withOpacity(0.3),
          onTap: () => print('${thirdPartyData.ThirdPartyName} tapped.'),
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
                icon: url?.contains('pub.dev') ?? false
                    ? const Icon(CommunityMaterialIcons.link)
                    : const Icon(CommunityMaterialIcons.link),
                onPressed: () => Global.openUrl(thirdPartyData.ThirdPartyUrl ?? ''),
              ),
              IconButton(
                alignment: Alignment.center,
                splashRadius: 20,
                padding: const EdgeInsets.all(0),
                iconSize: 24,
                icon: repo?.contains('github.com') ?? false
                    ? const Icon(CommunityMaterialIcons.github)
                    : const Icon(CommunityMaterialIcons.link),
                onPressed: () => Global.openUrl(thirdPartyData.ThirdPartyRepo ?? ''),
              ),
              Container(
                alignment: Alignment.center,
                child: Text(
                  thirdPartyData.ThirdPartyName ?? 'null',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Text(
                thirdPartyData.ThirdPartyVersion ?? 'null',
                style: TextStyle(fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
