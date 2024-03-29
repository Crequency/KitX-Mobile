import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kitx_mobile/instances.dart';
import 'package:kitx_mobile/pages/controls/device_card.dart';
import 'package:kitx_mobile/pages/controls/device_status_icon.dart';
import 'package:kitx_mobile/pages/controls/device_status_label.dart';
import 'package:kitx_mobile/pages/sub_pages/device_chat_page.dart';
import 'package:kitx_shared_dart/kitx_shared_dart.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

/// Device Page
class DevicesPage extends StatefulWidget {
  /// Constructor
  const DevicesPage({Key? key}) : super(key: key);

  @override
  State<DevicesPage> createState() => _DevicesPage();
}

class _DevicesPage extends State<DevicesPage> {
  var _scrollController = ScrollController();
  var _paneController = PanelController();

  var deviceCardHorizontalScale = 0.5;
  var backToTopButtonVisibility = false.obs;
  var justEnteredPage = true;

  var selectedDeviceInfo = Rx<DeviceInfo?>(null);

  @override
  void initState() {
    _scrollController.addListener(() {
      if (_scrollController.offset >= MediaQuery.of(super.context).size.height * 0.3) {
        backToTopButtonVisibility.value = true;
      } else {
        backToTopButtonVisibility.value = false;
      }
    });

    // Execute after all widgets built.
    WidgetsBinding.instance.addPostFrameCallback((_) => justEnteredPage = false);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DevicesPage_Title'.tr),
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
            icon: const DeviceStatusIcon(),
            position: PopupMenuPosition.under,
            itemBuilder: (context) => [
              PopupMenuItem(
                child: Text('Option_RestartDevicesServer'.tr),
                onTap: instances.restartDevicesServer,
              ),
              PopupMenuItem(
                child: Text('Option_ShutdownDevicesServer'.tr),
                onTap: instances.shutdownDevicesServer,
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
          opacity: backToTopButtonVisibility.value ? 1 : 0,
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
      body: Stack(
        children: [
          ListView(
            controller: _scrollController,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(30, 30, 30, 0),
                child: const Hero(
                  tag: 'HeroTag_DevicesCount',
                  child: const DeviceStatusLabel(),
                ),
              ),
              const SizedBox(height: 25),
              OrientationBuilder(
                builder: (context, _) => MediaQuery.of(context).orientation == Orientation.portrait
                    ? Obx(
                        () => ReorderableListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: instances.devicesService.length + 1,
                          itemBuilder: (_, index) {
                            var list = instances.devicesService.deviceInfoList;
                            var info = index >= instances.devicesService.length ? null : list[index];
                            return DeviceCard(
                              info,
                              index,
                              key: Key('${info?.device.deviceName ?? ''}${info?.device.iPv4 ?? ''}'),
                              shouldDelay: justEnteredPage,
                              shouldScaleIn: instances.appInfo.animationEnabled.value,
                              onTap: () => {
                                if (info != null) selectedDeviceInfo.value = info,
                                _paneController.open(),
                              },
                            );
                          },
                          onReorder: (int oldIndex, int newIndex) {
                            var list = instances.devicesService.deviceInfoList;
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
                              for (var i = 0; i < instances.devicesService.length; ++i)
                                DeviceCard(
                                  instances.devicesService.deviceInfoList[i],
                                  i,
                                  width: (MediaQuery.of(context).size.width - 20) * deviceCardHorizontalScale,
                                  key: Key('${instances.devicesService.deviceInfoList[i].device.deviceName}'
                                      '${instances.devicesService.deviceInfoList[i].device.iPv4}'),
                                  shouldDelay: justEnteredPage,
                                  shouldScaleIn: instances.appInfo.animationEnabled.value,
                                  onTap: () => {
                                    selectedDeviceInfo.value = instances.devicesService.deviceInfoList[i],
                                    _paneController.open(),
                                  },
                                )
                            ],
                          ),
                        ),
                      ),
              ),
              const SizedBox(height: 300),
            ],
          ),
          SlidingUpPanel(
            borderRadius: const BorderRadius.vertical(top: const Radius.circular(15)),
            color: Get.isDarkMode ? Colors.black : Colors.white,
            controller: _paneController,
            maxHeight: MediaQuery.of(context).size.height * 0.8,
            minHeight: 0,
            panel: Column(
              children: [
                Container(
                  margin: const EdgeInsets.all(20),
                  width: 80,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Get.isDarkMode ? Colors.white60 : Colors.black38,
                    borderRadius: const BorderRadius.all(const Radius.circular(5)),
                  ),
                ),
                Obx(
                  () => Text(
                    selectedDeviceInfo.value?.device.deviceName ?? '',
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
                const Spacer(),
                SizedBox(
                  width: 130,
                  child: FilledButton.tonalIcon(
                    onPressed: () => Get.to(() => DeviceChatPage()),
                    icon: const Icon(CommunityMaterialIcons.telegram),
                    label: Text('Public_Chat'.tr),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();

    super.dispose();
  }
}
