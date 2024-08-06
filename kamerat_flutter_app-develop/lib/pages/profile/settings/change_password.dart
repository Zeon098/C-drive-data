import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kamerat_flutter_app/components/app_bar.dart';
import 'package:kamerat_flutter_app/components/app_button.dart';
import 'package:kamerat_flutter_app/components/app_loader.dart';

import 'package:kamerat_flutter_app/controllers/change_password.controller.dart';

class PasswordChange extends GetView<PasswordChangeController> {
  const PasswordChange({super.key});

  @override
  Widget build(BuildContext context) {
    PasswordChangeController controller = Get.find<PasswordChangeController>();
    return Scaffold(
      appBar: const MyAppBar(title: "Kennwort ändern"),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 16.0),
        child: Form(
          key: controller.formKey,
          child: ListView(
            children: [
              Obx(
                () => TextFormField(
                  controller: controller.currentPasswordController,
                  obscureText: controller.hideCurrentPassword.value,
                  decoration: InputDecoration(
                    prefixIcon: Image.asset("assets/icons/lock.png"),
                    hintText: "Current Password",
                    suffixIcon: Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: GestureDetector(
                        onTap: () {
                          controller.hideCurrentPassword.value =
                              !controller.hideCurrentPassword.value;
                        },
                        child: controller.hideCurrentPassword.value
                            ? Image.asset("assets/icons/eye_closed.png")
                            : Image.asset("assets/icons/eye_opened.png"),
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Current password is required";
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 16.0),
              Obx(
                () => TextFormField(
                  controller: controller.newPasswordController,
                  obscureText: controller.hideNewPassword.value,
                  decoration: InputDecoration(
                    prefixIcon: Image.asset("assets/icons/lock.png"),
                    hintText: "New Password",
                    suffixIcon: Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: GestureDetector(
                        onTap: () {
                          controller.hideNewPassword.value =
                              !controller.hideNewPassword.value;
                        },
                        child: controller.hideNewPassword.value
                            ? Image.asset("assets/icons/eye_closed.png")
                            : Image.asset("assets/icons/eye_opened.png"),
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "New password is required";
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
                    hintText: "Passwort bestätigen",
                    suffixIcon: Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: GestureDetector(
                        onTap: () {
                          controller.hideConfirmPassword.value =
                              !controller.hideConfirmPassword.value;
                        },
                        child: Obx(() => controller.hideConfirmPassword.value
                            ? Image.asset("assets/icons/eye_closed.png")
                            : Image.asset("assets/icons/eye_opened.png")),
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Confirm password is required";
                    } else if (value != controller.newPasswordController.text) {
                      return "Passwords do not match";
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 32.0),
              Obx(
                () => controller.processing.value
                    ? const AppLoader()
                    : AppButton(
                        title: "Change password",
                        onPressed: controller.changePassword,
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
