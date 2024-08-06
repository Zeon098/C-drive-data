import 'package:get/get.dart';
import 'package:kamerat_flutter_app/utils/api_endpoints.dart';

class POMModel {
  String id = '';
  String month = '';
  String year = '';
  String authorName = '';
  int noOfLikes = 0;
  String _url = '';
  RxBool isLiked = false.obs;

  POMModel({
    required this.id,
    required this.month,
    required this.year,
  });

  POMModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'] ?? '';
    month = json['month'] ?? '';
    year = json['year'] ?? '';
    authorName = json['authorName'] ?? '';
    noOfLikes = json['noOfLikes'] ?? 0;
    _url = json['url'] ?? '';
    isLiked.value = json['isLiked'] ?? false;
  }
  String get url => _url.isNotEmpty ? '$kBaseAssetsUrl/assets/$_url' : '';
}
