import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/acct_detail_controller.dart';

class AcctDetailView extends GetView<AcctDetailController> {
  const AcctDetailView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('AcctDetailView'), centerTitle: true),
      body: Obx(() {
        if (controller.acctData.value == null) {
          return CircularProgressIndicator();
        } else {
          return Text('Account Data: ${controller.acctData.value}');
        }
      }),
    );
  }
}
