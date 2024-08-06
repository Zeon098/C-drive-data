import 'package:kamerat_flutter_app/models/response.model.dart';
import 'package:kamerat_flutter_app/services/http_client.dart';
import 'package:kamerat_flutter_app/utils/api_endpoints.dart';

class LearningService {
  late HttpClient _httpClient;

  static final LearningService _instance = LearningService._internal();

  LearningService._internal() {
    _httpClient = HttpClient();
  }

  factory LearningService() => _instance;

  Future<ResponseModel> upsertCourseSubscription({
    required String courseId,
    required String seasonId,
    required String tutorialId,
    required String event,
  }) {
    return _httpClient.postRequest(
      url: kCourseSubscriptionUrl,
      body: {
        "courseId": courseId,
        "seasonId": seasonId,
        "tutorialId": tutorialId,
        "event": event,
      },
      requiresAuthorization: true,
    );
  }

  Future<ResponseModel> getCourseProgress({required String courseId}) {
    return _httpClient.getRequest(url: kCourseProgressUrl(courseId));
  }

  Future<ResponseModel> getCoursesProgress() {
    return _httpClient.getRequest(url: kCourseSubscriptionUrl);
  }
}
