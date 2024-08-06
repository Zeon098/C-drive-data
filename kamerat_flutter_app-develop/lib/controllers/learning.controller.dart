import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:kamerat_flutter_app/services/learning.service.dart';
import 'package:kamerat_flutter_app/models/learning.model.dart';
import 'package:kamerat_flutter_app/utils/constants.dart';

class LearningController extends GetxController
    with GetSingleTickerProviderStateMixin {
  List<LearningCourseModel> inProgressCourses = [];
  List<LearningCourseModel> completeCourses = [];

  late TabController tabController;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }

  Future<void> getData() async {
    final response = await LearningService().getCoursesProgress();
    if (response.code == kSuccessCode) {
      inProgressCourses.clear();
      completeCourses.clear();

      final courses = response.data["result"];
      for (var course in courses) {
        course = LearningCourseModel.fromJson(course);
        if (course.courseStatus == COURSEPROGRESS.completed.value) {
          completeCourses.add(course);
        } else {
          inProgressCourses.add(course);
        }
      }
    } else {}
  }
}
