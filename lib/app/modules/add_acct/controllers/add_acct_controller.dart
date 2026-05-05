import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pwdgenf/app/modules/home/controllers/home_controller.dart';
import 'package:pwdgenf/app/services/app_env_service.dart';
import 'package:pwdgenf/src/rust/api/calculate_password.dart';
import 'package:pwdgenf/src/rust/api/create_acct_data.dart';

class AddAcctController extends GetxController {
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController platformController = TextEditingController();
  final TextEditingController remarkController = TextEditingController();
  final nonceOffset = 0.0.obs;
  final useUpLetter = true.obs;
  final useLowLetter = true.obs;
  final useNumber = true.obs;
  final useSpecialCharacter = true.obs;
  final pwdLen = 15.0.obs;

  final TextEditingController mainPasswordController = TextEditingController();
  final obscureMainPassword = true.obs;
  final generatedPwd = ''.obs;

  Future<void> onGeneratePwd() async {
    if (mainPasswordController.text.isEmpty) {
      generatedPwd.value = '';
      return;
    }
    final result = await calculatePassword(
      request: CalculatePasswordRequest(
        userName: userNameController.text,
        platform: platformController.text,
        nonceOffset: nonceOffset.value.toInt(),
        useUpLetter: useUpLetter.value,
        useLowLetter: useLowLetter.value,
        useNumber: useNumber.value,
        useSpChar: useSpecialCharacter.value,
        pwdLen: pwdLen.value.toInt(),
        mainPassword: mainPasswordController.text,
      ),
    );
    generatedPwd.value = result;
  }

  Future<void> onCopy() async {
    await Clipboard.setData(ClipboardData(text: generatedPwd.value));
  }

  Future<void> onSave() async {
    final appEnvService = Get.find<AppEnvService>();
    final request = CreateAcctDataRequest(
      userName: userNameController.text,
      platform: platformController.text,
      remark: remarkController.text,
      nonceOffset: nonceOffset.value.toInt(),
      useUpLetter: useUpLetter.value,
      useLowLetter: useLowLetter.value,
      useNumber: useNumber.value,
      useSpChar: useSpecialCharacter.value,
      pwdLen: pwdLen.value.toInt(),
    );
    try {
      await createAcctData(
        appSupportDirectory: appEnvService.applicationSupportDirectory,
        request: request,
      );
      if (Get.isRegistered<HomeController>()) {
        Get.find<HomeController>().refreshTable();
      }
      Get.back();
    } catch (e) {
      debugPrint('Error in create account data: $e');
      Get.dialog(
        AlertDialog(
          title: const Text('Error'),
          content: Text("$e"),
          actions: [
            TextButton(
              child: Text('close_text'.tr),
              onPressed: () => Get.back(),
            ),
          ],
        ),
      );
    }
  }
}
