import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kitx_mobile/instances.dart';
import 'package:kitx_mobile/services/public/service_status.dart';
import 'package:kitx_mobile/utils/handlers/vibration_handler.dart';

/// Plugins Status Label
class PluginsStatusLabel extends StatelessWidget {
  /// Constructor for Plugins Status Label
  const PluginsStatusLabel({required this.inHomePage, super.key});

  /// If in home page
  final bool inHomePage;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      var textStyle = Theme.of(context).textTheme.bodyMedium;
      switch (instances.pluginsService.serviceStatus.value) {
        case ServiceStatus.running:
          return Text(
            [
              'HomePage_PluginsCount'.trParams(
                {
                  'count': instances.pluginsService.length.obs.string,
                },
              ),
              'HomePage_EnabledPluginsCount'.trParams(
                {
                  'count': instances.pluginsService.enabledLength.obs.string,
                },
              ),
            ].join('  ||  '),
            style: textStyle,
          );
        case ServiceStatus.starting:
          return Text('Public_Launching'.tr, style: textStyle);
        case ServiceStatus.stopping:
          return Text('Public_Stopping'.tr, style: textStyle);
        case ServiceStatus.error:
          return Row(
            children: [
              Padding(
                padding: EdgeInsets.only(top: inHomePage ? 10 : 0),
                child: ElevatedButton.icon(
                  onPressed: () {
                    VibrationHandler.tryVibrate();

                    Get.defaultDialog(
                      title: 'Public_Error'.tr,
                      titlePadding: EdgeInsets.only(top: 20),
                      middleText: instances.pluginsService.serviceException.toString(),
                      textConfirm: 'Public_Close'.tr,
                      contentPadding: EdgeInsets.only(top: 10, bottom: 20),
                      onConfirm: () => Get.back.tryVibrate().call(),
                    );
                  },
                  icon: const Icon(Icons.error, color: Colors.redAccent),
                  label: Text("Public_View_Error".tr),
                ),
              ),
            ],
          );
        default:
          return Text('Public_Closed'.tr, style: textStyle);
      }
    });
  }
}
