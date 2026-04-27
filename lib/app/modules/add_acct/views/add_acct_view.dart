import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/add_acct_controller.dart';

class AddAcctView extends GetView<AddAcctController> {
  const AddAcctView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AddAcctView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'AddAcctView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
