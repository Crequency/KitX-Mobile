import 'package:permission_handler/permission_handler.dart';

/// A group of [Permission]s sharing one localized description.
class PermissionBundle {
  /// Constructor
  PermissionBundle({
    required this.key,
    required this.description,
    required this.descriptionKey,
    required this.permissions,
  });

  /// Unique key of this bundle.
  final String key;

  /// Human readable description of this bundle.
  final String description;

  /// Translation key used to localize [description].
  final String descriptionKey;

  /// Permissions contained in this bundle.
  final List<Permission> permissions;

  /// Whether this bundle has already been expanded into individual permissions.
  late bool expanded = false;

  /// Expand this bundle into one [PermissionBundle] per permission.
  ///
  /// Returns an empty list when this bundle is already expanded.
  List<PermissionBundle> getPermissionsMap() {
    if (expanded) return [];

    return [
      for (var p in permissions)
        PermissionBundle(
          key: '${p.toString()} of $key',
          description: 'Permission: $p',
          descriptionKey: 'Permission',
          permissions: [p],
        )..expanded = true,
    ];
  }
}
