import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kitx_mobile/services/public/service_status.dart';
import 'package:kitx_mobile/utils/global.dart';

/// Device Status Label
class DeviceStatusLabel extends StatelessWidget {
  /// Constructor for Device Status Label
  const DeviceStatusLabel({super.key});

  @override
  Widget build(BuildContext context) {
    switch (Global.webService.webServiceStatus.value) {
      case ServiceStatus.running:
        return Obx(
          () => Text(
            '${Global.deviceService.length.obs} ${'HomePage_DevicesCount'.tr}',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        );
      default:
        return Obx(
          () => Text(
            'Public_Closed'.tr,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        );
    }
  }
}
