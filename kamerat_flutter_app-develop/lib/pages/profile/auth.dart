import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:kamerat_flutter_app/utils/constants.dart';

class Auth extends StatelessWidget {
  const Auth({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                padding: const EdgeInsets.symmetric(vertical: 16.0),
              ),
              onPressed: () => Get.toNamed(kSignInRoute),
              child: Text(
                "Anmeldung",
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.surface,
                    ),
              )),
          const SizedBox(height: 16.0),
          Container(
            height: 55,
            clipBehavior: Clip.none,
            decoration: BoxDecoration(
              border: Border.all(
                color: Theme.of(context).colorScheme.primary,
              ),
              borderRadius: BorderRadius.circular(50),
            ),
            child: TextButton(
              onPressed: () => Get.toNamed(kSignUpRoute),
              child: Text("Einen Account registrieren",
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      )),
            ),
          ),
        ]);
  }
}
