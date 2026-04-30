import 'package:flutter/material.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';

import 'package:get/get.dart';
import 'package:pwdgenf/app/routes/app_pages.dart';

import '../controllers/acct_detail_controller.dart';

class AcctDetailView extends GetView<AcctDetailController> {
  const AcctDetailView({super.key});
  static const textFontSize = 16.0;
  static const rowSpacing = 8.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() {
          return Row(
            children: [
              const Text('AcctDetailView'),
              const Spacer(),
              if (controller.acctData.value != null)
                IconButton(
                  onPressed: () => Get.toNamed(Routes.EDIT_ACCT),
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
                    Row(
                      children: [
                        Text('Id: ', style: TextStyle(fontSize: textFontSize)),
                        SelectableText(
                          '${controller.acctData.value!.id}',
                          style: TextStyle(fontSize: textFontSize),
                        ),
                      ],
                    ),
                    TextField(
                      controller: controller.userNameController,
                      readOnly: true,
                      obscureText: false,
                      showCursor: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'User Name',
                      ),
                    ),
                    TextField(
                      controller: controller.platformController,
                      readOnly: true,
                      obscureText: false,
                      showCursor: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Platform',
                      ),
                    ),
                    TextField(
                      controller: controller.remarkController,
                      readOnly: true,
                      obscureText: false,
                      showCursor: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Remark',
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
                        labelText: 'Nonce Offset',
                      ),
                    ),
                    SwitchListTile(
                      title: const Text(
                        'Use up letter',
                        style: TextStyle(fontSize: textFontSize),
                      ),
                      value: controller.useUpLetter.value,
                      onChanged: (bool value) {},
                    ),
                    SwitchListTile(
                      title: const Text(
                        'Use low letter',
                        style: TextStyle(fontSize: textFontSize),
                      ),
                      value: controller.useLowLetter.value,
                      onChanged: (bool value) {},
                    ),
                    SwitchListTile(
                      title: const Text(
                        'Use number',
                        style: TextStyle(fontSize: textFontSize),
                      ),
                      value: controller.useNumber.value,
                      onChanged: (bool value) {},
                    ),
                    SwitchListTile(
                      title: const Text(
                        'Use special character',
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
                        labelText: 'Password Length',
                      ),
                    ),
                    Row(
                      children: [
                        const Text(
                          'Updated At: ',
                          style: TextStyle(fontSize: textFontSize),
                        ),
                        SelectableText(
                          controller.acctData.value!.updatedAt,
                          style: TextStyle(fontSize: textFontSize),
                        ),
                      ],
                    ),
                    TextField(
                      controller: controller.mainPasswordController,
                      obscureText: controller.obscureMainPassword.value,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Main Password',
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
