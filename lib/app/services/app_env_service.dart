import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pwdgenf/src/rust/api/init.dart';

class AppEnvService extends GetxService {
  String applicationSupportDirectory = '';
  String downloadDirectory = '';
  late PackageInfo packageInfo;

  Future<AppEnvService> init() async {
    if (kDebugMode || kProfileMode) {
      applicationSupportDirectory = 'debug_data';
    } else if (kReleaseMode) {
      final directory = await getApplicationSupportDirectory();
      applicationSupportDirectory = directory.path;
    }
    initPath(applicationSupportDirectory: applicationSupportDirectory);
    final directory =
        (await getDownloadsDirectory()) ??
        await getApplicationDocumentsDirectory();
    downloadDirectory = directory.path;
    packageInfo = await PackageInfo.fromPlatform();
    return this;
  }
}
