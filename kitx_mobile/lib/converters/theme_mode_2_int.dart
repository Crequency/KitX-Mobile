// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

/// Convert [ThemeMode] to [int]
int Convert(ThemeMode mode) {
  switch (mode) {
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

/// Convert [int] to [ThemeMode]
ThemeMode ConvertBack(int mode) {
  switch (mode) {
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
