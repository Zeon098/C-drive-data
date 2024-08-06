import 'package:kamerat_flutter_app/utils/api_endpoints.dart';

class TutorialModel {
  final String id;
  final String tutorialName;
  final String tutorialDescription;
  final String videoThumbnail;
  final String courseId;
  final String seasonId;
  final int videoDuration;
  final String videoUri;
  final List<String> homeworkVideoLink;
  final String homeworkImageUrl;
  final String homeworkfileUrl;
  final String homeworkText;
  final String tutorialType;

  TutorialModel({
    required this.id,
    required this.tutorialName,
    required this.tutorialDescription,
    required this.videoThumbnail,
    required this.courseId,
    required this.seasonId,
    required this.videoDuration,
    required this.videoUri,
    required this.homeworkVideoLink,
    required this.homeworkImageUrl,
    required this.homeworkfileUrl,
    required this.homeworkText,
    required this.tutorialType,
  });

  TutorialModel.empty()
      : id = '',
        tutorialName = '',
        tutorialDescription = '',
        videoThumbnail = '',
        courseId = '',
        seasonId = '',
        videoDuration = 0,
        videoUri = '',
        homeworkVideoLink = [],
        homeworkImageUrl = '',
        homeworkfileUrl = '',
        homeworkText = '',
        tutorialType = '';

  factory TutorialModel.fromJson(Map<String, dynamic> json) {
    return TutorialModel(
      id: json['_id'] ?? '',
      tutorialName: json['tutorialName'] ?? '',
      tutorialDescription: json['tutorialDescription'] ?? '',
      videoThumbnail: json['videoThumbnail'] ?? '',
      courseId: json['courseId'] ?? '',
      seasonId: json['seasonId'] ?? '',
      videoDuration: json['videoDuration'] ?? 0,
      videoUri: json['videoUri'] ?? '',
      homeworkVideoLink: json['homeworkVideoLink'].isNotEmpty
          ? List<String>.from(json['homeworkVideoLink'].map((link) => link))
          : [],
      homeworkImageUrl: json['homeworkImageUrl'] ?? '',
      homeworkfileUrl: json['homeworkfileUrl'] ?? '',
      homeworkText: json['homeworkText'] ?? '',
      tutorialType: json['tutorialType'] ?? '',
    );
  }

  String get homeWorkFileUrl => homeworkfileUrl.isNotEmpty
      ? '$kBaseAssetsUrl/assets/$homeworkfileUrl'
      : '';

  String get homeWorkImageUrl => homeworkImageUrl.isNotEmpty
      ? '$kBaseAssetsUrl/assets/$homeworkImageUrl'
      : '';
}
