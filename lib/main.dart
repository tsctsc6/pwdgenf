import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pwdgenf/app/my_translations.dart';
import 'package:pwdgenf/app/routes/app_pages.dart';
import 'package:pwdgenf/app/services/app_config.dart';
import 'package:pwdgenf/app/services/app_env_service.dart';
import 'package:pwdgenf/app/services/lock_ui_service.dart';
import 'package:pwdgenf/src/rust/api/init.dart';
import 'package:pwdgenf/src/rust/frb_generated.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await RustLib.init();
  await Get.putAsync(() => AppEnvService().init());
  await Get.putAsync(() => AppConfig.fromFile());
  Get.put(LockUIService());
  final appEnvService = Get.find<AppEnvService>();
  try {
    initRustLogger(
      applicationSupportDirectory: appEnvService.applicationSupportDirectory,
    );
  } catch (e) {
    debugPrint(e.toString());
  }
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    HardwareKeyboard.instance.addHandler(_handleKeyEvent);
  }

  @override
  void dispose() {
    HardwareKeyboard.instance.removeHandler(_handleKeyEvent);
    super.dispose();
  }

  bool _handleKeyEvent(KeyEvent event) {
    if (_handleEscKeyEvent(event)) return true;
    return false;
  }

  bool _handleEscKeyEvent(KeyEvent event) {
    if (event is! KeyDownEvent ||
        event.logicalKey != LogicalKeyboardKey.escape) {
      return false;
    }

    final primaryFocus = FocusManager.instance.primaryFocus;

    // if there is a focus, and it is a normal FocusNode, this means focus on TextField or Button,
    // instead of the page focus, which is FocusScopeNode,
    // unfocus TextField first.
    if (primaryFocus != null && primaryFocus is! FocusScopeNode) {
      primaryFocus.unfocus();
      return true;
    }

    // if there is not focus on TextField, back to last page.
    Get.key.currentState?.maybePop();
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final appConfig = Get.find<AppConfig>();
    Locale? locale;
    if (appConfig.followSystemLanguage) {
      locale = View.of(context).platformDispatcher.locale;
    } else {
      locale = Locale(appConfig.languageCode, appConfig.countryCode);
    }

    return SafeArea(
      top: false,
      bottom: true,
      child: GetMaterialApp(
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
      ),
    );
  }
}
