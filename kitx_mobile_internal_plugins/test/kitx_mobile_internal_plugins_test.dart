import 'package:flutter_test/flutter_test.dart';
import 'package:kitx_mobile_internal_plugins/kitx_mobile_internal_plugins.dart';

void main() {
  group('InternalPluginsManager', () {
    test('is a singleton', () {
      expect(
        identical(InternalPluginsManager.instance(), InternalPluginsManager.instance()),
        isTrue,
      );
    });

    test('exposes the built in plugins', () {
      final plugins = InternalPluginsManager.plugins;

      expect(plugins, isNotEmpty);
      expect(plugins.map((plugin) => plugin.name), contains('Test'));
      expect(plugins.map((plugin) => plugin.name), contains('Native Async'));
    });

    test('reports a length consistent with the enabled count', () {
      final manager = InternalPluginsManager.instance();

      expect(manager.length, InternalPluginsManager.plugins.length);
      expect(manager.enabledLength, lessThanOrEqualTo(manager.length));
    });
  });
}
