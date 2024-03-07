import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kitx_mobile_internal_plugins/interface/interface.dart';
import 'package:kitx_mobile_internal_plugins/interface/internal_plugin.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key, required this.plugin});

  final InternalPlugin plugin;

  Widget buildSettingsContent(BuildContext context) => const Text('Developing ...');

  @override
  State<SettingsPage> createState() => SettingsPageState();
}

class SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.plugin.name),
        ),
        body: Container(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              Obx(
                () => Card(
                  color: widget.plugin.isEnabled.value ? Colors.indigo : Colors.blueGrey,
                  shadowColor: Colors.blueGrey,
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(20, 10, 10, 10),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              widget.plugin.name,
                              style: const TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            alignment: Alignment.centerRight,
                            child: Switch(
                              value: widget.plugin.isEnabled.value,
                              onChanged: (value) => widget.plugin.isEnabled.value = value,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              widget.buildSettingsContent(context),
            ],
          ),
        ));
  }
}
