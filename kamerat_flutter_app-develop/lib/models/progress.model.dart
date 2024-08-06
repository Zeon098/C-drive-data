class CourseProgressModel {
  final List<String> completedSeasons;
  final List<String> inprogressSeasons;
  final List<String> completedTutorials;
  final List<String> inprogressTutorials;
  final String courseStatus;

  CourseProgressModel({
    required this.completedSeasons,
    required this.inprogressSeasons,
    required this.completedTutorials,
    required this.inprogressTutorials,
    required this.courseStatus,
  });

  factory CourseProgressModel.empty() {
    return CourseProgressModel(
      completedSeasons: [],
      inprogressSeasons: [],
      completedTutorials: [],
      inprogressTutorials: [],
      courseStatus: '',
    );
  }

  factory CourseProgressModel.fromJson(Map<String, dynamic> json) {
    return CourseProgressModel(
      completedSeasons: List<String>.from(json['completedSeasons'] ?? ''),
      inprogressSeasons: List<String>.from(json['inprogressSeasons'] ?? ''),
      completedTutorials: List<String>.from(json['completedTutorials'] ?? ''),
      inprogressTutorials: List<String>.from(json['inprogressTutorials'] ?? ''),
      courseStatus: json['courseStatus'] ?? '',
    );
  }
}
