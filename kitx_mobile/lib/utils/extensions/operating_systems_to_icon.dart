import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:kitx_shared_dart/kitx_shared_dart.dart';

/// [OperatingSystems] Extensions
extension OperatingSystemsExtensions on OperatingSystems {
  /// Convert [OperatingSystems] to [IconData]
  IconData toIconData() {
    switch (this) {
      case OperatingSystems.unknown:
        return Icons.help;
      case OperatingSystems.android:
        return Icons.android;
      case OperatingSystems.browser:
        return CommunityMaterialIcons.microsoft_edge;
      case OperatingSystems.freeBSD:
        return CommunityMaterialIcons.freebsd;
      case OperatingSystems.iOS:
        return CommunityMaterialIcons.apple_ios;
      case OperatingSystems.linux:
        return CommunityMaterialIcons.linux;
      case OperatingSystems.macCatalyst:
        return CommunityMaterialIcons.apple;
      case OperatingSystems.macOS:
        return CommunityMaterialIcons.apple_keyboard_command;
      case OperatingSystems.tvOS:
        return CommunityMaterialIcons.apple;
      case OperatingSystems.watchOS:
        return CommunityMaterialIcons.apple;
      case OperatingSystems.windows:
        return CommunityMaterialIcons.microsoft_windows;
      case OperatingSystems.iot:
        return CommunityMaterialIcons.chip;
      default:
        return Icons.help;
    }
  }

  /// Convert [OperatingSystems] to [int]
  int toInt(OperatingSystems type) {
    switch (type) {
      case OperatingSystems.unknown:
        return 0;
      case OperatingSystems.android:
        return 1;
      case OperatingSystems.browser:
        return 2;
      case OperatingSystems.freeBSD:
        return 3;
      case OperatingSystems.iOS:
        return 4;
      case OperatingSystems.linux:
        return 5;
      case OperatingSystems.macCatalyst:
        return 6;
      case OperatingSystems.macOS:
        return 7;
      case OperatingSystems.tvOS:
        return 8;
      case OperatingSystems.watchOS:
        return 9;
      case OperatingSystems.windows:
        return 10;
      case OperatingSystems.iot:
        return 11;
      default:
        return 0;
    }
  }
}
