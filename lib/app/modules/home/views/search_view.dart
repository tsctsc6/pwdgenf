import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pwdgenf/app/modules/home/controllers/home_controller.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key, required this.controller});

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller.searchInputController,
              focusNode: controller.focusNode,
              decoration: InputDecoration(
                hintText: 'search_hint'.tr,
                prefixIcon: const Icon(Icons.search),
                border: const OutlineInputBorder(),
                suffixIcon: controller.searchInputController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () => controller.clearSearchInput(),
                      )
                    : const SizedBox.shrink(),
              ),
              onSubmitted: (_) => controller.refreshTable(),
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => controller.clearSearchInput(),
            child: Text('clear_search_input'.tr),
          ),
          ElevatedButton(
            onPressed: controller.refreshTable,
            child: Text('submit_search'.tr),
          ),
        ],
      ),
    );
  }
}
