import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:flutter/material.dart';

import 'package:kamerat_flutter_app/services/course.service.dart';
import 'package:kamerat_flutter_app/models/course.model.dart';
import 'package:kamerat_flutter_app/utils/constants.dart';

class CoursesController extends GetxController {
  late PagingController<int, CourseModel> pagingController;

  RxInt refreshCount = 0.obs;
  RxString categoryId = ''.obs;
  late ScrollController scrollController;

  static const _pageSize = 10;

  @override
  void onInit() {
    super.onInit();
    scrollController = ScrollController();
    pagingController = PagingController(firstPageKey: 1);
    pagingController.addPageRequestListener((pageKey) => _fetchPage(pageKey));
  }

  @override
  void onReady() {
    super.onReady();

    ever(refreshCount, (count) {
      if (count != 0) {
        if (scrollController.hasClients) {
          scrollController.animateTo(
            0.0,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        }
        pagingController.refresh();
      }
    });
  }

  @override
  void onClose() {
    pagingController.dispose();
    scrollController.dispose();
    super.onClose();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newCourses = await _getCourses(page: pageKey, pageSize: _pageSize);
      final isLastPage = newCourses.length < _pageSize;
      if (isLastPage) {
        pagingController.appendLastPage(newCourses);
      } else {
        pagingController.appendPage(newCourses, pageKey + 1);
      }
    } catch (error) {
      pagingController.error = error;
    }
  }

  Future<List<CourseModel>> _getCourses({
    required int page,
    required int pageSize,
  }) async {
    final response = await CourseService().getCoursesList(
      page: page,
      pageSize: pageSize,
      categoryIds: [categoryId.value],
    );

    if (response.redirectRoute.isNotEmpty) {
      await Get.offAllNamed(response.redirectRoute);
    }

    if (response.code == kSuccessCode) {
      final List<CourseModel> courses = [];
      response.data["courses"].forEach((course) {
        courses.add(CourseModel.fromJson(course));
      });
      return courses;
    } else {
      throw Exception(
          "Kurse konnten nicht geladen werden. Please try again later.");
    }
  }
}
