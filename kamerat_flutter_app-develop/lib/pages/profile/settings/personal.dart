import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:kamerat_flutter_app/controllers/personal_settings.controller.dart';
import 'package:kamerat_flutter_app/components/app_button.dart';
import 'package:kamerat_flutter_app/components/app_loader.dart';
import 'package:kamerat_flutter_app/components/app_bar.dart';
import 'package:kamerat_flutter_app/stores/user.store.dart';
import 'package:kamerat_flutter_app/utils/constants.dart';

class PersonalSettings extends GetView<PersonalSettingsController> {
  const PersonalSettings({super.key});

  @override
  Widget build(BuildContext context) {
    PersonalSettingsController controller =
        Get.find<PersonalSettingsController>();
    controller.nameController.text = UserStore().name;
    return Scaffold(
      appBar: const MyAppBar(title: "Persönliche Angaben"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: ListView(
          children: [
            Text(
              "Allgemein",
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
            ),
            const SizedBox(height: 24.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Vollständiger Name",
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                ),
                TextButton(
                  onPressed: () {
                    controller.isEditingName.value =
                        !controller.isEditingName.value;
                  },
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Obx(
                    () => Text(
                      controller.isEditingName.value
                          ? "Stornieren"
                          : "Bearbeiten",
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                    ),
                  ),
                )
              ],
            ),
            Obx(() => controller.isEditingName.value
                ? EditName(controller: controller)
                : Text(
                    UserStore().name,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                  )),
            const SizedBox(height: 24.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Geschlecht",
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                ),
                TextButton(
                  onPressed: () {
                    controller.isEditingGender.value =
                        !controller.isEditingGender.value;
                  },
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Obx(
                    () => Text(
                      controller.isEditingGender.value
                          ? "Stornieren"
                          : "Bearbeiten",
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                    ),
                  ),
                )
              ],
            ),
            Obx(
              () => controller.isEditingGender.value
                  ? EditGender(controller: controller)
                  : Text(
                      UserStore().gender,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).colorScheme.onBackground,
                          ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class EditName extends StatelessWidget {
  const EditName({
    super.key,
    required this.controller,
  });

  final PersonalSettingsController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 8.0),
        Text(
          "Bitte geben Sie Ihren vollständigen Namen ein, einschließlich Ihres Vor- und Nachnamens, wie er auf offiziellen Dokumenten erscheint.",
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),
        ),
        const SizedBox(height: 24.0),
        Form(
          key: controller.formKey,
          child: TextFormField(
            controller: controller.nameController,
            decoration: InputDecoration(
              prefixIcon: Image.asset("assets/icons/rounded_person.png"),
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
        ),
        const SizedBox(height: 24.0),
        Obx(
          () => controller.loading.value
              ? const AppLoader()
              : AppButton(
                  title: "Änderungen speichern",
                  onPressed: controller.updateName,
                ),
        )
      ],
    );
  }
}

class EditGender extends StatelessWidget {
  const EditGender({
    super.key,
    required this.controller,
  });

  final PersonalSettingsController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8.0),
        Text(
          "Bitte wähle dein Geschlecht aus",
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),
        ),
        const SizedBox(height: 24.0),
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
                              color: Theme.of(context).colorScheme.primary),
                          left: BorderSide(
                              width: 1.0,
                              color: Theme.of(context).colorScheme.primary),
                          right: BorderSide(
                              width: 1.0,
                              color: Theme.of(context).colorScheme.primary),
                          bottom: BorderSide(
                              width: 2.0,
                              color: Theme.of(context).colorScheme.primary))
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
                        return (controller.selectedGender.value == GENDER.male)
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).colorScheme.onBackground;
                      }),
                    ),
                    Text("Männlich",
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.w500,
                            color: controller.selectedGender.value ==
                                    GENDER.male
                                ? Theme.of(context).colorScheme.primary
                                : Theme.of(context).colorScheme.onBackground))
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
                              color: Theme.of(context).colorScheme.primary),
                          left: BorderSide(
                              width: 1.0,
                              color: Theme.of(context).colorScheme.primary),
                          right: BorderSide(
                              width: 1.0,
                              color: Theme.of(context).colorScheme.primary),
                          bottom: BorderSide(
                              width: 2.0,
                              color: Theme.of(context).colorScheme.primary))
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
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              fontWeight: FontWeight.w500,
                              color: controller.selectedGender.value ==
                                      GENDER.female
                                  ? Theme.of(context).colorScheme.primary
                                  : Theme.of(context).colorScheme.onBackground,
                            ))
                  ],
                ),
              ),
            )),
          ],
        ),
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
                controller.updateGender();
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
        const SizedBox(height: 24.0),
        Obx(
          () => controller.loading.value
              ? const AppLoader()
              : AppButton(
                  title: "Änderungen speichern",
                  onPressed: controller.updateGender,
                ),
        )
      ],
    );
  }
}
