import 'package:get/get.dart';

class MyTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'en_US': {
      // home page
      'search_hint': 'Search...',
      'clear_search_input': 'Clear',
      'submit_search': 'Search',
      'table_header_ID': 'ID',
      'table_header_UserName': 'User Name',
      'table_header_Platform': 'Platform',
      'no_data': 'Can\'t find any data',
      'menu_settings': 'Settings',

      // form text
      'user_name_text': 'User Name',
      'platform_text': 'Platform',
      'remark_text': 'Remark',
      'nonce_offset': 'Nonce Offset',
      'use_up_letter': 'Use Up Letter',
      'use_low_letter': 'Use Low Letter',
      'use_number': 'Use Number',
      'use_special_character': 'Use Special Character',
      'password_length': 'Password Length',
      'updated_at': 'Updated At:',
      'main_password': 'Main Password',

      // acct_detials
      'generated_password_text': 'Generated Password: ',
      'copy_text': 'Copy',
      'acct_detail_view': 'Account Details',
      'edit_text': 'Edit',
    },
    'zh_CN': {
      // home page
      'search_hint': '搜索...',
      'clear_search_input': '清空',
      'submit_search': '搜索',
      'table_header_ID': 'ID',
      'table_header_UserName': '用户名',
      'table_header_Platform': '平台',
      'no_data': '找不到任何数据',
      'menu_settings': '设置',

      // form text
      'user_name_text': '用户名',
      'platform_text': '平台',
      'remark_text': '备注',
      'nonce_offset': '偏移',
      'use_up_letter': '使用大写字母',
      'use_low_letter': '使用小写字母',
      'use_number': '使用数字',
      'use_special_character': '使用特殊字符',
      'password_length': '密码长度',
      'updated_at': '更新于',
      'main_password': '主密码',

      // acct_detials
      'generated_password_text': '生成的密码：',
      'copy_text': '复制',
      'acct_detail_view': '账号信息',
      'edit_text': '编辑',
    },
  };
}
