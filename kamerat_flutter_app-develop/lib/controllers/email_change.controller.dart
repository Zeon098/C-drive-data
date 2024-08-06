import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kamerat_flutter_app/services/auth.service.dart';
import 'package:kamerat_flutter_app/utils/constants.dart';

class EmailChangeController extends GetxController {
  late TextEditingController emailController;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  RxBool isProcessing = false.obs;

  @override
  void onInit() {
    emailController = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }

  void changeEmail() async {
    if (formKey.currentState!.validate()) {
      isProcessing.value = true;
      final response =
          await AuthService().changeEmail(email: emailController.text);
      isProcessing.value = false;

      if (response.redirectRoute.isNotEmpty) {
        await Get.offAllNamed(response.redirectRoute);
        return;
      }

      if (response.code == kSuccessCode) {
      } else {
        Get.back();
        Get.snackbar("Fehler", "E-Mail-Änderung fehlgeschlagen");
      }
    }
  }
}
