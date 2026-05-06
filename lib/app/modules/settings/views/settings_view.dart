import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/settings_controller.dart';

class SettingsView extends GetView<SettingsController> {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('settings_view'.tr), centerTitle: true),
      body: ListView(
        children: [
          _buildSectionHeader('normal_settings_group_text'.tr),
          ListTile(
            leading: const Icon(Icons.language),
            title: Text('language_text'.tr),
            subtitle: Text(controller.language.value),
            onTap: () => controller.setLanguage(),
          ),
          _buildSectionHeader('backup_and_restore_group_text'.tr),
          ListTile(
            leading: const Icon(Icons.upload),
            title: Text('backup_text'.tr),
            onTap: () => controller.backup(),
          ),
          ListTile(
            leading: const Icon(Icons.download),
            title: Text('restore_text'.tr),
            onTap: () => controller.restore(),
          ),
          _buildSectionHeader('misc_group_text'.tr),
          ListTile(
            leading: const Icon(Icons.info),
            title: Text('about_text'.tr),
            onTap: () => controller.showAbout(),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 16.0,
        right: 16.0,
        top: 16.0,
        bottom: 8.0,
      ),
      child: Text(
        title,
        style: TextStyle(
          color: Get.theme.colorScheme.primary,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
