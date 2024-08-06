class SeasonModel {
  final String id;
  final String seasonName;
  final String courseId;
  final int tutorialsCount;
  final int totalDuration;

  SeasonModel({
    required this.id,
    required this.seasonName,
    required this.courseId,
    required this.tutorialsCount,
    required this.totalDuration,
  });

  factory SeasonModel.fromJson(Map<String, dynamic> json) {
    return SeasonModel(
      id: json['_id'] ?? '',
      seasonName: json['seasonName'] ?? '',
      courseId: json['courseId'] ?? '',
      tutorialsCount: json['tutorialsCount'] ?? '',
      totalDuration: json['totalDuration'] ?? '',
    );
  }
}
