import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pwdgenf/app/modules/home/controllers/home_controller.dart';
import 'package:pwdgenf/app/services/app_env_service.dart';

class SettingsController extends GetxController {
  //TODO: Implement SettingsController

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
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
    );
    if (result == null) {
      return;
    }
    await srcFile.copy(result);
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
  }

  Future<void> dumpLogs() async {}
}
