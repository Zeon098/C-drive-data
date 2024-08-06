import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:kamerat_flutter_app/services/auth.service.dart';
import 'package:kamerat_flutter_app/utils/constants.dart';

class ResetPasswordController extends GetxController {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  RxBool hidePassword = true.obs;
  RxBool hideConfirmPassword = true.obs;

  RxBool loading = false.obs;

  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;

  @override
  void onInit() {
    super.onInit();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
  }

  @override
  void onClose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }

  void toggleHidePassword() {
    hidePassword.value = !hidePassword.value;
  }

  void toggleHideConfirmPassword() {
    hideConfirmPassword.value = !hideConfirmPassword.value;
  }

  void resetPassword(String token) async {
    if (formKey.currentState!.validate()) {
      loading.value = true;
      final response = await AuthService().resetPassword(
        password: passwordController.text,
        token: token,
      );

      if (response.redirectRoute.isNotEmpty) {
        await Get.offAllNamed(response.redirectRoute);
        return;
      }

      if (response.code == kSuccessCode) {
        await Get.offAllNamed(kResetPasswordSuccessfulRoute);
      } else {
        Get.snackbar("Fehler",
            "Passwort zurücksetzen fehlgeschlagen. Bitte versuche es später noch einmal");
      }
    }
  }
}
