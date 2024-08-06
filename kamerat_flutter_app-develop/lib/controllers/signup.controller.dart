import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:kamerat_flutter_app/models/response.model.dart';
import 'package:kamerat_flutter_app/services/auth.service.dart';
import 'package:kamerat_flutter_app/models/user.model.dart';
import 'package:kamerat_flutter_app/stores/user.store.dart';
import 'package:kamerat_flutter_app/utils/constants.dart';

class SignUpController extends GetxController {
  RxBool hidePassword = true.obs;
  RxBool hideConfirmPassword = true.obs;

  RxBool loading = false.obs;

  RxString error = "".obs;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;

  @override
  void onInit() {
    super.onInit();
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
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

  void register() async {
    if (formKey.currentState!.validate()) {
      UserModel user = UserModel(
        name: nameController.text,
        email: emailController.text.toLowerCase().removeAllWhitespace,
        password: passwordController.text.removeAllWhitespace,
        confirmPassword: confirmPasswordController.text.removeAllWhitespace,
      );

      loading.value = true;
      ResponseModel response = await AuthService().register(user: user);
      loading.value = false;

      if (response.redirectRoute.isNotEmpty) {
        await Get.offAllNamed(response.redirectRoute);
        return;
      }

      if (response.code == kSuccessCode) {
        error.value = "";
        UserStore().updateUser(UserModel.fromJson(response.data));
        await Get.toNamed(kVerifyEmailRoute);
      } else {
        error.value = response.error;
      }
    }
  }
}
