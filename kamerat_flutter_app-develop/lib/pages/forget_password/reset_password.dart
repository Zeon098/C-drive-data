import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kamerat_flutter_app/components/app_loader.dart';

import 'package:kamerat_flutter_app/controllers/reset_passwrod.controller.dart';
import 'package:kamerat_flutter_app/components/app_button.dart';

class ResetPassword extends GetView<ResetPasswordController> {
  const ResetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    ResetPasswordController controller = Get.find<ResetPasswordController>();
    Map<String, dynamic> arguments = Get.arguments;
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: ListView(
            children: [
              const SizedBox(height: 80.0),
              Text("Neues Passwort erstellen",
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.tertiary,
                      )),
              const SizedBox(height: 8.0),
              Text(
                  "Ihr neues Passwort muss sich von Ihrem zuvor verwendeten Passwort unterscheiden",
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).colorScheme.onBackground,
                      )),
              const SizedBox(height: 32.0),
              Form(
                  key: controller.formKey,
                  child: Column(
                    children: [
                      Obx(
                        () => TextFormField(
                          controller: controller.passwordController,
                          obscureText: controller.hidePassword.value,
                          decoration: InputDecoration(
                            prefixIcon: Image.asset("assets/icons/lock.png"),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 15.0,
                            ),
                            hintText: "Passwort",
                            suffixIcon: Padding(
                              padding: const EdgeInsets.only(top: 3.0),
                              child: GestureDetector(
                                onTap: controller.toggleHidePassword,
                                child: controller.hidePassword.value
                                    ? Image.asset("assets/icons/eye_closed.png")
                                    : Image.asset(
                                        "assets/icons/eye_opened.png"),
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Passwort ist erforderlich";
                            } else if (value.length < 6) {
                              return "Das Passwort sollte mindestens 6 Zeichen lang sein.";
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      Obx(
                        () => TextFormField(
                          controller: controller.confirmPasswordController,
                          obscureText: controller.hideConfirmPassword.value,
                          decoration: InputDecoration(
                            prefixIcon: Image.asset("assets/icons/lock.png"),
                            hintText: "Passwort wiederholen",
                            suffixIcon: Padding(
                              padding: const EdgeInsets.only(top: 4.0),
                              child: GestureDetector(
                                onTap: controller.toggleHideConfirmPassword,
                                child: controller.hideConfirmPassword.value
                                    ? Image.asset("assets/icons/eye_closed.png")
                                    : Image.asset(
                                        "assets/icons/eye_opened.png"),
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Passwort bestätigen ist erforderlich";
                            } else if (value !=
                                controller.passwordController.text) {
                              return "Passwörter stimmen nicht überein";
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 32.0),
                      Obx(
                        () => controller.loading.value
                            ? const AppLoader()
                            : AppButton(
                                title: "Passwort zurücksetzen",
                                onPressed: () {
                                  controller.resetPassword(arguments['token']);
                                }),
                      )
                    ],
                  )),
            ],
          )),
    );
  }
}
