import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:kamerat_flutter_app/services/auth.service.dart';
import 'package:kamerat_flutter_app/utils/constants.dart';

class ForgetPasswordController extends GetxController {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late TextEditingController emailController;

  RxBool loading = false.obs;

  @override
  void onInit() {
    super.onInit();
    emailController = TextEditingController();
  }

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }

  void findAccount() async {
    if (formKey.currentState!.validate()) {
      loading.value = true;
      final response =
          await AuthService().findAccount(email: emailController.text);
      loading.value = false;

      if (response.redirectRoute.isNotEmpty) {
        await Get.offAllNamed(response.redirectRoute);
        return;
      }

      if (response.code == kSuccessCode) {
        await Get.toNamed(kVerifyResetCodeRoute,
            arguments: {"email": emailController.text});
      } else {
        Get.snackbar(
            "Fehler", "Überprüfungscode konnte nicht gesendet werden.");
      }
    }
  }
}
