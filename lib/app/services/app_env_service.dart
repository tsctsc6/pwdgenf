import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pwdgenf/src/rust/api/init.dart';

class AppEnvService extends GetxService {
  String applicationSupportDirectory = '';
  String downloadDirectory = '';

  Future<AppEnvService> init() async {
    if (kDebugMode || kProfileMode) {
      initPath(applicationSupportDirectory: 'debug_data');
      applicationSupportDirectory = 'debug_data';
    } else if (kReleaseMode) {
      final directory = await getApplicationSupportDirectory();
      initPath(applicationSupportDirectory: directory.path);
      applicationSupportDirectory = directory.path;
    }
    final directory =
        (await getDownloadsDirectory()) ??
        await getApplicationDocumentsDirectory();
    downloadDirectory = directory.path;
    return this;
  }
}
