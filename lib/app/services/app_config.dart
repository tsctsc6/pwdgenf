import 'dart:io';

import 'package:flutter/services.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/state_manager.dart';
import 'package:pwdgenf/app/services/app_env_service.dart';
import 'package:toml/toml.dart';

class AppConfig extends GetxService {
  static const configExamplePath = 'assets/config.example.toml';
  bool followSystemLanguage;
  String languageCode;
  String countryCode;

  AppConfig({
    required this.followSystemLanguage,
    required this.languageCode,
    required this.countryCode,
  });

  static Future<AppConfig> fromFile() async {
    final appEnvService = Get.find<AppEnvService>();
    final configFile = File(
      '${appEnvService.applicationSupportDirectory}/config.toml',
    );
    if (!await configFile.exists()) {
      final configExample = await rootBundle.loadString(configExamplePath);
      await configFile.writeAsString(configExample);
    }
    final document = TomlDocument.parse(await configFile.readAsString());
    final map = document.toMap();
    return AppConfig.fromMap(map);
  }

  factory AppConfig.fromMap(Map<String, dynamic> map) {
    return AppConfig(
      followSystemLanguage: map['follow_system_language'] ?? true,
      languageCode: map['language_code'] ?? 'en',
      countryCode: map['country_code'] ?? 'US',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'follow_system_language': followSystemLanguage,
      'language_code': languageCode,
      'country_code': countryCode,
    };
  }

  Future<void> toFile() async {
    final appEnvService = Get.find<AppEnvService>();
    final configFile = File(
      '${appEnvService.applicationSupportDirectory}/config.toml',
    );
    final map = toMap();
    final document = TomlDocument.fromMap(map);
    await configFile.writeAsString(document.toString());
  }
}
