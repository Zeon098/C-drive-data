import "package:kamerat_flutter_app/services/http_client.dart";
import 'package:kamerat_flutter_app/models/response.model.dart';
import 'package:kamerat_flutter_app/utils/api_endpoints.dart';

class CourseService {
  late HttpClient _httpClient;

  static final CourseService _instance = CourseService._internal();

  CourseService._internal() {
    _httpClient = HttpClient();
  }

  factory CourseService() => _instance;

  Future<ResponseModel> getCoursesList({
    required int page,
    required int pageSize,
    String? keyword,
    List<String>? categoryIds,
  }) {
    String url = '$kCoursesUrl?active=true&page=$page&perPage=$pageSize';

    if (keyword != null) {
      url += '&keyword=$keyword';
    }
    if (categoryIds != null && categoryIds.isNotEmpty) {
      url += '&categoryIds=${categoryIds.join(',')}';
    }

    return _httpClient.getRequest(url: url, requiresAuthorization: false);
  }

  Future<ResponseModel> getCategories(
      {required int page, required int pageSize}) {
    return _httpClient.getRequest(
      url: '$kCategoriesUrl?active=true&page=$page&perPage=$pageSize',
      requiresAuthorization: false,
    );
  }

  Future<ResponseModel> getCourseDetails({required String courseId}) {
    return _httpClient.getRequest(url: '$kCoursesUrl/$courseId');
  }

  Future<ResponseModel> getSeasonTutorials(
      {required String coureId, required String seasonId}) {
    return _httpClient.getRequest(
      url: '$kCoursesUrl/$coureId/season/$seasonId',
    );
  }

  Future<ResponseModel> search(
      {required String keyword, required int page, required int pageSize}) {
    return _httpClient.getRequest(
        url: '$kSearchUrl/?keyword=$keyword&page=$page&perPage=$pageSize');
  }
}
