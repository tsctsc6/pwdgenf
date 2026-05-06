import 'package:flutter/material.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';

import 'package:get/get.dart';

import '../controllers/edit_acct_controller.dart';

class EditAcctView extends GetView<EditAcctController> {
  const EditAcctView({super.key});
  static const textFontSize = 16.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text('edit_detail_view'.tr),
            const Spacer(),
            IconButton(
              tooltip: 'delete_text'.tr,
              onPressed: () => controller.onDeleteAcct(),
              icon: Icon(Icons.delete_forever),
              color: Get.theme.colorScheme.error,
            ),
            IconButton(
              tooltip: 'save_text'.tr,
              onPressed: () => controller.onSave(),
              icon: Icon(Icons.save),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Obx(() {
              return Form(
                key: controller.formKey,
                child: Column(
                  spacing: 16.0,
                  children: [
                    TextField(
                      controller: controller.idController,
                      readOnly: true,
                      obscureText: false,
                      showCursor: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Id',
                      ),
                    ),
                    TextFormField(
                      controller: controller.userNameController,
                      obscureText: false,
                      showCursor: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'user_name_text'.tr,
                      ),
                      validator: controller.validateUserName,
                      focusNode: controller.userNameFocusNode,
                    ),
                    TextFormField(
                      controller: controller.platformController,
                      obscureText: false,
                      showCursor: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'platform_text'.tr,
                      ),
                      validator: controller.validatePlatform,
                      focusNode: controller.platformFocusNode,
                    ),
                    TextField(
                      controller: controller.remarkController,
                      obscureText: false,
                      showCursor: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'remark_text'.tr,
                      ),
                    ),
                    SpinBox(
                      min: 0,
                      max: 19,
                      direction: Axis.horizontal,
                      value: controller.nonceOffset.value,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'nonce_offset'.tr,
                      ),
                      onChanged: (value) =>
                          controller.nonceOffset.value = value,
                      onSubmitted: (value) =>
                          controller.nonceOffset.value = value,
                    ),
                    SwitchListTile(
                      title: Text(
                        'use_up_letter'.tr,
                        style: TextStyle(fontSize: textFontSize),
                      ),
                      value: controller.useUpLetter.value,
                      onChanged: (bool value) =>
                          controller.useUpLetter.value = value,
                    ),
                    SwitchListTile(
                      title: Text(
                        'use_low_letter'.tr,
                        style: TextStyle(fontSize: textFontSize),
                      ),
                      value: controller.useLowLetter.value,
                      onChanged: (bool value) =>
                          controller.useLowLetter.value = value,
                    ),
                    SwitchListTile(
                      title: Text(
                        'use_number'.tr,
                        style: TextStyle(fontSize: textFontSize),
                      ),
                      value: controller.useNumber.value,
                      onChanged: (bool value) =>
                          controller.useNumber.value = value,
                    ),
                    SwitchListTile(
                      title: Text(
                        'use_special_character'.tr,
                        style: TextStyle(fontSize: textFontSize),
                      ),
                      value: controller.useSpecialCharacter.value,
                      onChanged: (bool value) =>
                          controller.useSpecialCharacter.value = value,
                    ),
                    SpinBox(
                      min: 0,
                      max: 255,
                      direction: Axis.horizontal,
                      value: controller.pwdLen.value,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'password_length'.tr,
                      ),
                      onChanged: (value) => controller.pwdLen.value = value,
                      onSubmitted: (value) => controller.pwdLen.value = value,
                    ),
                    TextField(
                      controller: controller.mainPasswordController,
                      obscureText: controller.obscureMainPassword.value,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'main_password'.tr,
                        suffixIcon: GestureDetector(
                          onTap: () => controller.obscureMainPassword.value =
                              !controller.obscureMainPassword.value,
                          child: Icon(
                            controller.obscureMainPassword.value
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      onSubmitted: (_) => controller.onGeneratePwd(),
                    ),
                    Row(
                      children: [
                        Text(
                          'generated_password_text'.tr,
                          style: TextStyle(fontSize: textFontSize),
                        ),
                        SelectableText(
                          controller.generatedPwd.value,
                          style: TextStyle(fontSize: textFontSize),
                        ),
                        if (controller.generatedPwd.isNotEmpty)
                          IconButton(
                            tooltip: 'copy_text'.tr,
                            icon: const Icon(Icons.copy),
                            onPressed: () => controller.onCopy(),
                          ),
                      ],
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
