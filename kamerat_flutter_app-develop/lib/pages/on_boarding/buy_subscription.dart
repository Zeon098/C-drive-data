import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:kamerat_flutter_app/components/buy_subscription_button.dart';
import 'package:kamerat_flutter_app/components/app_bar.dart';
import 'package:kamerat_flutter_app/utils/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class BuySubscription extends StatelessWidget {
  const BuySubscription({super.key});

  final _eulaURL =
      "https://www.apple.com/legal/internet-services/itunes/dev/stdeula/";

  final _privacyURL = "https://kamerat.de/datenschutzerklaerung/";

  @override
  Widget build(BuildContext context) {
    final isForOnBoarding = Get.arguments?["isForOnBoarding"] ?? false;
    return Scaffold(
      appBar: const MyAppBar(title: "Kamerats Abonnement"),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Erhalte mit einem Abonnement von € 6.99 einen Monat lang vollen Zugriff auf alle unsere Kurse mit Hausaufgaben, Tipps und Tricks sowie Bildbearbeitung. Tauche tiefer ein und eigne Dir neue Fähigkeiten an! Wir begleiten Dich Stück für Stück und das in Deinem eigenen Tempo. Du kannst monatlich kündigen, ansonsten verlängert sich Dein Abonnement automatisch um einen Monat.",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
            ),
            const SizedBox(height: 16.0),
            TextButton(
              onPressed: () => launchUrl(Uri.parse(_eulaURL)),
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: Size.zero,
                splashFactory: NoSplash.splashFactory,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: const Text("Benutzungsbedingungen"),
            ),
            const SizedBox(height: 8.0),
            TextButton(
              onPressed: () => launchUrl(Uri.parse(_privacyURL)),
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: Size.zero,
                splashFactory: NoSplash.splashFactory,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: const Text("Datenschutzbestimmungen"),
            ),
            const SizedBox(height: 32.0),
            if (isForOnBoarding)
              TextButton(
                onPressed: () {
                  Get.offAndToNamed(kMainRoute);
                },
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: Size.zero,
                  splashFactory: NoSplash.splashFactory,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text(
                  "für jetzt überspringen",
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                        decoration: TextDecoration.underline,
                      ),
                ),
              ),
          ],
        ),
      ),
      floatingActionButton: BuySubscriptionButton(onSubscriptionComplete: () {
        isForOnBoarding ? Get.offAllNamed(kMainRoute) : Get.back();
      }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
