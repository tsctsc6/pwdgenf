import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Obx(() {
        if (controller.isLoading.value) {
          return CircularProgressIndicator();
        } else {
          return Text('hello'.tr, style: TextStyle(fontSize: 20));
        }
      }),
    );
  }
}
