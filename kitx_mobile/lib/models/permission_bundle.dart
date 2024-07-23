import 'package:permission_handler/permission_handler.dart';

class PermissionBundle {
  PermissionBundle({
    required this.key,
    required this.description,
    required this.descriptionKey,
    required this.permissions,
  });

  final String key;

  final String description;

  final String descriptionKey;

  final List<Permission> permissions;

  late bool expanded = false;

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
