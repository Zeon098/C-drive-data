import 'package:get/get.dart';

import 'package:kamerat_flutter_app/services/auth.service.dart';
import 'package:kamerat_flutter_app/stores/user.store.dart';
import 'package:kamerat_flutter_app/utils/constants.dart';

class GenderController extends GetxController {
  Rx<GENDER> selectedGender = GENDER.male.obs;
  RxBool loading = false.obs;

  void setSelectedGender(GENDER gender) {
    selectedGender.value = gender;
  }

  void setGenderAndNavigate() async {
    UserStore().updateUser(UserStore().user.copyWith(
          gender: selectedGender.value.value.toLowerCase(),
        ));

    loading.value = true;
    final response = await AuthService().updateProfile();
    loading.value = false;

    if (response.redirectRoute.isNotEmpty) {
      await Get.offAllNamed(response.redirectRoute);
      return;
    }

    if (response.code == kSuccessCode) {
      await Get.toNamed(kSubscriptionRoute, arguments: {
        "isForOnBoarding": true,
      });
    } else {
      Get.snackbar("Fehler", "Etwas ist schief gelaufen");
    }
  }
}
