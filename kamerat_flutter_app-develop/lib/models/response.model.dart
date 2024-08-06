import 'package:kamerat_flutter_app/utils/constants.dart';

class ResponseModel {
  String message = "";
  String error = "";
  int code = kUnknownErrorCode;
  bool status = false;
  String redirectRoute = "";
  dynamic data = "";

  ResponseModel();

  ResponseModel.named({
    required this.message,
    required this.code,
    required this.status,
    required this.redirectRoute,
    this.data,
  });

  ResponseModel.fromJson(Map<String, dynamic> json) {
    message = '${json["message"] ?? ""}';
    data = json["data"] ?? "";
    code = json["code"] ?? kUnknownErrorCode;
    error = json.containsKey("errors") ? _setError(json) : "";
    status = json["status"] ?? false;
  }

  String _setError(Map<String, dynamic> json) {
    String errorMessage = "";
    for (int i = 0; i < json["errors"].length; i++) {
      errorMessage += json["errors"][i]["msg"];
      if (i != json["errors"].length - 1) {
        errorMessage += "\n";
      } else {
        errorMessage += ".";
      }
    }
    return errorMessage;
  }

  @override
  String toString() {
    return 'ResponseModel{message: $message, code: $code, status: $status, data: $data, error: $error}';
  }
}
