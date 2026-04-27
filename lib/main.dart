import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pwdgenf/app/modules/add_acct/views/add_acct_view.dart';
import 'package:pwdgenf/app/modules/home/views/home_view.dart';
import 'package:pwdgenf/app/modules/settings/views/settings_view.dart';
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

class MainLayoutWidget extends StatelessWidget {
  const MainLayoutWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('pwdgetf Home')),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text(
                'Menu',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                Get.back(); // close the drawer on tap
                Get.to(
                  () => const SettingsView(),
                  transition: Transition.rightToLeft,
                );
              },
            ),
          ],
        ),
      ),
      body: HomeView(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => const AddAcctView(), transition: Transition.rightToLeft);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
