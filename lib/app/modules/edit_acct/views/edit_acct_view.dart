import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/edit_acct_controller.dart';

class EditAcctView extends GetView<EditAcctController> {
  const EditAcctView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EditAcctView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'EditAcctView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
