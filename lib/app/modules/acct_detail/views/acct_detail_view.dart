import 'package:flutter/material.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';

import 'package:get/get.dart';

import '../controllers/acct_detail_controller.dart';

class AcctDetailView extends GetView<AcctDetailController> {
  const AcctDetailView({super.key});
  static const textFontSize = 16.0;
  static const rowSpacing = 8.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('AcctDetailView'), centerTitle: true),
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
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'User Name',
                      ),
                    ),
                    TextField(
                      controller: controller.platformController,
                      readOnly: true,
                      obscureText: false,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Platform',
                      ),
                    ),
                    TextField(
                      controller: controller.remarkController,
                      readOnly: true,
                      obscureText: false,
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
                    Row(
                      spacing: rowSpacing,
                      children: [
                        const Text(
                          'Use up letter',
                          style: TextStyle(fontSize: textFontSize),
                        ),
                        Switch(
                          value: controller.useUpLetter.value,
                          activeThumbColor: Get.theme.colorScheme.primary,
                          onChanged: (bool value) {},
                        ),
                      ],
                    ),
                    Row(
                      spacing: rowSpacing,
                      children: [
                        const Text(
                          'Use low letter',
                          style: TextStyle(fontSize: textFontSize),
                        ),
                        Switch(
                          value: controller.useLowLetter.value,
                          activeThumbColor: Get.theme.colorScheme.primary,
                          onChanged: (bool value) {},
                        ),
                      ],
                    ),
                    Row(
                      spacing: rowSpacing,
                      children: [
                        const Text(
                          'Use number',
                          style: TextStyle(fontSize: textFontSize),
                        ),
                        Switch(
                          value: controller.useNumber.value,
                          activeThumbColor: Get.theme.colorScheme.primary,
                          onChanged: (bool value) => {},
                        ),
                      ],
                    ),
                    Row(
                      spacing: rowSpacing,
                      children: [
                        const Text(
                          'Use special character',
                          style: TextStyle(fontSize: textFontSize),
                        ),
                        Switch(
                          value: controller.useSpecialCharacter.value,
                          activeThumbColor: Get.theme.colorScheme.primary,
                          onChanged: (bool value) => {},
                        ),
                      ],
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
                        const Text(
                          'Generated Password: ',
                          style: TextStyle(fontSize: textFontSize),
                        ),
                        SelectableText(
                          controller.generatedPwd.value,
                          style: TextStyle(fontSize: textFontSize),
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
