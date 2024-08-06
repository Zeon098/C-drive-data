import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:kamerat_flutter_app/controllers/signup.controller.dart';
import 'package:kamerat_flutter_app/components/app_button.dart';
import 'package:kamerat_flutter_app/components/app_loader.dart';
import 'package:kamerat_flutter_app/components/app_bar.dart';
import 'package:kamerat_flutter_app/utils/constants.dart';

class SignUp extends GetView<SignUpController> {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    final SignUpController controller = Get.find<SignUpController>();
    return Scaffold(
      appBar: const MyAppBar(title: "Registrieren"),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: ListView(
            children: [
              const SizedBox(height: 48.0),
              Text("Ein konto erstellen",
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.tertiary,
                      )),
              const SizedBox(height: 32.0),
              Form(
                  key: controller.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        controller: controller.nameController,
                        textCapitalization: TextCapitalization.words,
                        decoration: InputDecoration(
                          prefixIcon:
                              Image.asset("assets/icons/rounded_person.png"),
                          hintText: "Vollständiger Name",
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Name ist erforderlich";
                          } else if (value.length < 3) {
                            return "Der Name sollte mindestens 3 Zeichen lang sein.";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16.0),
                      TextFormField(
                        controller: controller.emailController,
                        decoration: InputDecoration(
                          prefixIcon: Image.asset("assets/icons/email.png"),
                          hintText: "Email",
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Email ist erforderlich";
                          } else if (!GetUtils.isEmail(value)) {
                            return "Geben sie eine gültige E-Mail-Adresse an.";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16.0),
                      Obx(() => TextFormField(
                            controller: controller.passwordController,
                            obscureText: controller.hidePassword.value,
                            decoration: InputDecoration(
                              prefixIcon: Image.asset("assets/icons/lock.png"),
                              hintText: "Passwort",
                              suffixIcon: Padding(
                                padding: const EdgeInsets.only(top: 4.0),
                                child: GestureDetector(
                                  onTap: () {
                                    controller.toggleHidePassword();
                                  },
                                  child: Obx(() => controller.hidePassword.value
                                      ? Image.asset(
                                          "assets/icons/eye_closed.png")
                                      : Image.asset(
                                          "assets/icons/eye_opened.png")),
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
                          )),
                      const SizedBox(height: 16.0),
                      Obx(() => TextFormField(
                            controller: controller.confirmPasswordController,
                            obscureText: controller.hideConfirmPassword.value,
                            decoration: InputDecoration(
                              prefixIcon: Image.asset("assets/icons/lock.png"),
                              hintText: "Passwort bestätigen",
                              suffixIcon: Padding(
                                padding: const EdgeInsets.only(top: 4.0),
                                child: GestureDetector(
                                  onTap: () {
                                    controller.toggleHideConfirmPassword();
                                  },
                                  child: Obx(() =>
                                      controller.hideConfirmPassword.value
                                          ? Image.asset(
                                              "assets/icons/eye_closed.png")
                                          : Image.asset(
                                              "assets/icons/eye_opened.png")),
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
                          )),
                      Obx(() => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(
                              controller.error.value,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: Theme.of(context).colorScheme.error,
                                  ),
                            ),
                          )),
                      const SizedBox(height: 16.0),
                      Obx(
                        () => controller.loading.value
                            ? const AppLoader()
                            : AppButton(
                                title: "Jetzt registrieren",
                                onPressed: () => {
                                      controller.register(),
                                    }),
                      ),
                      const SizedBox(height: 24.0),
                      Row(
                        children: [
                          const Expanded(
                            child: Divider(
                              color: Color.fromRGBO(230, 236, 232, 1),
                              thickness: 1,
                            ),
                          ),
                          Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: Text(
                                "oder mitmachen",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                      fontWeight: FontWeight.w500,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onBackground,
                                    ),
                              )),
                          const Expanded(
                            child: Divider(
                              color: Color.fromRGBO(230, 236, 232, 1),
                              thickness: 1,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Schon ein Mitglied?",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: Theme.of(context).colorScheme.tertiary,
                                ),
                          ),
                          const SizedBox(width: 8.0),
                          TextButton(
                            onPressed: () {
                              Get.offNamed(kSignInRoute);
                            },
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.all(0),
                            ),
                            child: Text(
                              "Anmeldung",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )),
            ],
          )),
    );
  }
}
