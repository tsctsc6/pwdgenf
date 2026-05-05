import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pwdgenf/app/my_translations.dart';
import 'package:pwdgenf/app/routes/app_pages.dart';
import 'package:pwdgenf/app/services/app_config.dart';
import 'package:pwdgenf/app/services/app_env_service.dart';
import 'package:pwdgenf/src/rust/api/init.dart';
import 'package:pwdgenf/src/rust/frb_generated.dart';

Future<void> main() async {
  await RustLib.init();
  await Get.putAsync(() => AppEnvService().init());
  await Get.putAsync(() async => await AppConfig.fromFile());
  final appEnvService = Get.find<AppEnvService>();
  try {
    initRustLogger(
      applicationSupportDirectory: appEnvService.applicationSupportDirectory,
    );
  } on Exception catch (e) {
    debugPrint(e.toString());
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final appConfig = Get.find<AppConfig>();
    Locale? locale;
    if (appConfig.followSystemLanguage) {
      locale = View.of(context).platformDispatcher.locale;
    } else {
      locale = Locale(appConfig.languageCode, appConfig.countryCode);
    }

    return GetMaterialApp(
      title: 'pwdgetf',
      translations: MyTranslations(),
      locale: locale,
      fallbackLocale: Locale('en', 'US'),
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.light,
        ),
        fontFamily: 'NotoSansSC-VariableFont_wght',
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.dark,
        ),
        fontFamily: 'NotoSansSC-VariableFont_wght',
      ),
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    );
  }
}
