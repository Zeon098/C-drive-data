import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import 'package:kamerat_flutter_app/controllers/gender.controller.dart';
import 'package:kamerat_flutter_app/services/auth.service.dart';
import 'package:kamerat_flutter_app/models/user.model.dart';
import 'package:kamerat_flutter_app/stores/user.store.dart';
import 'package:kamerat_flutter_app/utils/constants.dart';

class PersonalSettingsController extends GenderController {
  RxBool isEditingName = false.obs;
  RxBool isEditingGender = false.obs;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController nameController;

  @override
  void onInit() {
    nameController = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    nameController.dispose();
    super.onClose();
  }

  void updateName() async {
    if (formKey.currentState!.validate()) {
      UserModel user = UserStore().user;
      UserStore().updateUser(user.copyWith(name: nameController.text));
      loading.value = true;
      final response = await AuthService().updateProfile();
      loading.value = false;
      isEditingName.value = false;

      if (response.redirectRoute.isNotEmpty) {
        await Get.offAllNamed(response.redirectRoute);
        return;
      }

      if (response.code != kSuccessCode) {
        UserStore().updateUser(user);
        Get.snackbar("Fehler", "Failed to updated profile.");
      }
    }
  }

  void updateGender() async {
    UserModel user = UserStore().user;
    UserStore().updateUser(user.copyWith(
      gender: selectedGender.value.value.toLowerCase(),
    ));
    loading.value = true;
    final response = await AuthService().updateProfile();
    loading.value = false;
    isEditingGender.value = false;

    if (response.redirectRoute.isNotEmpty) {
      await Get.offAllNamed(response.redirectRoute);
      return;
    }

    if (response.code != kSuccessCode) {
      UserStore().updateUser(user);
      Get.snackbar("Fehler", "Profil konnte nicht aktualisiert werden.");
    }
  }
}
