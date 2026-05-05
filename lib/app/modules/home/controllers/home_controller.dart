import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pwdgenf/app/routes/app_pages.dart';
import 'package:pwdgenf/app/services/app_env_service.dart';
import 'package:pwdgenf/src/rust/api/init.dart';
import 'package:pwdgenf/src/rust/api/read_all_acct_data.dart';
import 'package:data_table_2/data_table_2.dart';

class HomeController extends GetxController {
  final isReady = true.obs;

  late final AcctDataAsyncDataSource dataSource;
  final PaginatorController paginatorController = PaginatorController();

  final TextEditingController searchInputController = TextEditingController();
  final FocusNode focusNode = FocusNode();
  var searchTerm = '';
  final hasSearchText = false.obs;

  @override
  void onInit() {
    super.onInit();
    searchInputController.addListener(_onSearchTextChanged);
    initDatabase().then((result) {
      if (!result) {
        return;
      }
      dataSource = AcctDataAsyncDataSource(controller: this);
      isReady.value = true;
    });
  }

  void _onSearchTextChanged() {
    hasSearchText.value = searchInputController.text.isNotEmpty;
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
      Get.dialog(
        AlertDialog(
          title: const Text('Error'),
          content: Text("$e"),
          actions: [
            TextButton(
              child: Text('close_text'.tr),
              onPressed: () => Get.back(),
            ),
          ],
        ),
      );
      return false;
    }
  }

  void goToFirstPageAndRefreshTable() {
    searchTerm = searchInputController.text;
    paginatorController.goToFirstPage();
    dataSource.refreshDatasource();
    debugPrint('Refreshing table with search term: $searchTerm');
  }

  void refreshTable() {
    searchTerm = searchInputController.text;
    dataSource.refreshDatasource();
    debugPrint('Refreshing table with search term: $searchTerm');
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
    debugPrint('Requesting rows from $startIndex to ${startIndex + count - 1}');
    if (startIndex < 0 || count <= 0) {
      return AsyncRowsResponse(0, []);
    }
    debugPrint('pageIndex ${startIndex ~/ count + 1}, pageSize $count');

    try {
      final appEnvService = Get.find<AppEnvService>();
      var response = await readAllAcctData(
        appSupportDirectory: appEnvService.applicationSupportDirectory,
        searchTerm: controller.searchTerm,
        pageIndex: BigInt.from(startIndex ~/ count),
        pageSize: BigInt.from(count),
      );
      // out bound
      if (response.totalCount != BigInt.zero && response.pageContent.isEmpty) {
        controller.paginatorController.goToPreviousPage();
        debugPrint('out bound!');
        response = await readAllAcctData(
          appSupportDirectory: appEnvService.applicationSupportDirectory,
          searchTerm: controller.searchTerm,
          pageIndex: BigInt.from(startIndex ~/ count) - BigInt.one,
          pageSize: BigInt.from(count),
        );
      }

      debugPrint(
        'Received ${response.pageContent.length} rows, totalCount: ${response.totalCount}',
      );

      final rows = response.pageContent.map((acct) {
        return DataRow2(
          onTap: () {
            Get.toNamed(Routes.ACCT_DETAIL, arguments: acct.id);
          },

          cells: [
            DataCell(Center(child: Text(acct.id.toString()))),
            DataCell(
              Center(
                child: buildHighlightedText(
                  acct.userName,
                  controller.searchTerm,
                ),
              ),
            ),
            DataCell(
              Center(
                child: buildHighlightedText(
                  acct.platform,
                  controller.searchTerm,
                ),
              ),
            ),
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

Widget buildHighlightedText(String text, String keyword) {
  if (!text.contains(keyword)) {
    return Text(text);
  }

  List<String> parts = text.split(keyword);
  List<TextSpan> spans = [];

  for (int i = 0; i < parts.length; i++) {
    if (parts[i].isNotEmpty) {
      spans.add(TextSpan(text: parts[i]));
    }
    if (i < parts.length - 1) {
      spans.add(
        TextSpan(
          text: keyword,
          style: TextStyle(
            color: Get.theme.colorScheme.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }
  }

  return Text.rich(TextSpan(children: spans));
}
