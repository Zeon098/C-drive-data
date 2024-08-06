import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kamerat_flutter_app/components/app_bar.dart';
import 'package:kamerat_flutter_app/components/app_button.dart';
import 'package:kamerat_flutter_app/components/app_loader.dart';

import 'package:kamerat_flutter_app/controllers/email_change.controller.dart';

class EmailChange extends GetView<EmailChangeController> {
  const EmailChange({super.key});

  @override
  Widget build(BuildContext context) {
    EmailChangeController controller = Get.find<EmailChangeController>();
    return Scaffold(
      appBar: const MyAppBar(title: "Ändern Sie Ihre E-Mail"),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 16.0),
        child: Column(
          children: [
            Form(
              key: controller.formKey,
              child: TextFormField(
                controller: controller.emailController,
                decoration: InputDecoration(
                  prefixIcon: Image.asset("assets/icons/email.png"),
                  hintText: "Neue Email Adresse",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Email ist erforderlich";
                  } else if (!GetUtils.isEmail(value)) {
                    return "Geben sie eine gültige E-Mail-Adresse an.";
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(height: 32.0),
            Obx(
              () => controller.isProcessing.value
                  ? const AppLoader()
                  : AppButton(
                      title: "Weitermachen",
                      onPressed: controller.changeEmail,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
