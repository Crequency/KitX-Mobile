import 'dart:async';

import 'package:get/get.dart';
import 'package:kitx_mobile/services/public/service_status.dart';
import 'package:kitx_mobile/services/service.dart';
import 'package:kitx_mobile_internal_plugins/interface/runtime_context.dart';
import 'package:kitx_mobile_internal_plugins/kitx_mobile_internal_plugins.dart';

/// Device Service
class PluginsService implements Service {
  @override
  var serviceStatus = ServiceStatus.pending.obs;

  @override
  var serviceException;

  @override
  Future<PluginsService> init() async {
    serviceStatus.value = ServiceStatus.starting;

    InternalPluginsManager.instance().forEach(
      (p) => p
          .authorize(
            RuntimeContext('${p.author}_${p.name}:${p.version}'),
          )
          .initialize(),
    );

    Timer.periodic(
      const Duration(milliseconds: 10),
      (timer) {
        InternalPluginsManager.instance().forEach(
          (p) {
            if (p.isEnabled.value) p.execute();
          },
        );
      },
    );

    serviceStatus.value = ServiceStatus.running;

    return this;
  }

  @override
  Future<PluginsService> restart() async {
    await stop();

    await Future.delayed(const Duration(milliseconds: 500));

    await init();

    return this;
  }

  @override
  Future<PluginsService> stop() async {
    serviceStatus.value = ServiceStatus.stopping;

    InternalPluginsManager.instance().forEach(
      (p) => p.dispose(),
    );

    serviceStatus.value = ServiceStatus.pending;

    return this;
  }
}
