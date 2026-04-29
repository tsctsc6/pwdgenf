import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/acct_detail_controller.dart';

class AcctDetailView extends GetView<AcctDetailController> {
  const AcctDetailView({super.key});
  @override
  Widget build(BuildContext context) {
    var data = Get.arguments;

    return Scaffold(
      appBar: AppBar(title: const Text('AcctDetailView'), centerTitle: true),
      body: Center(
        child: Text(
          'AcctDetailView is working, data: $data',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
