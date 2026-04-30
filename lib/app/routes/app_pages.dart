import 'package:get/get.dart';

import '../modules/acct_detail/bindings/acct_detail_binding.dart';
import '../modules/acct_detail/views/acct_detail_view.dart';
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

  // ignore: constant_identifier_names
  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: _Paths.SETTINGS,
      page: () => const SettingsView(),
      binding: SettingsBinding(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: _Paths.EDIT_ACCT,
      page: () => const EditAcctView(),
      binding: EditAcctBinding(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: _Paths.ADD_ACCT,
      page: () => const AddAcctView(),
      binding: AddAcctBinding(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: _Paths.ACCT_DETAIL,
      page: () => const AcctDetailView(),
      binding: AcctDetailBinding(),
      transition: Transition.cupertino,
    ),
  ];
}
