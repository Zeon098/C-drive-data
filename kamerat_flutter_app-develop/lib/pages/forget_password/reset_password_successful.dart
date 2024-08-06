import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:kamerat_flutter_app/components/app_button.dart';
import 'package:kamerat_flutter_app/utils/constants.dart';

class ResetPasswordSuccessful extends StatelessWidget {
  const ResetPasswordSuccessful({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/icons/check.png"),
            const SizedBox(height: 32.0),
            Text("Passwort änderungen",
                style: Theme.of(context).textTheme.displaySmall!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.tertiary,
                    )),
            const SizedBox(height: 8.0),
            Text(
              "Sie können sich nun mit Ihrem neuen Passwort bei Ihrem Konto Anmeldung",
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32.0),
            AppButton(
              onPressed: () => Get.offAllNamed(kSignInRoute),
              title: "Zurück zur Anmeldung",
            )
          ],
        ),
      ),
    );
  }
}
