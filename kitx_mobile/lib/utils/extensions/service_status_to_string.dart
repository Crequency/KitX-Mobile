import 'package:get/get.dart';
import 'package:kitx_mobile/services/public/service_status.dart';

/// [ServiceStatus] Extensions
extension ServiceStatusExtensions on ServiceStatus {
  /// Convert [ServiceStatus] to [String]
  String toText() {
    switch (this) {
      case ServiceStatus.error:
        return 'Public_Error'.tr;
      case ServiceStatus.starting:
        return 'Public_Launching'.tr;
      case ServiceStatus.stopping:
        return 'Public_Stopping'.tr;
      case ServiceStatus.running:
        return 'Public_Running'.tr;
      case ServiceStatus.pending:
        return 'Public_Pending'.tr;
    }
  }
}
