import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kamerat_flutter_app/components/app_button.dart';
import 'package:kamerat_flutter_app/utils/constants.dart';

class VerificationSuccessful extends StatelessWidget {
  const VerificationSuccessful({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(
          "assets/images/verification_successful.jpg",
          fit: BoxFit.cover,
        ),
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromRGBO(19, 154, 67, 0.9),
                Color.fromRGBO(19, 154, 67, 0.9),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 32.0),
          child: Text(
            "Kamerat",
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
            textAlign: TextAlign.center,
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: 336,
                    decoration: const BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.all(
                        Radius.circular(24),
                      ),
                      color: Colors.white,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 32.0),
                    child: Column(children: [
                      Image.asset("assets/icons/check.png"),
                      const SizedBox(height: 32.0),
                      Text(
                        "Ihr Konto wurde erfolgreich verifiziert!!",
                        style:
                            Theme.of(context).textTheme.displaySmall!.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).colorScheme.tertiary,
                                ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 32.0),
                      AppButton(
                        title: "Weitermachen",
                        onPressed: () => Get.offAllNamed(kSignInRoute),
                      )
                    ]),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
