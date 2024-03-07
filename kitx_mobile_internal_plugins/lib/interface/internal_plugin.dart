import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class InternalPlugin {
  late String name;
  late String version;
  late String description;
  late String author;

  String get authorAndVersion => "$author - $version";

  late var isEnabled = false.obs;

  Widget getSettings();
}
