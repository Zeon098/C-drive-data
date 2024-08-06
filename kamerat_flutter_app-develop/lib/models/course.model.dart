import 'package:kamerat_flutter_app/models/season.model.dart';
import 'package:kamerat_flutter_app/utils/api_endpoints.dart';

class CourseModel {
  final String id;
  final String courseName;
  final String courseCoverUrl;
  final String courseType;
  final int totalVideoDuration;

  CourseModel({
    required this.id,
    required this.courseName,
    required this.courseCoverUrl,
    required this.courseType,
    required this.totalVideoDuration,
  });

  factory CourseModel.fromJson(Map<String, dynamic> json) {
    return CourseModel(
      id: json['_id'] ?? '',
      courseName: json['courseName'] ?? '',
      courseCoverUrl: json['courseCoverUrl'] ?? '',
      courseType: json['courseType'] ?? '',
      totalVideoDuration: json['totalVideoDuration'] ?? 0,
    );
  }

  String get coverImageUrl =>
      courseCoverUrl.isNotEmpty ? '$kBaseAssetsUrl/assets/$courseCoverUrl' : '';
}

class CourseDetailsModel {
  final String id;
  final String courseName;
  final String courseDescription;
  final String courseType;
  final String courseCoverUrl;
  final String instructorName;
  final String instructorImageUrl;
  final List<SeasonModel> seasons;

  CourseDetailsModel({
    required this.id,
    required this.courseName,
    required this.courseDescription,
    required this.courseType,
    required this.courseCoverUrl,
    required this.instructorName,
    required this.instructorImageUrl,
    required this.seasons,
  });

  factory CourseDetailsModel.empty() {
    return CourseDetailsModel(
      id: '',
      courseName: '',
      courseDescription: '',
      courseType: '',
      courseCoverUrl: '',
      instructorName: '',
      instructorImageUrl: '',
      seasons: [],
    );
  }

  factory CourseDetailsModel.fromJson(Map<String, dynamic> json) {
    return CourseDetailsModel(
      id: json['_id'] ?? '',
      courseName: json['courseName'] ?? '',
      courseDescription: json['courseDescription'] ?? '',
      courseType: json['courseType'] ?? '',
      courseCoverUrl: json['courseCoverUrl'] ?? '',
      instructorName: json['instructorName'] ?? '',
      instructorImageUrl: json['instructorImageUrl'] ?? '',
      seasons: json['seasons'] != null
          ? List<SeasonModel>.from(
              json['seasons'].map((season) => SeasonModel.fromJson(season)),
            )
          : [],
    );
  }

  String get coverImage =>
      courseCoverUrl.isNotEmpty ? '$kBaseAssetsUrl/assets/$courseCoverUrl' : '';

  String get instructorImage => instructorImageUrl.isNotEmpty
      ? '$kBaseAssetsUrl/assets/$instructorImageUrl'
      : '';

  bool get isPaid => courseType == 'paid';
}
