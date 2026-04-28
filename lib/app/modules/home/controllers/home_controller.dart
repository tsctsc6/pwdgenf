import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pwdgenf/src/rust/api/init.dart';

class HomeController extends GetxController {
  final isLoading = true.obs;
  @override
  void onInit() {
    super.onInit();
    isLoading.value = true;
    initDatabase().then((result) {
      if (!result) {
        isLoading.value = false;
        return;
      }
      getAcctData().then((_) {
        isLoading.value = false;
      });
    });
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  /// Initializes the database by running migrations. Returns true if successful, false otherwise.
  Future<bool> initDatabase() async {
    try {
      await initMigrate();
      return true;
    } catch (e) {
      debugPrint('Error in InitDatabase: $e');
      Get.snackbar(
        "Error in InitDatabase",
        e.toString(),
        colorText: Get.theme.colorScheme.error,
        duration: Duration(seconds: 10),
      );
      return false;
    }
  }

  Future<void> getAcctData() async {
    try {
      await Future.delayed(Duration(seconds: 2));
    } catch (e) {
      debugPrint('Error in GetAcctData: $e');
    }
  }
}
