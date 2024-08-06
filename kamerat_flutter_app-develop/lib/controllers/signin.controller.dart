import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:kamerat_flutter_app/services/auth.service.dart';
import 'package:kamerat_flutter_app/models/user.model.dart';
import 'package:kamerat_flutter_app/stores/user.store.dart';
import 'package:kamerat_flutter_app/utils/constants.dart';
import 'package:kamerat_flutter_app/utils/fcmtoken.dart';

class SignInController extends GetxController {
  RxBool hidePassword = true.obs;
  RxString error = "".obs;
  RxBool loading = false.obs;

  late TextEditingController emailController;
  late TextEditingController passwordController;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  void togglePasswordVisibility() {
    hidePassword.value = !hidePassword.value;
  }

  void login() async {
    error.value = "";
    if (formKey.currentState!.validate()) {
      loading.value = true;
      final response = await AuthService().login(
        email: emailController.text.toLowerCase().removeAllWhitespace,
        password: passwordController.text.removeAllWhitespace,
      );
      loading.value = false;

      if (response.redirectRoute.isNotEmpty) {
        await Get.offAllNamed(response.redirectRoute);
        return;
      }

      if (response.code == kSuccessCode) {
        await UserStore().login(
          token: response.data["token"],
          refreshToken: response.data["refreshToken"],
        );

        final userResponse = await AuthService().getMe();

        if (response.redirectRoute.isNotEmpty) {
          await Get.offAllNamed(response.redirectRoute);
        }
        if (userResponse.code == kSuccessCode) {
          UserStore().setUser(UserModel.fromJson(userResponse.data));
          fcmTokenRegistration();
          await Get.offAllNamed(kMainRoute);
        } else {
          await Get.offAllNamed(kServiceDownRoute);
        }
      } else if (response.code == kUnauthorizedCode) {
        error.value =
            "Ungültige Zugangsdaten. Überprüfen Sie Ihre E-Mail oder Ihr Passwort.";
      } else if (response.code == kForbiddenCode) {
        error.value =
            "Ihr Konto ist gesperrt. Kontaktieren Sie unser Support-Team";
      }
    }
  }

  void forgetPassword() async {
    error.value = "";
    formKey.currentState!.reset();
    await Get.toNamed(kForgetPasswordRoute);
  }
}
