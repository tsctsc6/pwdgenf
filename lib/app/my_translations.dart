import 'package:get/get.dart';

class MyTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'en_US': {
      'search_hint': 'Search...',
      'clear_search_input': 'Clear',
      'submit_search': 'Search',
      'table_header_ID': 'ID',
      'table_header_UserName': 'User Name',
      'table_header_Platform': 'Platform',
      'No data': 'Can\'t find any data',
      'menu_settings': 'Settings',
      'generated_password_text': 'Generated Password: ',
      'copy_text': 'Copy'
    },
    'zh_CN': {
      'search_hint': '搜索...',
      'clear_search_input': '清空',
      'submit_search': '搜索',
      'table_header_ID': 'ID',
      'table_header_UserName': '用户名',
      'table_header_Platform': '平台',
      'No data': '找不到任何数据',
      'menu_settings': '设置',
      'generated_password_text': '生成的密码：',
      'copy_text': '复制'
    },
  };
}
