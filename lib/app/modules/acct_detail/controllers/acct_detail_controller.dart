import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pwdgenf/app/services/app_env_service.dart';
import 'package:pwdgenf/src/rust/api/calculate_password.dart';
import 'package:pwdgenf/src/rust/api/read_acct_data.dart';

class AcctDetailController extends GetxController {
  var id = 0;
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
    id = Get.arguments;
    _readAcctData().then((result) {
      if (!result) {
        return;
      }
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
    });
    super.onInit();
  }

  @override
  void onClose() {
    idController.dispose();
    userNameController.dispose();
    platformController.dispose();
    remarkController.dispose();
    super.onClose();
  }

  /// Returns true if successful, false otherwise.
  Future<bool> _readAcctData() async {
    try {
      final appEnvService = Get.find<AppEnvService>();
      final result = await readAcctData(
        appSupportDirectory: appEnvService.applicationSupportDirectory,
        id: id,
      );
      acctData.value = result;
      return true;
    } catch (e) {
      debugPrint('Error in readAcctData: $e');
      Get.dialog(
        AlertDialog(
          title: const Text('Error'),
          content: Text("$e"),
          actions: [
            TextButton(child: const Text("Close"), onPressed: () => Get.back()),
          ],
        ),
      );
      return false;
    }
  }

  Future<void> onGeneratePwd() async {
    if (mainPasswordController.text.isEmpty) {
      generatedPwd.value = '';
      return;
    }
    final result = await calculatePassword(
      request: Request(
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
}
