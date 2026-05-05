import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pwdgenf/app/modules/home/controllers/home_controller.dart';

class AcctDataTableView extends StatelessWidget {
  const AcctDataTableView({super.key, required this.controller});

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (!controller.isReady.value) {
        return const Center(
          child: SizedBox(
            width: 32,
            height: 32,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
        );
      } else {
        return Expanded(
          child: AsyncPaginatedDataTable2(
            columnSpacing: 12,
            horizontalMargin: 12,
            minWidth: 300,
            columns: [
              DataColumn2(
                label: Center(child: Text('table_header_ID'.tr)),
                size: ColumnSize.S,
              ),
              DataColumn2(
                label: Center(child: Text('table_header_UserName'.tr)),
                size: ColumnSize.L,
              ),
              DataColumn2(
                label: Center(child: Text('table_header_Platform'.tr)),
                size: ColumnSize.L,
              ),
            ],
            source: controller.dataSource,
            controller: controller.paginatorController,
            loading: const Center(
              child: SizedBox(
                width: 32,
                height: 32,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            ),
            errorBuilder: (e) => Center(
              child: Text(
                '$e',
                style: TextStyle(color: Get.theme.colorScheme.error),
              ),
            ),
            empty: Center(child: Text('no_data'.tr)),
          ),
        );
      }
    });
  }
}
