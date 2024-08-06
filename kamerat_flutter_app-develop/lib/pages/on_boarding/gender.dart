import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:kamerat_flutter_app/components/app_bar.dart';
import 'package:kamerat_flutter_app/components/app_button.dart';
import 'package:kamerat_flutter_app/components/app_loader.dart';
import 'package:kamerat_flutter_app/controllers/gender.controller.dart';
import 'package:kamerat_flutter_app/utils/constants.dart';

class Gender extends GetView<GenderController> {
  const Gender({super.key});

  @override
  Widget build(BuildContext context) {
    final GenderController controller = Get.find<GenderController>();
    return Scaffold(
      appBar: const MyAppBar(
        title: "",
        showLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text("1",
                    style: Theme.of(context).textTheme.displayMedium!.copyWith(
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).colorScheme.tertiary,
                        )),
                Text("/2",
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).colorScheme.onBackground,
                        ))
              ],
            ),
            const SizedBox(height: 32.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Was ist dein ",
                    style: Theme.of(context).textTheme.displaySmall!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.tertiary,
                        )),
                Text("Geschlecht?",
                    style: Theme.of(context).textTheme.displaySmall!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.secondary,
                        )),
              ],
            ),
            const SizedBox(height: 8.0),
            Text(
                "Um Ihnen ein besseres Erlebnis zu bieten, müssen wir Ihr Geschlecht kennen",
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                textAlign: TextAlign.center),
            const SizedBox(height: 32.0),
            Column(children: [
              Row(
                children: [
                  Expanded(
                      child: Obx(
                    () => Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(16.0),
                        border: controller.selectedGender.value == GENDER.male
                            ? Border(
                                top: BorderSide(
                                    width: 1.0,
                                    color:
                                        Theme.of(context).colorScheme.primary),
                                left: BorderSide(
                                    width: 1.0,
                                    color:
                                        Theme.of(context).colorScheme.primary),
                                right: BorderSide(
                                    width: 1.0,
                                    color:
                                        Theme.of(context).colorScheme.primary),
                                bottom: BorderSide(
                                    width: 2.0,
                                    color:
                                        Theme.of(context).colorScheme.primary))
                            : null,
                      ),
                      child: Row(
                        children: [
                          Radio<GENDER>(
                            value: GENDER.male,
                            groupValue: controller.selectedGender.value,
                            onChanged: (GENDER? value) {
                              controller.setSelectedGender(value!);
                            },
                            fillColor: MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                              return (controller.selectedGender.value ==
                                      GENDER.male)
                                  ? Theme.of(context).colorScheme.primary
                                  : Theme.of(context).colorScheme.onBackground;
                            }),
                          ),
                          Text("Männlich",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                      fontWeight: FontWeight.w500,
                                      color: controller.selectedGender.value ==
                                              GENDER.male
                                          ? Theme.of(context)
                                              .colorScheme
                                              .primary
                                          : Theme.of(context)
                                              .colorScheme
                                              .onBackground))
                        ],
                      ),
                    ),
                  )),
                  const SizedBox(width: 8.0),
                  Expanded(
                      child: Obx(
                    () => Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(16.0),
                        border: controller.selectedGender.value == GENDER.female
                            ? Border(
                                top: BorderSide(
                                    width: 1.0,
                                    color:
                                        Theme.of(context).colorScheme.primary),
                                left: BorderSide(
                                    width: 1.0,
                                    color:
                                        Theme.of(context).colorScheme.primary),
                                right: BorderSide(
                                    width: 1.0,
                                    color:
                                        Theme.of(context).colorScheme.primary),
                                bottom: BorderSide(
                                    width: 2.0,
                                    color:
                                        Theme.of(context).colorScheme.primary))
                            : null,
                      ),
                      child: Row(
                        children: [
                          Radio<GENDER>(
                            value: GENDER.female,
                            groupValue: controller.selectedGender.value,
                            onChanged: (GENDER? value) {
                              controller.setSelectedGender(value!);
                            },
                            fillColor: MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                              return (controller.selectedGender.value ==
                                      GENDER.female)
                                  ? Theme.of(context).colorScheme.primary
                                  : Theme.of(context).colorScheme.onBackground;
                            }),
                          ),
                          Text("Weiblich",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: controller.selectedGender.value ==
                                            GENDER.female
                                        ? Theme.of(context).colorScheme.primary
                                        : Theme.of(context)
                                            .colorScheme
                                            .onBackground,
                                  ))
                        ],
                      ),
                    ),
                  )),
                ],
              ),
              const SizedBox(height: 32.0),
              Obx(
                () => controller.loading.value
                    ? const AppLoader()
                    : AppButton(
                        title: "Weitermachen",
                        onPressed: controller.setGenderAndNavigate,
                      ),
              ),
              const SizedBox(height: 24.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Ich sage es lieber nicht",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                  ),
                  const SizedBox(width: 4.0),
                  TextButton(
                    onPressed: () {
                      controller.setSelectedGender(GENDER.other);
                    },
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.all(0),
                    ),
                    child: Text(
                      "Andere",
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.tertiary,
                          ),
                    ),
                  ),
                ],
              ),
            ]),
          ],
        ),
      ),
    );
  }
}
