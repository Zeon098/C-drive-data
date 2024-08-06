import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';

import 'package:kamerat_flutter_app/controllers/verify_reset_code.controller.dart';
import 'package:kamerat_flutter_app/components/app_button.dart';
import 'package:kamerat_flutter_app/components/app_loader.dart';
import 'package:kamerat_flutter_app/components/app_bar.dart';

class VerifyResetCode extends GetView<VerifyResetCodeController> {
  const VerifyResetCode({super.key});

  @override
  Widget build(BuildContext context) {
    final VerifyResetCodeController controller =
        Get.find<VerifyResetCodeController>();

    Map<String, dynamic> arguments = Get.arguments;

    String maskedEmail = arguments["email"]
        .replaceRange(3, arguments["email"].indexOf("@") - 1, "***");

    return Scaffold(
        appBar: const MyAppBar(title: "Bestätigen Sie Ihre E-Mail"),
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ListView(
              children: [
                const SizedBox(height: 48.0),
                Text("Code eingeben",
                    style: Theme.of(context).textTheme.displaySmall!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.tertiary,
                        )),
                const SizedBox(height: 8.0),
                Text(
                    "Bitte geben Sie den 4-stelligen Code ein, den wir an $maskedEmail gesendet haben",
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).colorScheme.onBackground,
                        )),
                const SizedBox(height: 32.0),
                Form(
                    child: Column(
                  children: [
                    OtpTextField(
                      numberOfFields: 4,
                      fillColor: Theme.of(context).colorScheme.surface,
                      enabledBorderColor:
                          const Color.fromRGBO(230, 236, 232, 1),
                      focusedBorderColor: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(16.0),
                      borderWidth: 1,
                      showFieldAsBox: true,
                      fieldWidth: 80.0,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(1),
                      ],
                      autoFocus: true,
                      handleControllers: (controllers) =>
                          controller.otpControllers(controllers),
                      onSubmit: (value) => {
                        controller.code.value = int.parse(value),
                      },
                    ),
                    Obx(
                      () => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          controller.error.value,
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: Theme.of(context).colorScheme.error,
                                  ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Obx(
                      () => controller.showReSendCode.value
                          ? TextButton(
                              onPressed: () {
                                controller.resendCode(arguments["email"]);
                              },
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                splashFactory: NoSplash.splashFactory,
                              ),
                              child: Text(
                                "Code nochmal senden",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                      fontWeight: FontWeight.bold,
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                              ),
                            )
                          : Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 16.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Code nochmal senden",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(
                                            fontWeight: FontWeight.w400,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onBackground,
                                          )),
                                  const SizedBox(width: 8.0),
                                  Text("00:${controller.timer}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(
                                            fontWeight: FontWeight.w400,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onBackground,
                                          )),
                                ],
                              ),
                            ),
                    ),
                    Obx(() => controller.loading.value
                        ? const AppLoader()
                        : AppButton(
                            title: "E-Mail bestätigen",
                            onPressed: controller.verifyCode,
                          )),
                  ],
                )),
              ],
            )));
  }
}
