import 'package:kamerat_flutter_app/models/response.model.dart';
import 'package:kamerat_flutter_app/services/http_client.dart';
import 'package:kamerat_flutter_app/utils/api_endpoints.dart';

class NewsFeedService {
  late HttpClient _httpClient;

  static final NewsFeedService _instance = NewsFeedService._internal();

  NewsFeedService._internal() {
    _httpClient = HttpClient();
  }

  factory NewsFeedService() => _instance;

  Future<ResponseModel> getNewsFeed() {
    return _httpClient.getRequest(url: kNewsFeedUrl);
  }
}
