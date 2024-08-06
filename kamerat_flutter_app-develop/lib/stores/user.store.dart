import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'dart:convert';

import 'package:kamerat_flutter_app/utils/api_endpoints.dart';
import 'package:kamerat_flutter_app/models/user.model.dart';

class UserStore {
  static final Rx<UserModel> _user = UserModel.empty().obs;
  static final RxString _token = "".obs;
  static final RxString _refreshToken = "".obs;

  static final UserStore _instance = UserStore._internal();
  UserStore._internal();
  factory UserStore() {
    return _instance;
  }

  Future<void> init() async {
    final preferences = await SharedPreferences.getInstance();

    _token.value = preferences.getString("TOKEN") ?? "";
    _refreshToken.value = preferences.getString("REFRESH_TOKEN") ?? "";

    final userData = preferences.getString("USER_DATA");

    if (userData != null) {
      _user.value = UserModel.fromJson(jsonDecode(userData));
    }

    ever(_user, (UserModel user) {
      preferences.setString("USER_DATA", jsonEncode(user.toJsonToStore()));
    });

    ever(_token, (String token) {
      preferences.setString("TOKEN", token);
    });

    ever(_refreshToken, (String refreshToken) {
      preferences.setString("REFRESH_TOKEN ", refreshToken);
    });
  }

  Future<void> login({
    required String token,
    required String refreshToken,
  }) async {
    _token.value = token;
    _refreshToken.value = refreshToken;

    final preferences = await SharedPreferences.getInstance();
    preferences.setString("TOKEN", _token.value);
    preferences.setString("REFRESH_TOKEN", _refreshToken.value);
  }

  Future<void> logout() async {
    _user.value = UserModel.empty();
    _token.value = "";
    _refreshToken.value = "";

    final preferences = await SharedPreferences.getInstance();

    preferences.remove("USER_DATA");
    preferences.remove("TOKEN");
    preferences.remove("REFRESH_TOKEN");
  }

  void setUser(UserModel user) {
    _user.value = user;
  }

  void updateUser(UserModel newUser) {
    _user.value = newUser;
  }

  void setIsSubscribed(bool isSubscribed) {
    _user.value = _user.value.copyWith(inApppaymentSubscription: isSubscribed);
  }

  String get token => _token.value;
  String get refreshToken => _refreshToken.value;

  UserModel get user => _user.value;

  bool get isLoggedIn => _token.value.isNotEmpty;

  String get name => _user.value.name;

  String get uuid => _user.value.userUuid;

  bool get isSubscribed => _user.value.inApppaymentSubscription;

  String get gender {
    switch (_user.value.gender) {
      case "male":
        return "Männlich";
      case "female":
        return "Weiblich";
      default:
        return "Andere";
    }
  }

  String get image => _user.value.image.isNotEmpty
      ? '$kBaseAssetsUrl/assets/${_user.value.image}'
      : '';

  String get memberSince {
    DateTime createdAt = DateTime.parse(_user.value.createdAt);
    String month = DateFormat('MMMM', 'de_DE').format(createdAt);
    int year = createdAt.year;
    return '$month $year';
  }
}
