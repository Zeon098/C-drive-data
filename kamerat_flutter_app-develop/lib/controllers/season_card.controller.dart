import 'package:get/get.dart';

import 'package:kamerat_flutter_app/services/course.service.dart';
import 'package:kamerat_flutter_app/models/tutorial.model.dart';
import 'package:kamerat_flutter_app/utils/constants.dart';

class SeasonCardController extends GetxController {
  RxBool isExpanded = false.obs;

  void toggleExpansion() {
    isExpanded.value = !isExpanded.value;
  }

  Future<List<TutorialModel>> getSeasonTutorials(
      {required String coureId, required String seasonId}) async {
    List<TutorialModel> tutorials = [];
    final response = await CourseService().getSeasonTutorials(
      coureId: coureId,
      seasonId: seasonId,
    );

    if (response.redirectRoute.isNotEmpty) {
      await Get.offAllNamed(response.redirectRoute);
      return [];
    }

    if (response.code == kSuccessCode) {
      tutorials = (response.data as List)
          .map((tutorial) => TutorialModel.fromJson(tutorial))
          .toList();
    } else {
      throw Exception('Failed to load tutorials');
    }
    return tutorials;
  }
}
