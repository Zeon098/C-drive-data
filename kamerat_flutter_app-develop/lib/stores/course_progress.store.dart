import 'package:get/get.dart';

import 'package:kamerat_flutter_app/models/progress.model.dart';
import 'package:kamerat_flutter_app/utils/constants.dart';

class CourseProgressStore {
  static final Rx<CourseProgressModel> _courseProgress =
      CourseProgressModel.empty().obs;

  static final CourseProgressStore _instance = CourseProgressStore._internal();

  CourseProgressStore._internal();

  factory CourseProgressStore() {
    return _instance;
  }

  void init(CourseProgressModel courseProgress) {
    _courseProgress.value = courseProgress;
  }

  String get courseStatus {
    switch (_courseProgress.value.courseStatus) {
      case "inProgress":
        return COURSEPROGRESS.inprogress.value;
      case "completed":
        return COURSEPROGRESS.completed.value;
      default:
        return "";
    }
  }

  String getSeasonStatus(String seasonId) {
    if (_courseProgress.value.inprogressSeasons.contains(seasonId)) {
      return COURSEPROGRESS.inprogress.value;
    } else if (_courseProgress.value.completedSeasons.contains(seasonId)) {
      return COURSEPROGRESS.completed.value;
    } else {
      return "";
    }
  }

  String getTutorialStatus(String tutorialId) {
    if (_courseProgress.value.inprogressTutorials.contains(tutorialId)) {
      return COURSEPROGRESS.inprogress.value;
    } else if (_courseProgress.value.completedTutorials.contains(tutorialId)) {
      return COURSEPROGRESS.completed.value;
    } else {
      return "";
    }
  }
}
