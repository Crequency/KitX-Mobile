/// [AppInfo] Class
class AppInfo {
  /// Is this release edition
  bool get isRelease => bool.fromEnvironment('dart.vm.product');

  /// Is this debug edition
  bool get isDebug => !isRelease;
}
