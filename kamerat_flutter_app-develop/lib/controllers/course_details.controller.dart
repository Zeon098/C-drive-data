import 'package:get/get.dart';

import 'package:kamerat_flutter_app/stores/course_progress.store.dart';
import 'package:kamerat_flutter_app/services/learning.service.dart';
import 'package:kamerat_flutter_app/services/course.service.dart';
import 'package:kamerat_flutter_app/models/progress.model.dart';
import 'package:kamerat_flutter_app/models/course.model.dart';
import 'package:kamerat_flutter_app/utils/constants.dart';

class CourseDetailsController extends GetxController {
  String courseId = '';

  RxBool isLoading = true.obs;
  RxString error = "".obs;
  Rx<CourseDetailsModel> courseDetails = CourseDetailsModel.empty().obs;

  @override
  void onInit() {
    super.onInit();
    courseId = Get.arguments['courseId'];
  }

  @override
  void onReady() {
    super.onReady();
    getCourseDetailsAndProgress();
  }

  Future<void> getCourseDetailsAndProgress() async {
    final [details, progress] = await Future.wait([
      CourseService().getCourseDetails(courseId: courseId),
      LearningService().getCourseProgress(courseId: courseId)
    ]);

    if (details.redirectRoute.isNotEmpty) {
      await Get.offAllNamed(details.redirectRoute);
    }

    if (progress.redirectRoute.isNotEmpty) {
      await Get.offAllNamed(progress.redirectRoute);
    }

    isLoading.value = false;

    if (details.code == kSuccessCode && progress.code == kSuccessCode) {
      CourseProgressStore().init(CourseProgressModel.fromJson(progress.data));
      courseDetails.value = CourseDetailsModel.fromJson(details.data);
    } else {
      error.value =
          "Etwas ist schief gelaufen. Bitte versuche es später noch einmal.";
    }
  }

  bool get isInstructorImageProvided =>
      courseDetails.value.instructorImageUrl.isNotEmpty;

  bool get isInstructorNameProvided =>
      courseDetails.value.instructorName.isNotEmpty;
}
