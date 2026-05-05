import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pwdgenf/app/modules/home/controllers/home_controller.dart';
import 'package:pwdgenf/app/services/app_env_service.dart';

class SettingsController extends GetxController {
  late String appVersion = '';

  @override
  void onInit() {
    super.onInit();
    final appEnvService = Get.find<AppEnvService>();
    appVersion = appEnvService.packageInfo.version;
  }

  Future<void> backup() async {
    final appEnvService = Get.find<AppEnvService>();
    final srcFile = File(
      '${appEnvService.applicationSupportDirectory}/pwdgenf.db',
    );
    final dateTime = DateTime.now();
    final formattedDate = DateFormat('yyyyMMdd-HHmmss').format(dateTime);
    final result = await FilePicker.saveFile(
      dialogTitle: 'Please select an output file:',
      fileName: 'pwdgenf-$formattedDate.db',
      initialDirectory: appEnvService.downloadDirectory,
      type: FileType.custom,
      allowedExtensions: ['db'],
      lockParentWindow: true,
      bytes: await srcFile.readAsBytes(),
    );
    if (result == null) {
      return;
    }
    Get.rawSnackbar(
      message: 'backuped_text'.tr,
      snackPosition: SnackPosition.BOTTOM,
      borderRadius: 8,
      margin: const EdgeInsets.only(bottom: 24, left: 32, right: 32),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      duration: const Duration(seconds: 3),
      animationDuration: const Duration(milliseconds: 300),
    );
  }

  Future<void> restore() async {
    final appEnvService = Get.find<AppEnvService>();
    final result = await FilePicker.pickFiles(
      dialogTitle: 'Please select an input file:',
      initialDirectory: appEnvService.downloadDirectory,
      type: FileType.custom,
      allowedExtensions: ['db'],
      lockParentWindow: true,
    );
    if (result == null) {
      return;
    }
    File srcFile = File(result.files.single.path!);
    await srcFile.copy(
      '${appEnvService.applicationSupportDirectory}/pwdgenf.db',
    );
    if (Get.isRegistered<HomeController>()) {
      Get.find<HomeController>().goToFirstPageAndRefreshTable();
    }
    Get.rawSnackbar(
      message: 'restored_text'.tr,
      snackPosition: SnackPosition.BOTTOM,
      borderRadius: 8,
      margin: const EdgeInsets.only(bottom: 24, left: 32, right: 32),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      duration: const Duration(seconds: 3),
      animationDuration: const Duration(milliseconds: 300),
    );
  }

  void showAbout() {
    Get.bottomSheet(
      Container(
        height: Get.height / 2,
        width: Get.width,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const Text(
              '关于',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    leading: const Icon(Icons.info_outline),
                    title: Text('pwdgetf'),
                    subtitle: Text(appVersion),
                  ),
                  ListTile(
                    leading: const Icon(Icons.public),
                    title: Text('前往 Github'),
                    subtitle: Text('https://github.com/tsctsc6/pwdgenf'),
                    onTap: () => tapWebsite(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
      isScrollControlled: true,
      enableDrag: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
    );
  }

  Future<void> tapWebsite() async {
    await Clipboard.setData(
      ClipboardData(text: 'https://github.com/tsctsc6/pwdgenf'),
    );
    Get.rawSnackbar(
      message: 'url 已复制'.tr,
      snackPosition: SnackPosition.BOTTOM,
      borderRadius: 8,
      margin: const EdgeInsets.only(bottom: 24, left: 32, right: 32),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      duration: const Duration(seconds: 3),
      animationDuration: const Duration(milliseconds: 300),
    );
  }
}
