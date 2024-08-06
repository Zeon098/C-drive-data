import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';

import 'package:kamerat_flutter_app/controllers/image_picker.controller.dart';

class AppImagePicker extends GetView<AppImagePickerController> {
  final Function(File image) onImagePicked;
  final String? imageUrl;

  const AppImagePicker(
      {super.key, this.imageUrl = "", required this.onImagePicked});

  ImageProvider get image {
    if (imageUrl!.isNotEmpty && controller.pickedImage.value == null) {
      return NetworkImage(imageUrl!);
    } else if (controller.pickedImage.value != null) {
      return FileImage(controller.pickedImage.value!);
    } else {
      return const AssetImage("assets/icons/rounded_person.png");
    }
  }

  @override
  Widget build(BuildContext context) {
    AppImagePickerController controller = Get.put(AppImagePickerController());
    return Obx(
      () => Align(
        alignment: Alignment.center,
        child: ElevatedButton(
          onPressed: () =>
              controller.pickImage(ImageSource.gallery, onImagePicked),
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: Size.zero,
          ),
          child: Stack(children: [
            controller.pickedImage.value == null && imageUrl!.isEmpty
                ? Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color.fromRGBO(230, 236, 232, 1),
                      border: Border.all(
                        width: 5.0,
                        color: Theme.of(context).colorScheme.surface,
                      ),
                    ),
                    padding: const EdgeInsets.all(20.0),
                    child: Image.asset(
                      "assets/icons/rounded_person.png",
                      height: 64,
                      width: 64,
                      fit: BoxFit.cover,
                    ),
                  )
                : Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        width: 5.0,
                        color: Theme.of(context).colorScheme.surface,
                      ),
                    ),
                    child: CircleAvatar(
                      radius: 64.0,
                      backgroundImage: image,
                    ),
                  ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  shape: BoxShape.circle,
                  border: Border.all(
                    width: 2.0,
                    color: Theme.of(context).colorScheme.surface,
                  ),
                ),
                child: Image.asset("assets/icons/edit.png"),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
