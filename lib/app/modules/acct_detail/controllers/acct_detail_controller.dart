import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pwdgenf/app/services/app_env_service.dart';
import 'package:pwdgenf/src/rust/api/read_acct_data.dart';

class AcctDetailController extends GetxController {
  //TODO: Implement AcctDetailController

  var id = 0;
  final acctData = Rxn<ReadAcctDataResult>();

  @override
  void onInit() {
    id = Get.arguments;
    _readAcctData().then((result) {
      if (result) {
        return;
      }
    });
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

  /// Returns true if successful, false otherwise.
  Future<bool> _readAcctData() async {
    try {
      await Future.delayed(
        const Duration(seconds: 1),
      ); // Simulate loading delay
      final appEnvService = Get.find<AppEnvService>();
      final result = await readAcctData(
        appSupportDirectory: appEnvService.applicationSupportDirectory,
        id: id,
      );
      acctData.value = result;
      return true;
    } catch (e) {
      debugPrint('Error in readAcctData: $e');
      Get.snackbar(
        "Error",
        "An unexpected error occurred while reading account data.",
      );
      return false;
    }
  }
}
