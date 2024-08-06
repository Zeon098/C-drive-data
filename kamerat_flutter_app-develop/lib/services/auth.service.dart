import 'dart:io';

import 'package:kamerat_flutter_app/models/response.model.dart';
import 'package:kamerat_flutter_app/services/http_client.dart';
import 'package:kamerat_flutter_app/utils/api_endpoints.dart';
import 'package:kamerat_flutter_app/models/user.model.dart';
import 'package:kamerat_flutter_app/stores/user.store.dart';

class AuthService {
  late HttpClient _httpClient;

  static final AuthService _instance = AuthService._internal();

  AuthService._internal() {
    _httpClient = HttpClient();
  }

  factory AuthService() => _instance;

  Future<ResponseModel> register({required UserModel user}) {
    return _httpClient.postRequest(
      url: kregisterUserUrl,
      body: user.toJson(),
    );
  }

  Future<ResponseModel> login(
      {required String email, required String password}) {
    return _httpClient.postRequest(
      url: ksigninUrl,
      body: {
        "email": email,
        "password": password,
      },
    );
  }

  Future<ResponseModel> verifyEmail(
      {required String userId, required int code}) {
    return _httpClient.postRequest(
      url: kverifyEmailUrl,
      body: {
        "user_id": userId,
        "token": code,
      },
    );
  }

  Future<ResponseModel> resendVerificationCode({required String userId}) {
    return _httpClient
        .postRequest(url: kResendVerificationCode, body: {'user_id': userId});
  }

  Future<ResponseModel> updateProfile() {
    return _httpClient.putRequest(
      url: kProfileUrl,
      body: UserStore().user.toJson(),
    );
  }

  Future<ResponseModel> uploadProfilePicture({required File image}) {
    return _httpClient.postMultiPartRequest(
      url: kUploadProfilePictureUrl,
      file: image,
    );
  }

  Future<ResponseModel> findAccount({required String email}) {
    return _httpClient.postRequest(
      url: kforgetPasswordUrl,
      body: {
        "email": email,
      },
    );
  }

  Future<ResponseModel> verifyResetCode({required int code}) {
    return _httpClient.postRequest(
      url: kVerifyResetCodeUrl,
      body: {
        "code": code,
      },
    );
  }

  Future<ResponseModel> resetPassword(
      {required String password, required String token}) {
    return _httpClient.postRequest(
      url: kResetPasswordUrl,
      body: {
        "password": password,
        "token": token,
      },
    );
  }

  Future<ResponseModel> changeEmail({required String email}) {
    return _httpClient.putRequest(
      url: kChangeEmailUrl,
      body: {
        "email": email,
      },
    );
  }

  Future<ResponseModel> changePassword(
      {required String currentPassword, required String newPassword}) {
    return _httpClient.putRequest(
      url: kChangePasswordUrl,
      body: {
        "currentPassword": currentPassword,
        "newPassword": newPassword,
      },
    );
  }

  Future<ResponseModel> deleteAccount() {
    return _httpClient.deleteRequest(url: kDeleteAccountUrl);
  }

  Future<ResponseModel> getMe() {
    return _httpClient.getRequest(url: kMeUrl);
  }
}
