import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';

class AppImagePickerController extends GetxController {
  final ImagePicker _picker = ImagePicker();
  final Rx<File?> pickedImage = Rx<File?>(null);

  Future<void> pickImage(
      ImageSource source, Function(File image) callback) async {
    try {
      final pickedFile = await _picker.pickImage(source: source);
      if (pickedFile != null) {
        pickedImage.value = File(pickedFile.path);
        callback(pickedImage.value!);
      }
    } catch (e) {
      Get.snackbar("Fehler", "Profil konnte nicht aktualisiert werden");
    }
  }
}
