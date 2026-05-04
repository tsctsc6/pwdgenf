import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pwdgenf/app/routes/app_pages.dart';
import 'package:pwdgenf/app/services/app_env_service.dart';
import 'package:pwdgenf/src/rust/api/calculate_password.dart';
import 'package:pwdgenf/src/rust/api/read_acct_data.dart';

class AcctDetailController extends GetxController {
  final acctData = Rxn<ReadAcctDataResult>();

  final TextEditingController idController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController platformController = TextEditingController();
  final TextEditingController remarkController = TextEditingController();
  final nonceOffset = 0.obs;
  final useUpLetter = false.obs;
  final useLowLetter = false.obs;
  final useNumber = false.obs;
  final useSpecialCharacter = false.obs;
  final pwdLen = 0.obs;
  final TextEditingController updatedAtController = TextEditingController();

  final TextEditingController mainPasswordController = TextEditingController();
  final obscureMainPassword = true.obs;
  final generatedPwd = ''.obs;

  @override
  void onInit() {
    int id = Get.arguments;
    refreshAcctData(id);
    super.onInit();
  }

  @override
  void onClose() {
    idController.dispose();
    userNameController.dispose();
    platformController.dispose();
    remarkController.dispose();
    updatedAtController.dispose();
    mainPasswordController.dispose();
    super.onClose();
  }

  Future<void> refreshAcctData(int id) async {
    try {
      final appEnvService = Get.find<AppEnvService>();
      final result = await readAcctData(
        appSupportDirectory: appEnvService.applicationSupportDirectory,
        id: id,
      );
      acctData.value = result;
      idController.text = acctData.value?.id.toString() ?? '';
      userNameController.text = acctData.value?.userName ?? '';
      platformController.text = acctData.value?.platform ?? '';
      remarkController.text = acctData.value?.remark ?? '';
      nonceOffset.value = acctData.value?.nonceOffset ?? 0;
      useUpLetter.value = acctData.value?.useUpLetter ?? false;
      useLowLetter.value = acctData.value?.useLowLetter ?? false;
      useNumber.value = acctData.value?.useNumber ?? false;
      useSpecialCharacter.value = acctData.value?.useSpChar ?? false;
      pwdLen.value = acctData.value?.pwdLen ?? 0;
      updatedAtController.text = acctData.value?.updatedAt ?? '';
    } catch (e) {
      debugPrint('Error in readAcctData: $e');
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

  Future<void> onGeneratePwd() async {
    if (mainPasswordController.text.isEmpty) {
      generatedPwd.value = '';
      return;
    }
    final result = await calculatePassword(
      request: CalculatePasswordRequest(
        userName: userNameController.text,
        platform: platformController.text,
        nonceOffset: nonceOffset.value,
        useUpLetter: useUpLetter.value,
        useLowLetter: useLowLetter.value,
        useNumber: useNumber.value,
        useSpChar: useSpecialCharacter.value,
        pwdLen: pwdLen.value,
        mainPassword: mainPasswordController.text,
      ),
    );
    generatedPwd.value = result;
  }

  Future<void> onCopy() async {
    await Clipboard.setData(ClipboardData(text: generatedPwd.value));
  }

  Future<void> toEditView() async {
    Get.toNamed(
      Routes.EDIT_ACCT,
      arguments: {
        'id': idController.text,
        'userName': userNameController.text,
        'platform': platformController.text,
        'remark': remarkController.text,
        'nonceOffset': nonceOffset.value,
        'useUpLetter': useUpLetter.value,
        'useLowLetter': useLowLetter.value,
        'useNumber': useNumber.value,
        'useSpChar': useSpecialCharacter.value,
        'pwdLen': pwdLen.value,
      },
    );
  }
}
