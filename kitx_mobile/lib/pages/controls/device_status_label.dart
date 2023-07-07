import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kitx_mobile/instances.dart';
import 'package:kitx_mobile/services/public/service_status.dart';

/// Device Status Label
class DeviceStatusLabel extends StatelessWidget {
  /// Constructor for Device Status Label
  const DeviceStatusLabel({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      var textStyle = Theme.of(context).textTheme.bodyMedium;
      switch (instances.webService.webServiceStatus.value) {
        case ServiceStatus.running:
          return Text(
            '${instances.deviceService.length.obs} ${'HomePage_DevicesCount'.tr}',
            style: textStyle,
          );
        case ServiceStatus.starting:
          return Text('Public_Launching'.tr, style: textStyle);
        case ServiceStatus.stopping:
          return Text('Public_Stopping'.tr, style: textStyle);
        case ServiceStatus.error:
          return Text(
            '${'Public_Error'.tr}: ${instances.webService.webServiceErrorMessage}',
            style: textStyle,
          );
        default:
          return Text('Public_Closed'.tr, style: textStyle);
      }
    });
  }
}
