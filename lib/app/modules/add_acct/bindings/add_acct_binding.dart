import 'package:get/get.dart';

import '../controllers/add_acct_controller.dart';

class AddAcctBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddAcctController>(
      () => AddAcctController(),
    );
  }
}
