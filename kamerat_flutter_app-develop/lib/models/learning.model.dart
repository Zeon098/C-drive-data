import 'package:kamerat_flutter_app/utils/api_endpoints.dart';

class LearningCourseModel {
  final String id;
  final String courseName;
  final String courseCoverUrl;
  final String courseStatus;
  final int totalCourseDuration;
  final int pendingSeasons;
  final int inProgressSeasons;
  final int completedSeasons;
  final int totalPendingTutorials;
  final int totalInProgressTutorials;
  final int totalCompletedTutorials;

  LearningCourseModel({
    required this.id,
    required this.courseName,
    required this.courseCoverUrl,
    required this.courseStatus,
    required this.totalCourseDuration,
    required this.pendingSeasons,
    required this.inProgressSeasons,
    required this.completedSeasons,
    required this.totalPendingTutorials,
    required this.totalInProgressTutorials,
    required this.totalCompletedTutorials,
  });

  factory LearningCourseModel.fromJson(Map<String, dynamic> json) {
    return LearningCourseModel(
      id: json['course']['_id'] ?? '',
      courseName: json['course']['courseName'] ?? '',
      courseCoverUrl: json['course']['courseCoverUrl'] ?? '',
      courseStatus: json['courseStatus'] ?? '',
      totalCourseDuration: json['totalCourseDuration'] ?? '',
      pendingSeasons: json['pendingSeasons'],
      inProgressSeasons: json['inProgressSeasons'],
      completedSeasons: json['completedSeasons'],
      totalPendingTutorials: json['totalPendingTutorials'],
      totalInProgressTutorials: json['totalInProgressTutorials'],
      totalCompletedTutorials: json['totalCompletedTutorials'],
    );
  }

  String get coverImage =>
      courseCoverUrl.isNotEmpty ? '$kBaseAssetsUrl/assets/$courseCoverUrl' : '';

  int get totalSeasons => pendingSeasons + inProgressSeasons + completedSeasons;

  int get remainingSeasons => pendingSeasons + inProgressSeasons;

  int get totalTutorials =>
      totalPendingTutorials +
      totalInProgressTutorials +
      totalCompletedTutorials;

  int get remainingTutorials =>
      totalPendingTutorials + totalInProgressTutorials;
}
