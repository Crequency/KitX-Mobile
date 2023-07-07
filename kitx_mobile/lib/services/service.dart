/// [Service] class for all services
abstract class Service<T> {
  /// Init service
  Future<T> init();

  /// Restart service
  Future<T> restart();

  /// Stop service
  Future<T> stop();
}
