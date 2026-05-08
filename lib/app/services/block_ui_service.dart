import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';

class BlockUIService extends GetxService {
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  Future<T> runWithBlockUI<T>(Future<T> Function() task) async {
    _isLoading.value = true;
    try {
      return await Get.showOverlay(
        asyncFunction: task,
        loadingWidget: const Center(child: CircularProgressIndicator()),
        opacity: 0.5,
        opacityColor: Colors.black,
      );
    } finally {
      _isLoading.value = false;
    }
  }
}
