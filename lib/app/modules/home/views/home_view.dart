import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pwdgenf/app/modules/home/views/acct_data_table_view.dart';
import 'package:pwdgenf/app/modules/home/views/search_view.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SearchView(controller: controller),
            AcctDataTableView(controller: controller),
          ],
        ),
      ),
    );
  }
}
