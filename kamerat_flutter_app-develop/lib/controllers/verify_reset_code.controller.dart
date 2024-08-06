import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:kamerat_flutter_app/services/auth.service.dart';
import 'package:kamerat_flutter_app/models/response.model.dart';
import 'package:kamerat_flutter_app/utils/constants.dart';

class VerifyResetCodeController extends GetxController {
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

  void verifyCode() async {
    if (!valid.value) return;

    loading.value = true;
    ResponseModel response = await AuthService().verifyResetCode(
      code: code.value,
    );
    loading.value = false;

    if (response.redirectRoute.isNotEmpty) {
      await Get.offAllNamed(response.redirectRoute);
      return;
    }

    if (response.code == kSuccessCode) {
      Get.offNamed(kResetPasswordRoute, arguments: {
        'token': response.data['token'],
      });
    } else {
      error.value = "Verifizierung fehlgeschlagen. Versuche es erneut";
      timer.value = 0;
    }
  }

  Future<void> resendCode(String email) async {
    final response = await AuthService().findAccount(email: email);
    loading.value = false;

    if (response.redirectRoute.isNotEmpty) {
      await Get.offAllNamed(response.redirectRoute);
      return;
    }

    if (response.code == kSuccessCode) {
      Get.snackbar("Erfolg", "Überprüfungscode erfolgreich gesendet");
    } else {
      Get.snackbar("Fehler", "Überprüfungscode konnte nicht gesendet werden");
    }
  }
}
