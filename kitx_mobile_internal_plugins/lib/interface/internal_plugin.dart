import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kitx_mobile_internal_plugins/interface/runtime_context.dart';

abstract class InternalPlugin {
  late String name;
  late String version;
  late String description;
  late String author;
  late Duration executeInterval = const Duration(milliseconds: 10);

  late RuntimeContext? context;

  String get authorAndVersion => "$author - $version";

  late var isEnabled = false.obs;

  Widget getSettings({
    Function(bool)? onPluginAbilityChangedAction,
  });

  InternalPlugin authorize(RuntimeContext context) {
    this.context = context;
    return this;
  }

  void initialize() {}

  void execute() {}

  void dispose() {}
}
