import 'package:flutter/material.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';

import 'package:get/get.dart';

import '../controllers/acct_detail_controller.dart';

class AcctDetailView extends GetView<AcctDetailController> {
  const AcctDetailView({super.key});
  static const textFontSize = 16.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() {
          return Row(
            children: [
              Text('acct_detail_view'.tr),
              const Spacer(),
              if (controller.acctData.value != null)
                IconButton(
                  tooltip: 'edit_text'.tr,
                  onPressed: () => controller.toEditView(),
                  icon: Icon(Icons.edit_document),
                ),
            ],
          );
        }),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Obx(() {
              if (controller.acctData.value == null) {
                return CircularProgressIndicator();
              } else {
                return Column(
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
                    TextField(
                      controller: controller.userNameController,
                      readOnly: true,
                      obscureText: false,
                      showCursor: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'user_name_text'.tr,
                      ),
                    ),
                    TextField(
                      controller: controller.platformController,
                      readOnly: true,
                      obscureText: false,
                      showCursor: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'platform_text'.tr,
                      ),
                    ),
                    TextField(
                      controller: controller.remarkController,
                      readOnly: true,
                      obscureText: false,
                      showCursor: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'remark_text'.tr,
                      ),
                    ),
                    SpinBox(
                      readOnly: true,
                      canChange: (_) => false,
                      min: 0,
                      max: 19,
                      direction: Axis.horizontal,
                      value: controller.acctData.value!.nonceOffset.toDouble(),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'nonce_offset'.tr,
                      ),
                    ),
                    SwitchListTile(
                      title: Text(
                        'use_up_letter'.tr,
                        style: TextStyle(fontSize: textFontSize),
                      ),
                      value: controller.useUpLetter.value,
                      onChanged: (bool value) {},
                    ),
                    SwitchListTile(
                      title: Text(
                        'use_low_letter'.tr,
                        style: TextStyle(fontSize: textFontSize),
                      ),
                      value: controller.useLowLetter.value,
                      onChanged: (bool value) {},
                    ),
                    SwitchListTile(
                      title: Text(
                        'use_number'.tr,
                        style: TextStyle(fontSize: textFontSize),
                      ),
                      value: controller.useNumber.value,
                      onChanged: (bool value) {},
                    ),
                    SwitchListTile(
                      title: Text(
                        'use_special_character'.tr,
                        style: TextStyle(fontSize: textFontSize),
                      ),
                      value: controller.useSpecialCharacter.value,
                      onChanged: (bool value) {},
                    ),
                    SpinBox(
                      readOnly: true,
                      canChange: (_) => false,
                      min: 0,
                      max: 255,
                      direction: Axis.horizontal,
                      value: controller.acctData.value!.pwdLen.toDouble(),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'password_length'.tr,
                      ),
                    ),
                    TextField(
                      controller: controller.updatedAtController,
                      readOnly: true,
                      obscureText: false,
                      showCursor: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'updated_at'.tr,
                      ),
                    ),
                    TextField(
                      controller: controller.mainPasswordController,
                      obscureText: controller.obscureMainPassword.value,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'main_password'.tr,
                        suffixIcon: GestureDetector(
                          onTapDown: (_) =>
                              controller.obscureMainPassword.value = false,
                          onTapUp: (_) =>
                              controller.obscureMainPassword.value = true,
                          onTapCancel: () =>
                              controller.obscureMainPassword.value = true,
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
                );
              }
            }),
          ),
        ),
      ),
    );
  }
}
