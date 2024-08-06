import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:kamerat_flutter_app/pages/profile/index.dart';
import 'package:kamerat_flutter_app/components/home_bar.dart';
import 'package:kamerat_flutter_app/components/app_bar.dart';
import 'package:kamerat_flutter_app/stores/user.store.dart';
import 'package:kamerat_flutter_app/utils/constants.dart';
import 'package:kamerat_flutter_app/pages/learning.dart';
import 'package:kamerat_flutter_app/pages/search.dart';
import 'package:kamerat_flutter_app/pages/likes.dart';
import 'package:kamerat_flutter_app/pages/home.dart';

class IndexController extends GetxController {
  RxInt currentScreenIndex = 0.obs;

  List<int> protectedRouteIndicies = [3];

  Widget getCurrentScreen() {
    switch (currentScreenIndex.value) {
      case 0:
        return const Home();
      case 1:
        return const Search();
      case 2:
        return const Learning();
      case 3:
        return const Likes();
      case 4:
        return const Profile();
      default:
        return const Home();
    }
  }

  PreferredSizeWidget getCurrentAppBar() {
    switch (currentScreenIndex.value) {
      case 0:
        return const HomeBar();
      case 1:
        return const MyAppBar(title: "Entdecken Sie Kurse", showLeading: false);
      case 2:
        return const MyAppBar(title: "Meine Erkenntnisse", showLeading: false);
      case 3:
        return const MyAppBar(title: "Meine Vorlieben", showLeading: false);
      case 4:
        return const MyAppBar(title: "Profil", showLeading: false);
      default:
        return const HomeBar();
    }
  }

  int updateCurrentIndex(int index) {
    if (protectedRouteIndicies.contains(index) && !UserStore().isLoggedIn) {
      Get.toNamed(kSignInRequiredRoute);
    } else {
      currentScreenIndex.value = index;
    }
    return currentScreenIndex.value;
  }
}
