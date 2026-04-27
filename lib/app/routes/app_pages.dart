import 'package:get/get.dart';

import '../modules/add_acct/bindings/add_acct_binding.dart';
import '../modules/add_acct/views/add_acct_view.dart';
import '../modules/edit_acct/bindings/edit_acct_binding.dart';
import '../modules/edit_acct/views/edit_acct_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/settings/bindings/settings_binding.dart';
import '../modules/settings/views/settings_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SETTINGS,
      page: () => const SettingsView(),
      binding: SettingsBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_ACCT,
      page: () => const EditAcctView(),
      binding: EditAcctBinding(),
    ),
    GetPage(
      name: _Paths.ADD_ACCT,
      page: () => const AddAcctView(),
      binding: AddAcctBinding(),
    ),
  ];
}
