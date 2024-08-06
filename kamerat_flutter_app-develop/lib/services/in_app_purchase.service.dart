import 'package:kamerat_flutter_app/models/response.model.dart';
import 'package:kamerat_flutter_app/services/http_client.dart';
import 'package:kamerat_flutter_app/utils/api_endpoints.dart';

class InAppPurchaseService {
  late HttpClient _httpClient;

  static final InAppPurchaseService _instance =
      InAppPurchaseService._internal();

  InAppPurchaseService._internal() {
    _httpClient = HttpClient();
  }

  factory InAppPurchaseService() => _instance;

  Future<ResponseModel> verifySubscription({required String transactionId}) {
    return _httpClient.postRequest(
      url: kVerifySubsscriptionStatus,
      body: {'transactionId': transactionId},
    );
  }

  Future<ResponseModel> checkSubscriptionStatus() {
    return _httpClient.getRequest(
      url: kCheckSubscriptionStatus,
      requiresAuthorization: true,
    );
  }
}
