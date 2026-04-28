import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pwdgenf/app/services/app_env_service.dart';
import 'package:pwdgenf/src/rust/api/init.dart';
import 'package:pwdgenf/src/rust/api/read_all_acct_data.dart';
import 'package:data_table_2/data_table_2.dart';

class HomeController extends GetxController {
  late final AcctDataAsyncDataSource dataSource;
  final PaginatorController paginatorController = PaginatorController();
  final isDataSourceReady = false.obs;

  final TextEditingController searchInputController = TextEditingController();
  final FocusNode focusNode = FocusNode();
  var searchTerm = '';

  @override
  void onInit() {
    super.onInit();
    initDatabase().then((result) {
      if (!result) {
        return;
      }
      dataSource = AcctDataAsyncDataSource(controller: this);
      isDataSourceReady.value = true;
    });
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    paginatorController.dispose();
    searchInputController.dispose();
    focusNode.dispose();
    super.onClose();
  }

  /// Initializes the database by running migrations. Returns true if successful, false otherwise.
  Future<bool> initDatabase() async {
    try {
      final appEnvService = Get.find<AppEnvService>();
      await initMigrate(
        applicationSupportDirectory: appEnvService.applicationSupportDirectory,
      );
      return true;
    } catch (e) {
      debugPrint('Error in InitDatabase: $e');
      Get.snackbar(
        "Error in InitDatabase",
        e.toString(),
        colorText: Get.theme.colorScheme.error,
        duration: Duration(seconds: 10),
      );
      return false;
    }
  }

  void refreshTable() {
    searchTerm = searchInputController.text;
    paginatorController.goToFirstPage();
    dataSource.refreshDatasource();
    debugPrint('Refreshing table with search term: $searchTerm');
    debugPrint("hashCode: ${dataSource.hashCode.toString()}");
  }

  void clearSearchInput() {
    searchInputController.clear();
    searchTerm = searchInputController.text;
    focusNode.requestFocus();
  }
}

class AcctDataAsyncDataSource extends AsyncDataTableSource {
  final HomeController controller;

  AcctDataAsyncDataSource({required this.controller});

  // getRows will be called by AsyncPaginatedDataTable2 when it needs to fetch a new page of data.
  @override
  Future<AsyncRowsResponse> getRows(int startIndex, int count) async {
    debugPrint("hashCode: ${hashCode.toString()}");
    if (startIndex < 0 || count <= 0) {
      return AsyncRowsResponse(0, []);
    }
    debugPrint('Requesting rows from $startIndex to ${startIndex + count - 1}');
    debugPrint('pageIndex ${startIndex ~/ count + 1}, pageSize $count');

    try {
      final appEnvService = Get.find<AppEnvService>();
      final response = await readAllAcctData(
        appSupportDirectory: appEnvService.applicationSupportDirectory,
        searchTerm: controller.searchTerm,
        pageIndex: BigInt.from(startIndex ~/ count),
        pageSize: BigInt.from(count),
      );

      debugPrint(
        'Received ${response.pageContent.length} rows, totalCount: ${response.totalCount}',
      );

      final rows = response.pageContent.map((acct) {
        return DataRow(
          cells: [
            DataCell(Text(acct.id.toString())),
            DataCell(Text(acct.userName)),
            DataCell(Text(acct.platform)),
          ],
        );
      }).toList();

      return AsyncRowsResponse(response.totalCount.toInt(), rows);
    } catch (e) {
      debugPrint('Error in GetAcctData: $e');
      rethrow;
    }
  }
}
