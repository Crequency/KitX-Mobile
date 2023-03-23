import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:kitx_mobile/data/third_party_licenses_provider.dart';
import 'package:kitx_mobile/utils/composer.dart';
import 'package:kitx_mobile/utils/global.dart';

import 'package:vibration/vibration.dart';

/// Contributor Chip
class ContributorChip extends StatelessWidget {
  /// Constructor
  const ContributorChip({required this.name, required this.url, super.key});

  /// Name and URL
  final String name, url;

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(name),
      deleteIcon: const Icon(Icons.open_in_new),
      onDeleted: () => Global.openUrl(url),
      deleteButtonTooltipMessage: '',
    );
  }
}

/// Repo Button
class RepoButton extends StatelessWidget {
  /// Constructor
  const RepoButton({required this.name, required this.url, super.key});

  /// Display Name and URL
  final String name, url;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: () => Global.openUrl(url), child: Text(name));
  }
}

/// Fade In Control
class FadeInControl extends StatelessWidget {
  /// Constructor
  const FadeInControl({
    required this.opacity,
    this.duration = 300,
    this.child = const SizedBox(),
    this.curve = Curves.easeInCubic,
    super.key,
  });

  /// Duration
  final int duration;

  /// Opacity Target
  final double opacity;

  /// Child Widget
  final Widget child;

  /// Curve
  final Curve curve;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: Duration(milliseconds: duration),
      opacity: opacity,
      curve: Curves.easeInCubic,
      child: child,
    );
  }
}

/// Gradually Smaller Spacer
class GraduallySmallerSpacer extends StatelessWidget {
  /// Constructor
  const GraduallySmallerSpacer({
    required this.duration,
    this.curve = Curves.easeInOutCubicEmphasized,
    this.height,
    this.width,
    super.key,
  });

  /// Duration
  final int duration;

  /// Curve
  final Curve curve;

  /// Height
  final double? width, height;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: duration),
      curve: curve,
      width: width,
      height: height,
    );
  }
}

/// Group Divider
class GroupDivider extends GraduallySmallerSpacer {
  /// Constructor
  const GroupDivider({required super.duration, super.curve, super.height, super.width, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 30),
        const Divider(),
        GraduallySmallerSpacer(duration: duration, curve: curve, height: height, width: width),
        const SizedBox(height: 60),
      ],
    );
  }
}

/// About Page
class AboutPage extends StatefulWidget {
  /// Constructor
  const AboutPage({Key? key}) : super(key: key);

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  final iconEntering = (!Global.animationEnabled.value).obs;
  final iconEntered = (!Global.animationEnabled.value).obs;
  final titleEntered = (!Global.animationEnabled.value).obs;

  final titleDisplay = true.obs;
  final versionDisplay = true.obs;

  var contentEntering = !Global.animationEnabled.value;

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

