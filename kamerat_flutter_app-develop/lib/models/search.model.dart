import 'package:kamerat_flutter_app/models/tutorial.model.dart';
import 'package:kamerat_flutter_app/models/course.model.dart';
import 'package:kamerat_flutter_app/models/season.model.dart';

class SearchResultsModel {
  final List<CourseModel> courses;
  final List<SeasonModel> seasons;
  final List<TutorialModel> tutorials;

  SearchResultsModel({
    required this.courses,
    required this.seasons,
    required this.tutorials,
  });

  SearchResultsModel.empty()
      : courses = [],
        seasons = [],
        tutorials = [];

  factory SearchResultsModel.fromJson(Map<String, dynamic> json) {
    return SearchResultsModel(
      courses: json['courses']['list'] != null
          ? List<CourseModel>.from(
              json['courses']['list']
                  .map((course) => CourseModel.fromJson(course)),
            )
          : [],
      seasons: json['seasons']['list'] != null
          ? List<SeasonModel>.from(
              json['seasons']['list']
                  .map((season) => SeasonModel.fromJson(season)),
            )
          : [],
      tutorials: json['tutorials']['list'] != null
          ? List<TutorialModel>.from(
              json['tutorials']['list']
                  .map((tutorial) => TutorialModel.fromJson(tutorial)),
            )
          : [],
    );
  }
}
