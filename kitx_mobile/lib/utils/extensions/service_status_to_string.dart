import 'package:get/get.dart';
import 'package:kitx_mobile/services/public/service_status.dart';

/// [ServiceStatus] Extensions
extension ServiceStatusExtensions on ServiceStatus {
  /// Convert [ServiceStatus] to [String]
  String toText() {
    switch (this) {
      case ServiceStatus.error:
        return 'ServiceStatus_Error'.tr;
      case ServiceStatus.starting:
        return 'ServiceStatus_Starting'.tr;
      case ServiceStatus.stopping:
        return 'ServiceStatus_Stopping'.tr;
      case ServiceStatus.running:
        return 'ServiceStatus_Running'.tr;
      case ServiceStatus.pending:
        return 'ServiceStatus_Pending'.tr;
      default:
        return 'Unknown';
    }
  }
}
