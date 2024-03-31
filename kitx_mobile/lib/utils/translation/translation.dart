import 'package:get/get.dart';

import 'package:kitx_mobile/utils/translation/en_us.dart';
import 'package:kitx_mobile/utils/translation/zh_cn.dart';

/// Translation Data
class Translation extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {'zh_CN': zh_cn, 'en_US': en_us};
}
