import 'package:flutter_test/flutter_test.dart';
import 'package:kitx_mobile/utils/converters/size_converter.dart';

void main() {
  group('convert2double', () {
    test('returns the size in KB for small inputs', () {
      expect(convert2double(1024), 1.0);
      expect(convert2double(512), 0.5);
    });

    test('reports the value of the next unit once the KB window overflows', () {
      // overflowSizeUnits widens every window by 204, so 1 MB (1024 KB) does not
      // fit the KB window and is reported as the bare MB value instead.
      expect(convert2double(1048576), 1024.0);
    });
  });

  group('convert2string', () {
    test('formats bytes as KB', () {
      expect(convert2string(1024), '1.00 KB');
    });

    test('formats exactly one megabyte in KB because of the overflow window', () {
      expect(convert2string(1048576), '1024.00 KB');
    });

    test('formats exactly one terabyte in GB because of the overflow window', () {
      expect(convert2string(1099511627776), '1024.00 GB');
    });

    test('always carries a two decimal unit suffix', () {
      for (final bytes in [0, 1024, 1048576, 1073741824, 1099511627776]) {
        expect(convert2string(bytes), matches(RegExp(r'^\d+\.\d{2} (KB|MB|GB|TB)$')));
      }
    });
  });
}
