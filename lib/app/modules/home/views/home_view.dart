import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pwdgenf/app/modules/home/views/acct_data_table_view.dart';
import 'package:pwdgenf/app/routes/app_pages.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      drawer: drawer(),
      body: body(),
      floatingActionButton: floatingActionButton(),
    );
  }

  PreferredSizeWidget appBar() {
    return AppBar(
      title: SearchBar(
        controller: controller.searchInputController,
        hintText: 'search_hint'.tr,
        constraints: const BoxConstraints(maxHeight: 50),
        padding: const WidgetStatePropertyAll<EdgeInsets>(
          EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        ),
        leading: const Icon(Icons.search),
        trailing: <Widget>[
          Obx(() {
            if (controller.hasSearchText.value) {
              return IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  controller.clearSearchInput();
                },
                constraints: const BoxConstraints(maxHeight: 40, maxWidth: 40),
                padding: const EdgeInsets.all(1),
              );
            } else {
              return const SizedBox.shrink();
            }
          }),
        ],
        onSubmitted: (String value) {
          controller.refreshTable();
        },
      ),
    );
  }

  Widget drawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Get.theme.colorScheme.primary),
            child: Text(
              'menu_text'.tr,
              style: TextStyle(
                color: Get.theme.colorScheme.onPrimary,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: Text('menu_settings'.tr),
            onTap: () {
              Get.back(); // close the drawer on tap
              Get.toNamed(Routes.SETTINGS);
            },
          ),
        ],
      ),
    );
  }

  Widget body() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [AcctDataTableView(controller: controller)]),
      ),
    );
  }

  Widget floatingActionButton() {
    return FloatingActionButton(
      onPressed: () {
        Get.toNamed(Routes.ADD_ACCT);
      },
      child: const Icon(Icons.add),
    );
  }
}
