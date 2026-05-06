import 'package:get/get.dart';

import '../controllers/edit_acct_controller.dart';

class EditAcctBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditAcctController>(
      () => EditAcctController(),
    );
  }
}
