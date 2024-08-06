import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:kamerat_flutter_app/stores/user.store.dart';
import 'package:kamerat_flutter_app/utils/constants.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    if (!UserStore().isLoggedIn) {
      return const RouteSettings(name: kSignInRequiredRoute);
    }
    return super.redirect(route);
  }
}
