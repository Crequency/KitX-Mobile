import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:kitx_mobile/pages/controls/device_card.dart';
import 'package:kitx_mobile/utils/global.dart';

/// Device Page
class DevicePage extends StatefulWidget {
  /// Constructor
  const DevicePage({Key? key}) : super(key: key);

  @override
  State<DevicePage> createState() => _DevicePage();
}

class _DevicePage extends State<DevicePage> {
  var _scrollController = ScrollController();

  var deviceCardHorizontalScale = 0.5;
  var back2topButtonVisibility = false.obs;
  var justEnteredPage = true;

  @override
  void initState() {
    _scrollController.addListener(() {
      if (_scrollController.offset >= MediaQuery.of(super.context).size.height * 0.3) {
        back2topButtonVisibility.value = true;
      } else {
        back2topButtonVisibility.value = false;
      }
    });

    // Execute after all widgets built.
    WidgetsBinding.instance.addPostFrameCallback((_) => justEnteredPage = false);

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
      appBar: AppBar(
        title: Text('DevicePage_Title'.tr),
        actions: [
          OrientationBuilder(
            builder: (context, _) => MediaQuery.of(context).orientation == Orientation.landscape
                ? PopupMenuButton(
                    tooltip: '',
                    padding: EdgeInsets.all(0),
                    icon: const Icon(Icons.view_column_outlined),
                    position: PopupMenuPosition.under,
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        child: const Text('2'),
                        onTap: () => deviceCardHorizontalScale = 0.5,
                      ),
                      PopupMenuItem(
                        child: const Text('3'),
                        onTap: () => deviceCardHorizontalScale = 1.0 / 3,
                      ),
                    ],
                  )
                : const SizedBox(),
          ),
          PopupMenuButton(
            tooltip: '',
            padding: EdgeInsets.all(0),
            icon: const Icon(CommunityMaterialIcons.refresh),
            position: PopupMenuPosition.under,
            itemBuilder: (context) => [
              PopupMenuItem(
                child: Text('Option_RestartDevicesServer'.tr),
                onTap: Global.restartDevicesServer,
              ),
              PopupMenuItem(
                child: Text('Option_ShutdownDevicesServer'.tr),
                onTap: Global.shutdownDevicesServer,
              ),
            ],
          ),
          const SizedBox(width: 10),
        ],
      ),
      floatingActionButton: Obx(
        () => AnimatedOpacity(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOutCubicEmphasized,
          opacity: back2topButtonVisibility.value ? 1 : 0,
          child: FloatingActionButton(
            onPressed: () => _scrollController.animateTo(
              0.0,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOutCubicEmphasized,
            ),
            child: const Icon(Icons.arrow_upward),
          ),
        ),
      ),
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      body: ListView(
        controller: _scrollController,
        children: [
          Obx(
            () => Padding(
              padding: EdgeInsets.fromLTRB(30, 30, 30, 0),
              child: Hero(
                tag: 'HeroTag_DevicesCount',
                child: Text(
                  '${Global.deviceService.length.obs} ${'HomePage_DevicesCount'.tr}',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ),
          ),
          const SizedBox(height: 25),
          OrientationBuilder(
            builder: (context, _) => MediaQuery.of(context).orientation == Orientation.portrait
                ? Obx(
                    () => ReorderableListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: Global.deviceService.length + 1,
                      itemBuilder: (_, index) {
                        var list = Global.deviceService.deviceInfoList;
                        var info = index >= Global.deviceService.length ? null : list[index];
                        return DeviceCard(
                          info,
                          index,
                          key: Key('${info?.deviceName ?? ''}${info?.iPv4 ?? ''}'),
                          shouldDelay: justEnteredPage,
                        );
                      },
                      onReorder: (int oldIndex, int newIndex) {
                        var list = Global.deviceService.deviceInfoList;
                        var moveBack = newIndex > oldIndex;
                        list.insert(moveBack ? newIndex - 1 : newIndex, list.removeAt(oldIndex));
                      },
                    ),
                  )
                : Obx(
                    () => Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Wrap(
                        spacing: 0.0,
                        runSpacing: 0.0,
                        children: [
                          for (var i = 0; i < Global.deviceService.length; ++i)
                            DeviceCard(
                              Global.deviceService.deviceInfoList[i],
                              i,
                              width: (MediaQuery.of(context).size.width - 20) * deviceCardHorizontalScale,
                              key: Key('${Global.deviceService.deviceInfoList[i].deviceName}'
                                  '${Global.deviceService.deviceInfoList[i].iPv4}'),
                              shouldDelay: justEnteredPage,
                            )
                        ],
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
