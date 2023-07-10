import 'package:get/get.dart';
import 'package:kitx_mobile/services/public/service_status.dart';

/// [Service] class for all services
abstract class Service<T> {
  /// Service status
  Rx<ServiceStatus> serviceStatus = ServiceStatus.pending.obs;

  /// Service exception
  Exception? serviceException;

  /// Init service
  Future<T> init();

  /// Restart service
  Future<T> restart();

  /// Stop service
  Future<T> stop();
}
