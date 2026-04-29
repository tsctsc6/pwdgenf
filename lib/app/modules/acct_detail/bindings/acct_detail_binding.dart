import 'package:get/get.dart';

import '../controllers/acct_detail_controller.dart';

class AcctDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AcctDetailController>(
      () => AcctDetailController(),
    );
  }
}
