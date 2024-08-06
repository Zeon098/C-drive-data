import 'package:kamerat_flutter_app/models/response.model.dart';
import 'package:kamerat_flutter_app/services/http_client.dart';
import 'package:kamerat_flutter_app/utils/api_endpoints.dart';

class NotificationService {
  late HttpClient _httpClient;

  static final NotificationService _instance = NotificationService._internal();

  NotificationService._internal() {
    _httpClient = HttpClient();
  }

  factory NotificationService() => _instance;

  Future<ResponseModel> registerFCMToken({required String token}) {
    return _httpClient.postRequest(
      url: kRegisterFCMTokenUrl,
      body: {"fcmToken": token},
      requiresAuthorization: true,
    );
  }
}
