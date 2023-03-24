/// Define Service Status
enum ServiceStatus {
  /// Error occurred
  error,

  /// Starting service
  starting,

  /// Stopping service
  stopping,

  /// Service is running
  running,

  /// Service is waiting
  pending,
}