      if (Global.animationEnabled.value) {
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
      }
    });

    if (Global.animationEnabled.value) {
      Future.delayed(Duration(milliseconds: 150)).then((value) => iconEntering.value = true);

      Future.delayed(Duration(milliseconds: 400)).then((value) => iconEntered.value = true);

      Future.delayed(Duration(milliseconds: 600)).then((value) => titleEntered.value = true);

      Future.delayed(Duration(milliseconds: 0)).then(
        (value) => super.setState(() {
          contentEntering = true;
        }),
      );
    }

    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();

    super.dispose();
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
            flexibleSpace: FlexibleSpaceBar(
              // title: Text('AboutPage_Title'.tr),
              centerTitle: true,
              collapseMode: CollapseMode.parallax,
              background: getFlexibleHeader(context),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              childCount: 1,
              (context, index) => getMainContent(context, index),
            ),
          ),
        ],
      ),
    );
  }

  Widget getFlexibleHeader(BuildContext context) {
    return ListView(
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
            child: AnimatedOpacity(
              duration: Duration(milliseconds: 500),
              curve: Curves.easeInCirc,
              opacity: iconEntering.value ? 1 : 0,
              child: InkWell(
                borderRadius: BorderRadius.all(Radius.elliptical(15, 15)),
                onTap: () async => vibrate(),
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
                () => FadeInControl(
                  opacity: iconEntered.value && titleDisplay.value ? 1 : 0,
                  child: const Text('KitX', style: TextStyle(fontSize: 50)),
                ),
              ),
              Obx(
                () => FadeInControl(
                  duration: 500,
                  opacity: titleEntered.value && versionDisplay.value ? 1 : 0,
                  curve: Curves.easeInOutCubic,
                  child: Text('${'AboutPage_Version'.tr}: ${Global.versionString.value}'),
                ),
              ),
              // Divider(),
            ],
          ),
        ),
      ],
    );
  }

  Widget getMainContent(BuildContext context, int index) {
    return ListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: [
        GraduallySmallerSpacer(duration: 1000, height: contentEntering ? 0 : 800),
        const SizedBox(height: 30),
        group(
          FadeInControl(
            opacity: contentEntering ? 1 : 0,
            duration: 800,
            child: Container(
              alignment: Alignment.center,
              child: Text('AboutPage_Contributors'.tr, style: TextStyle(fontSize: 20)),
            ),
          ),
          FadeInControl(
            duration: 800,
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
                    colors: [Colors.indigo, Colors.transparent, Colors.transparent, Colors.indigo],
                    stops: [0.0, 0.05, 0.95, 1.0], // 10% indigo, 80% transparent, 10% purple
                  ).createShader(rect);
                },
                blendMode: BlendMode.dstOut,
                child: ListView(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    physics: BouncingScrollPhysics(),
                    children: [
                      GraduallySmallerSpacer(duration: 1200, width: contentEntering ? 15 : 800),
                      const ContributorChip(name: 'Dynesshely', url: 'https://github.com/Dynesshely'),
                      const SizedBox(width: 10),
                      const ContributorChip(
                        name: 'LYF511',
                        url: 'https://github.com/LYF511',
                      ),
                      const SizedBox(width: 10),
                      const ContributorChip(
                        name: 'orzMaster',
                        url: 'https://github.com/orzMaster',
                      ),
                      const SizedBox(width: 15),
                    ]),
              ),
            ),
          ),
          GroupDivider(duration: 1000, height: contentEntering ? 20 : 1600),
          spacer: const SizedBox(height: 50),
        ),
        group(
          FadeInControl(
            opacity: contentEntering ? 1 : 0,
            duration: 1100,
            child: Container(
              alignment: Alignment.center,
              child: Text('AboutPage_Repos'.tr, style: TextStyle(fontSize: 20)),
            ),
          ),
          FadeInControl(
            opacity: contentEntering ? 1 : 0,
            duration: 1100,
            child: Container(
              height: 60,
              alignment: Alignment.center,
              child: ListView(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.all(10),
                children: [
                  const RepoButton(name: 'GitHub', url: 'https://github.com/Crequency/KitX'),
                  const SizedBox(width: 10),
                  const RepoButton(name: 'Gitee', url: 'https://gitee.com/Crequency/KitX'),
                ],
              ),
            ),
          ),
          GroupDivider(duration: 1000, height: contentEntering ? 20 : 2400),
        ),
        group(
          FadeInControl(
            opacity: contentEntering ? 1 : 0,
            duration: 1400,
            child: Container(
              alignment: Alignment.center,
              child: Text('AboutPage_ThirdPartyLicenses'.tr, style: TextStyle(fontSize: 20)),
            ),
          ),
          Column(
            children: [
              FadeInControl(
                opacity: contentEntering ? 1 : 0,
                duration: 1400,
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
            ],
          ),
          GroupDivider(duration: 1000, height: contentEntering ? 20 : 3200),
        ),
        group(
          Container(
            alignment: Alignment.center,
            child: Text('AboutPage_JoinUS'.tr, style: TextStyle(fontSize: 20)),
          ),
          Container(
            padding: EdgeInsets.all(20),
            child: Text('AboutPage_JoinUS_Text'.tr, textAlign: TextAlign.center),
          ),
          Column(
            children: [
              const SizedBox(height: 30),
              const Divider(),
            ],
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height / 2),
      ],
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
