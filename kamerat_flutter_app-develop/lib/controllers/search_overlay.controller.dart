import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kamerat_flutter_app/models/tutorial.model.dart';
import 'package:kamerat_flutter_app/stores/user.store.dart';

import 'package:kamerat_flutter_app/utils/build_search_results.dart';
import 'package:kamerat_flutter_app/services/course.service.dart';
import 'package:kamerat_flutter_app/models/search.model.dart';
import 'package:kamerat_flutter_app/utils/constants.dart';
import 'package:kamerat_flutter_app/pages/search.dart';

class SearchOverlayController extends GetxController {
  final TextEditingController searchFieldController = TextEditingController();
  final FocusNode searchNode = FocusNode();
  final RxBool isFocused = false.obs;

  final RxString searchQuery = ''.obs;
  final RxBool isSearching = false.obs;
  RxList<Widget> results = <Widget>[].obs;

  late OverlayEntry overlayEntry;

  @override
  void onInit() {
    super.onInit();

    overlayEntry =
        OverlayEntry(builder: (context) => SearchBarPopUp(controller: this));
  }

  @override
  void onClose() {
    searchNode.dispose();
    super.onClose();
  }

  void search(String searchQuery) async {
    isSearching.value = true;
    final response = await CourseService().search(
      keyword: searchQuery,
      page: 0,
      pageSize: 5,
    );
    isSearching.value = false;
    if (response.code == kSuccessCode) {
      final searchResults =
          SearchResultsModel.fromJson(response.data['result']);
      results.value = buildResults(searchResults, this);
    } else {
      await Get.offAllNamed(
        response.redirectRoute.isNotEmpty
            ? response.redirectRoute
            : kServiceDownRoute,
      );
    }
  }

  void navigateToCourse(String courseId) {
    reset();
    Get.toNamed(kCourseDetailsRoute, arguments: {"courseId": courseId});
  }

  void navigateToTutorial(TutorialModel tutorial) {
    reset();
    if (tutorial.tutorialType == 'paid' && !UserStore().isSubscribed) {
      Get.toNamed(kCourseDetailsRoute,
          arguments: {"courseId": tutorial.courseId});
    }
    Get.toNamed(kTutorialDetailsRoute, arguments: {"tutorial": tutorial});
  }

  void reset() {
    overlayEntry.remove();
    isFocused.value = false;
    searchFieldController.text = '';
    searchNode.unfocus();
    results.clear();
  }

  bool get hasResults => results.isNotEmpty;
}
