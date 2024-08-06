import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';

import 'package:kamerat_flutter_app/models/response.model.dart';
import 'package:kamerat_flutter_app/services/auth.service.dart';
import 'package:kamerat_flutter_app/models/user.model.dart';
import 'package:kamerat_flutter_app/stores/user.store.dart';
import 'package:kamerat_flutter_app/utils/constants.dart';
import 'package:kamerat_flutter_app/utils/fcmtoken.dart';

class VerifyEmailController extends GetxController {
  RxInt timer = 50.obs;
  RxBool showReSendCode = false.obs;
  RxBool valid = false.obs;
  RxInt code = 0.obs;

  RxString error = "".obs;

  RxBool loading = false.obs;

  void startTimer() {
    Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      if (this.timer.value == 0) {
        timer.cancel();
        showReSendCode.value = true;
      } else {
        this.timer.value--;
      }
    });
  }

  void otpControllers(List<TextEditingController?> controllers) {
    for (var controller in controllers) {
      if (controller!.text.length == 1) {
        valid.value = true;
      } else {
        valid.value = false;
        break;
      }
    }
  }

  @override
  void onInit() {
    super.onInit();
    startTimer();
  }

  void verifyEmail() async {
    if (!valid.value) return;

    UserModel user = UserStore().user;

    loading.value = true;
    ResponseModel response = await AuthService().verifyEmail(
      userId: user.id,
      code: code.value,
    );
    loading.value = false;

    if (response.redirectRoute.isNotEmpty) {
      await Get.offAllNamed(response.redirectRoute);
      return;
    }

    if (response.code == kSuccessCode) {
      UserStore().login(
        token: response.data["token"],
        refreshToken: response.data["refreshToken"],
      );
      UserStore().setUser(user);
      fcmTokenRegistration();
      await Get.offAllNamed(kOnBoardingGenderRoute);
    } else {
      error.value = "E-Mail-Überprüfung fehlgeschlagen. Versuche es erneut";
      timer.value = 0;
    }
  }

  void resendVerificationCode() async {
    ResponseModel response =
        await AuthService().resendVerificationCode(userId: UserStore().user.id);

    if (response.code == kSuccessCode) {
      Get.snackbar('Erfolg', 'Überprüfungscode erfolgreich gesendet.');
      showReSendCode.value = false;
      timer.value = 50;
      startTimer();
    } else {
      Get.snackbar('Fehler',
          'Error beim erneuten Senden des Codes. Bitte versuche es später noch einmal');
    }
  }
}
