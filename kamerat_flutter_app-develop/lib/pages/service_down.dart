import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:kamerat_flutter_app/controllers/service_down.controller.dart';
import 'package:kamerat_flutter_app/utils/constants.dart';

class ServiceDown extends GetView<ServiceDownController> {
  const ServiceDown({super.key});

  @override
  Widget build(BuildContext context) {
    ServiceDownController controller = Get.find<ServiceDownController>();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: Obx(
                () => controller.changeImage.value
                    ? const Image(
                        image: AssetImage('assets/images/service_down_1.png'),
                      )
                    : const Image(
                        image: AssetImage('assets/images/service_down_2.png'),
                      ),
              ),
            ),
            const SizedBox(height: 24.0),
            Text(
              "Etwas ist schief gelaufen",
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
            ),
            Text(
              "Wir haben technische Schwierigkeiten. Bitte versuchen Sie es später noch einmal.",
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8.0),
            TextButton(
              onPressed: () => Get.offAndToNamed(kMainRoute),
              style: TextButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                padding: const EdgeInsets.symmetric(
                  vertical: 12.0,
                  horizontal: 24.0,
                ),
              ),
              child: Text(
                "Versuche es erneut",
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
