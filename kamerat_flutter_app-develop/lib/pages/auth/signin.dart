import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:kamerat_flutter_app/controllers/signin.controller.dart';
import 'package:kamerat_flutter_app/components/app_loader.dart';
import 'package:kamerat_flutter_app/components/app_button.dart';
import 'package:kamerat_flutter_app/components/app_bar.dart';
import 'package:kamerat_flutter_app/utils/constants.dart';

class SignIn extends GetView<SignInController> {
  const SignIn({super.key});

  @override
  Widget build(BuildContext context) {
    SignInController controller = Get.find<SignInController>();
    return Scaffold(
        appBar: const MyAppBar(title: "Anmeldung"),
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ListView(
              children: [
                const SizedBox(height: 48.0),
                Text("Willkommen zurück",
                    style: Theme.of(context).textTheme.displaySmall!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.tertiary,
                        )),
                const SizedBox(height: 8.0),
                Text("Gebe unten die Details ein, um Dich anzumelden.",
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).colorScheme.onBackground,
                        )),
                const SizedBox(height: 32.0),
                Form(
                    key: controller.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          controller: controller.emailController,
                          decoration: InputDecoration(
                            prefixIcon: Image.asset("assets/icons/email.png"),
                            hintText: "Email",
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Email ist erforderlich";
                            } else if (!GetUtils.isEmail(
                                value.removeAllWhitespace)) {
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
                                prefixIcon:
                                    Image.asset("assets/icons/lock.png"),
                                hintText: "Passwort",
                                suffixIcon: Padding(
                                  padding: const EdgeInsets.only(top: 4.0),
                                  child: GestureDetector(
                                    onTap: controller.togglePasswordVisibility,
                                    child: controller.hidePassword.value
                                        ? Image.asset(
                                            "assets/icons/eye_closed.png")
                                        : Image.asset(
                                            "assets/icons/eye_opened.png"),
                                  ),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Passwort ist erforderlich";
                                }
                                return null;
                              },
                            )),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            TextButton(
                              onPressed: controller.forgetPassword,
                              style: TextButton.styleFrom(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                minimumSize: Size.zero,
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              child: Text(
                                "Passwort vergessen?",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                      fontWeight: FontWeight.w500,
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                              ),
                            ),
                          ],
                        ),
                        Obx(
                          () => Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
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
                          ),
                        ),
                        Obx(
                          () => controller.loading.value
                              ? const AppLoader()
                              : AppButton(
                                  title: "Anmeldung",
                                  onPressed: controller.login,
                                ),
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
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  "oder",
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
                              "Sie haben noch kein Konto?",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    fontWeight: FontWeight.w500,
                                    color:
                                        Theme.of(context).colorScheme.tertiary,
                                  ),
                            ),
                            const SizedBox(width: 8.0),
                            TextButton(
                              onPressed: () {
                                Get.offNamed(kSignUpRoute);
                              },
                              style: TextButton.styleFrom(
                                padding: const EdgeInsets.all(0),
                              ),
                              child: Text(
                                "Registrieren",
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
            )));
  }
}
