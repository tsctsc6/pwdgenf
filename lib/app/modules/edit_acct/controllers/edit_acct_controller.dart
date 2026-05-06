import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pwdgenf/app/modules/acct_detail/controllers/acct_detail_controller.dart';
import 'package:pwdgenf/app/modules/home/controllers/home_controller.dart';
import 'package:pwdgenf/app/routes/app_pages.dart';
import 'package:pwdgenf/app/services/app_env_service.dart';
import 'package:pwdgenf/src/rust/api/calculate_password.dart';
import 'package:pwdgenf/src/rust/api/delete_acct_data.dart';
import 'package:pwdgenf/src/rust/api/update_acct_data.dart';

class EditAcctController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController idController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  final FocusNode userNameFocusNode = FocusNode();
  final TextEditingController platformController = TextEditingController();
  final FocusNode platformFocusNode = FocusNode();
  final TextEditingController remarkController = TextEditingController();
  final nonceOffset = 0.0.obs;
  final useUpLetter = false.obs;
  final useLowLetter = false.obs;
  final useNumber = false.obs;
  final useSpecialCharacter = false.obs;
  final pwdLen = 0.0.obs;

  final TextEditingController mainPasswordController = TextEditingController();
  final obscureMainPassword = true.obs;
  final generatedPwd = ''.obs;

  @override
  void onInit() {
    var args = Get.arguments;
    idController.text = args['id'] ?? '';
    userNameController.text = args['userName'] ?? '';
    platformController.text = args['platform'] ?? '';
    remarkController.text = args['remark'] ?? '';
    nonceOffset.value = args['nonceOffset'] ?? 0.0;
    useUpLetter.value = args['useUpLetter'] ?? false;
    useLowLetter.value = args['useLowLetter'] ?? false;
    useNumber.value = args['useNumber'] ?? false;
    useSpecialCharacter.value = args['useSpChar'] ?? false;
    pwdLen.value = args['pwdLen'] ?? 0.0;
    super.onInit();
  }

  @override
  void onClose() {
    idController.dispose();
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
    if (!validateAndFocusErrorTextField()) {
      return;
    }
    final appEnvService = Get.find<AppEnvService>();
    final request = UpdateAcctDataRequest(
      id: int.tryParse(idController.text) ?? 0,
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
      await updateAcctData(
        appSupportDirectory: appEnvService.applicationSupportDirectory,
        request: request,
      );
      if (Get.isRegistered<AcctDetailController>()) {
        Get.find<AcctDetailController>().refreshAcctData(
          int.tryParse(idController.text) ?? 0,
        );
      }
      if (Get.isRegistered<HomeController>()) {
        Get.find<HomeController>().refreshTable();
      }
      Get.back();
      Get.rawSnackbar(
        message: 'saved_text'.tr,
        snackPosition: SnackPosition.BOTTOM,
        borderRadius: 8,
        margin: const EdgeInsets.only(bottom: 24, left: 32, right: 32),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        duration: const Duration(seconds: 3),
        animationDuration: const Duration(milliseconds: 300),
      );
    } catch (e) {
      debugPrint('Error in update account data: $e');
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

  Future<void> onDeleteAcct() async {
    final result = await Get.dialog(
      AlertDialog(
        title: const Text('Info'),
        content: Text('ensure_delete_text'.tr),
        actions: [
          TextButton(
            child: Text('yes_text'.tr),
            onPressed: () => Get.back(result: true),
          ),
          TextButton(
            child: Text('no_text'.tr),
            onPressed: () => Get.back(result: false),
          ),
        ],
      ),
    );
    if (result == null || result == false) return;
    final appEnvService = Get.find<AppEnvService>();
    try {
      deleteAcctData(
        appSupportDirectory: appEnvService.applicationSupportDirectory,
        id: int.tryParse(idController.text) ?? 0,
      );
      if (Get.isRegistered<HomeController>()) {
        Get.find<HomeController>().refreshTable();
      }
      Get.until((route) => Get.currentRoute == Routes.HOME);
      Get.rawSnackbar(
        message: 'deleted_text'.tr,
        snackPosition: SnackPosition.BOTTOM,
        borderRadius: 8,
        margin: const EdgeInsets.only(bottom: 24, left: 32, right: 32),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        duration: const Duration(seconds: 3),
        animationDuration: const Duration(milliseconds: 300),
      );
    } catch (e) {
      debugPrint('Error in delete account data: $e');
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
