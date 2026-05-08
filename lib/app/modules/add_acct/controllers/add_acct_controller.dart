import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pwdgenf/app/modules/home/controllers/home_controller.dart';
import 'package:pwdgenf/app/services/app_env_service.dart';
import 'package:pwdgenf/app/services/block_ui_service.dart';
import 'package:pwdgenf/src/rust/api/calculate_password.dart';
import 'package:pwdgenf/src/rust/api/create_acct_data.dart';

class AddAcctController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController userNameController = TextEditingController();
  final FocusNode userNameFocusNode = FocusNode();
  final TextEditingController platformController = TextEditingController();
  final FocusNode platformFocusNode = FocusNode();
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

  @override
  void onClose() {
    userNameController.dispose();
    platformController.dispose();
    remarkController.dispose();
    mainPasswordController.dispose();
    userNameFocusNode.dispose();
    platformFocusNode.dispose();
    super.onClose();
  }

  String? validateUserName(String? value) {
    if (value == null || value.isEmpty) {
      return 'user_name_can_not_be_empty_text'.tr;
    }
    return null;
  }

  String? validatePlatform(String? value) {
    if (value == null || value.isEmpty) {
      return 'platform_can_not_be_empty_text'.tr;
    }
    return null;
  }

  /// true for valid
  bool validateAndFocusErrorTextField() {
    if (formKey.currentState!.validate()) {
      return true;
    }
    if (validateUserName(userNameController.text) != null) {
      userNameFocusNode.requestFocus();
    } else if (validatePlatform(platformController.text) != null) {
      platformFocusNode.requestFocus();
    }
    return false;
  }

  Future<void> onGeneratePwd() async {
    if (!validateAndFocusErrorTextField()) {
      return;
    }
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
    await Get.find<BlockUIService>().runWithBlockUI(() async {
      if (!validateAndFocusErrorTextField()) {
        return;
      }
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
    });
  }
}
