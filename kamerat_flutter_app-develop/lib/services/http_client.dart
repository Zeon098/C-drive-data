import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'dart:convert';
import 'dart:async';
import 'dart:io';

import 'package:kamerat_flutter_app/models/response.model.dart';
import 'package:kamerat_flutter_app/utils/api_endpoints.dart';
import 'package:kamerat_flutter_app/utils/connectivity.dart';
import 'package:kamerat_flutter_app/stores/user.store.dart';
import 'package:kamerat_flutter_app/utils/constants.dart';

class HttpClient extends GetConnect {
  HttpClient._internal();
  static final HttpClient _instance = HttpClient._internal();

  factory HttpClient() => _instance;

  Future<ResponseModel> postRequest({
    required String url,
    required Map<String, dynamic> body,
    bool requiresAuthorization = false,
  }) async {
    return _request(
      url: url,
      body: body,
      requiresAuthorization: requiresAuthorization,
      request: post,
    );
  }

  Future<ResponseModel> putRequest({
    required String url,
    required Map<String, dynamic> body,
  }) {
    return _request(
      url: url,
      body: body,
      method: "PUT",
      requiresAuthorization: true,
      request: put,
    );
  }

  Future<ResponseModel> getRequest(
      {required String url, bool requiresAuthorization = true}) {
    return _request(
      url: url,
      method: "GET",
      body: {},
      requiresAuthorization: requiresAuthorization,
      request: get,
    );
  }

  Future<ResponseModel> postMultiPartRequest({
    required String url,
    required File file,
  }) async {
    if (!(await checkInternetAccess())) {
      return _handleError(
          kNoInternetMsg, kRequestTimeoutCode, kNoInternetRoute);
    }

    http.MultipartRequest request =
        http.MultipartRequest('PUT', Uri.parse(url));

    request.headers["Authorization"] = UserStore().token;

    request.files.add(
      http.MultipartFile.fromBytes(
        'image',
        file.readAsBytesSync(),
        filename: file.path.split('/').last,
      ),
    );

    try {
      http.StreamedResponse streamedResponse = await request.send();
      http.Response httpResponse =
          await http.Response.fromStream(streamedResponse);

      if (httpResponse.statusCode == kInternalServerErrorCode) {
        return _handleError(kSomethingWentWrongMsg, kInternalServerErrorCode,
            kServiceDownRoute);
      }

      return ResponseModel.fromJson(jsonDecode(httpResponse.body));
    } on TimeoutException {
      return _handleError(
          kRequestTimeoutMsg, kRequestTimeoutCode, kNoInternetRoute);
    } catch (e) {
      return _handleError(
          kNoInternetMsg, kRequestTimeoutCode, kServiceDownRoute);
    }
  }

  Future<ResponseModel> deleteRequest({required String url}) {
    return _request(
      url: url,
      method: "DELETE",
      body: {},
      requiresAuthorization: true,
      request: delete,
    );
  }

  Future<ResponseModel> _request({
    required String url,
    String method = "POST",
    required Map<String, dynamic> body,
    bool requiresAuthorization = false,
    required Function request,
  }) async {
    if (!(await checkInternetAccess())) {
      return _handleError(
          kNoInternetMsg, kRequestTimeoutCode, kNoInternetRoute);
    }

    return _handleRequest(
      url,
      body,
      requiresAuthorization,
      method,
      request,
    );
  }

  Future<ResponseModel> _handleRequest(
    String url,
    Map<String, dynamic> body,
    bool requiresAuthorization,
    String method,
    Function request,
  ) async {
    Map<String, String> headers = {};
    if (requiresAuthorization) {
      headers["Authorization"] = UserStore().token;
    }

    try {
      final response = method == "GET" || method == "DELETE"
          ? await request(url, headers: headers)
          : await request(url, body, headers: headers);

      return _handleResponse(
        response,
        url,
        body,
        requiresAuthorization,
        request,
      );
    } on TimeoutException {
      return _handleError(
          kRequestTimeoutMsg, kRequestTimeoutCode, kNoInternetMsg);
    } catch (e) {
      return _handleError(
          kSomethingWentWrongMsg, kInternalServerErrorCode, kServiceDownRoute);
    }
  }

  Future<ResponseModel> _handleResponse(
    response,
    String url,
    Map<String, dynamic> body,
    bool requiresAuthorization,
    Function request,
  ) async {
    if (response.statusCode == kInternalServerErrorCode) {
      return _handleError(
          kSomethingWentWrongMsg, kInternalServerErrorCode, kServiceDownRoute);
    }

    if (response.statusCode == kUnauthorizedCode && requiresAuthorization) {
      return _handleSesionExpired(url, body, requiresAuthorization, request);
    }
    return ResponseModel.fromJson(response.body);
  }

  Future<ResponseModel> _handleSesionExpired(
    String url,
    Map<String, dynamic> body,
    bool requiresAuthorization,
    Function request,
  ) async {
    final response = await postRequest(
      url: kRefreshTokenUrl,
      body: {"refreshToken": UserStore().refreshToken},
    );
    if (response.code == kSuccessCode) {
      UserStore().login(
        token: response.data["token"],
        refreshToken: response.data["refreshToken"],
      );
      return _request(
        url: url,
        body: body,
        requiresAuthorization: requiresAuthorization,
        request: request,
      );
    }
    UserStore().logout();
    return _handleError(response.message, response.code, kSessionExpiredRoute);
  }

  Future<ResponseModel> _handleError(
      String message, int code, String redirectRoute) {
    return Future.value(
      ResponseModel.named(
        message: message,
        code: code,
        status: false,
        redirectRoute: redirectRoute,
      ),
    );
  }
}
