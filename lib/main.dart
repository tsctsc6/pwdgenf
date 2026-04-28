import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pwdgenf/app/main_layout_widget.dart';
import 'package:pwdgenf/app/my_translations.dart';
import 'package:pwdgenf/app/services/app_env_service.dart';
import 'package:pwdgenf/src/rust/api/init.dart';
import 'package:pwdgenf/src/rust/frb_generated.dart';

Future<void> main() async {
  await RustLib.init();
  await Get.putAsync(() => AppEnvService().init());
  initRustLogger();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'pwdgetf',
      translations: MyTranslations(),
      locale: View.of(context).platformDispatcher.locale,
      fallbackLocale: Locale('en', 'US'),
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.light,
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.dark,
        ),
      ),
      home: MainLayoutWidget(),
    );
  }
}
