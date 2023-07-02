import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kitx_mobile/services/public/service_status.dart';
import 'package:kitx_mobile/utils/global.dart';

/// Device Status Icon
class DeviceStatusIcon extends StatelessWidget {
  /// Constructor for Device Status Icon
  const DeviceStatusIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      switch (Global.webService.webServiceStatus.value) {
        case ServiceStatus.running:
          return const Icon(Icons.circle, color: Colors.greenAccent);
        case ServiceStatus.pending:
          return const Icon(Icons.timer);
        case ServiceStatus.error:
          return const Icon(Icons.error, color: Colors.redAccent);
        case ServiceStatus.starting:
          return const Icon(Icons.rocket_launch, color: Colors.lightBlueAccent);
        case ServiceStatus.stopping:
          return const Icon(Icons.square, color: Colors.yellowAccent);
      }
    });
  }
}
