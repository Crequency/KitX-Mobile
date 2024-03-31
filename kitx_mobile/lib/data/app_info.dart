import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kitx_mobile/instances.dart';
import 'package:kitx_mobile/utils/themes/themes.dart';

/// [AppInfo] Class
class AppInfo {
  /// Language code
  String? languageCode;

  set languageCodeProperty(String? code) {
    languageCode = code;
    var codes = languageCode?.split('-') ?? ['en', 'US'];
    Get.updateLocale(Locale(codes[0], codes[1]));
  }

  /// Get language code
  Locale? get getLanguageCode {
    if (languageCode == null) return null;

    var codes = languageCode?.split('-') ?? ['en', 'US'];
    return Locale(codes[0], codes[1]);
  }

  /// Is this release edition
  bool get isRelease => bool.fromEnvironment('dart.vm.product');

  /// Is this debug edition
  bool get isDebug => !isRelease;

  /// Theme mode
  var themeMode = ThemeMode.system;

  /// Theme mode property
  ThemeMode get themeModeProperty => themeMode;

  set themeModeProperty(ThemeMode mode) {
    themeMode = mode;
    Get.changeThemeMode(mode);
  }

  /// If enable `Material Design 3` mode
  var material3Enabled = true;

  /// If enable custom animation
  var animationEnabled = true.obs;

  /// Version
  var version = ''.obs;

  /// Version Code
  var versionCode = ''.obs;

  /// Version String
  var versionString = ''.obs;

  /// Init [AppInfo] class
  Future<AppInfo> init() async {
    await instances.packageInfo.then(
      (value) => {
        version.value = value.version,
        versionCode.value = value.buildNumber,
      },
    );
    versionString.value = '${version.value}${(isRelease ? ' (Release)' : ' (Debug)')}';

    return this;
  }

  /// Update Theme
  AppInfo updateTheme({bool useMaterial3 = true}) {
    material3Enabled = useMaterial3;

    lightThemeData.value = ThemeData(
      useMaterial3: useMaterial3,
      primarySwatch: Colors.blue,
      brightness: Brightness.light,
    );
    darkThemeData.value = ThemeData(
      useMaterial3: useMaterial3,
      primarySwatch: Colors.blueGrey,
      brightness: Brightness.dark,
    );

    return this;
  }
}
