import 'package:kamerat_flutter_app/models/picture_of_month.dart';
import 'package:kamerat_flutter_app/models/response.model.dart';
import 'package:kamerat_flutter_app/services/http_client.dart';
import 'package:kamerat_flutter_app/utils/api_endpoints.dart';

class POMService {
  late HttpClient _httpClient;

  static final POMService _instance = POMService._internal();

  POMService._internal() {
    _httpClient = HttpClient();
  }

  factory POMService() => _instance;

  Future<ResponseModel> getPictures() {
    return _httpClient.getRequest(url: kPictureOfMonthUrl);
  }

  Future<ResponseModel> toggleLike(POMModel picture) {
    return picture.isLiked.value
        ? _httpClient
            .putRequest(url: kUnlikePictureUrl, body: {"_id": picture.id})
        : _httpClient.postRequest(
            url: kLikePictureUrl,
            body: {"_id": picture.id},
            requiresAuthorization: true,
          );
  }

  Future<ResponseModel> getLikedPictures() {
    return _httpClient.getRequest(url: kLikedPicturesUrl);
  }
}
