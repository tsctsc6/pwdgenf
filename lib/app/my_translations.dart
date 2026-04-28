import 'package:get/get.dart';

class MyTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'en_US': {'hello': 'Hello World'},
    'zh_CN': {'hello': '你好 世界'},
  };
}
