import 'package:flutter/material.dart';

/// [ThemeMode] Extensions
extension ThemeModeExtensions on ThemeMode {
  /// Convert [ThemeMode] to [int]
  int toInt() {
    switch (this) {
      case ThemeMode.system:
        return 0;
      case ThemeMode.light:
        return 1;
      case ThemeMode.dark:
        return 2;
      default:
        return 0;
    }
  }
}
