import 'package:flutter/material.dart';

/// [int] Extensions
extension IntExtensions on int {
  /// Convert [int] to [ThemeMode]
  ThemeMode toThemeMode() {
    switch (this) {
      case 0:
        return ThemeMode.system;
      case 1:
        return ThemeMode.light;
      case 2:
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }
}
