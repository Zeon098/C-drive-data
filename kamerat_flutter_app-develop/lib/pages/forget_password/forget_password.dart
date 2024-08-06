import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:kamerat_flutter_app/controllers/forget_password.controller.dart';
import 'package:kamerat_flutter_app/components/app_loader.dart';
import 'package:kamerat_flutter_app/components/app_button.dart';
import 'package:kamerat_flutter_app/components/app_bar.dart';

class ForgetPassword extends GetView<ForgetPasswordController> {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    ForgetPasswordController controller = Get.find<ForgetPasswordController>();
    return Scaffold(
      appBar: const MyAppBar(title: ""),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: ListView(
          children: [
            const SizedBox(height: 48.0),
            Text("Setze dein Passwort zurück",
                style: Theme.of(context).textTheme.displaySmall!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.tertiary,
                    )),
            const SizedBox(height: 8.0),
            Text(
                "Geben Sie die mit Ihrem Konto verknüpfte E-Mail-Adresse ein und wir senden Ihnen einen Link zum Zurücksetzen Ihres Passworts",
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).colorScheme.onBackground,
                    )),
            const SizedBox(height: 32.0),
            Form(
                key: controller.formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: controller.emailController,
                      decoration: const InputDecoration(
                        prefixIcon: Image(
                          image: AssetImage("assets/icons/email.png"),
                        ),
                        hintText: "Email",
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 16, vertical: 15.0),
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
                    const SizedBox(height: 32.0),
                    Obx(
                      () => controller.loading.value
                          ? const AppLoader()
                          : AppButton(
                              title: "Zurücksetzen",
                              onPressed: controller.findAccount,
                            ),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
