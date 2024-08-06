import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';

import 'package:kamerat_flutter_app/components/app_bar.dart';
import 'package:kamerat_flutter_app/components/app_button.dart';
import 'package:kamerat_flutter_app/components/app_loader.dart';
import 'package:kamerat_flutter_app/components/image_picker.dart';
import 'package:kamerat_flutter_app/controllers/profile_picture.controller.dart';

class ProfilePicture extends GetView<ProfilePictureController> {
  const ProfilePicture({super.key});

  @override
  Widget build(BuildContext context) {
    ProfilePictureController controller = Get.find<ProfilePictureController>();
    return Scaffold(
      appBar: const MyAppBar(title: ""),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text("2",
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
                Text("Profilbild ",
                    style: Theme.of(context).textTheme.displaySmall!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.secondary,
                        )),
                Text(" hochladen",
                    style: Theme.of(context).textTheme.displaySmall!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.tertiary,
                        )),
              ],
            ),
            const SizedBox(height: 8.0),
            Text(
                "Fast fertig! Bitte laden Sie Ihr Bild hoch. PNG- und JPEG-Dateien sind maximal 10 MB erlaubt",
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                textAlign: TextAlign.center),
            const SizedBox(height: 32.0),
            AppImagePicker(onImagePicked: (File pickedImage) {
              controller.pickedImage.value = pickedImage;
            }),
            const SizedBox(height: 32.0),
            Obx(
              () => controller.loading.value
                  ? const AppLoader()
                  : AppButton(
                      title: "Vollständiges Profil",
                      onPressed: controller.uploadImage,
                    ),
            )
          ],
        ),
      ),
    );
  }
}
