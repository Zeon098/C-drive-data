import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:get/get.dart';

import 'package:kamerat_flutter_app/services/course.service.dart';
import 'package:kamerat_flutter_app/models/category.model.dart';
import 'package:kamerat_flutter_app/models/course.model.dart';
import 'package:kamerat_flutter_app/utils/constants.dart';

class CourseCatalogueController extends GetxController {
  PagingController<int, CategoryModel> categoriesPagingController =
      PagingController(firstPageKey: 1);

  PagingController<int, CourseModel> coursesPagingController =
      PagingController(firstPageKey: 1);

  final RxList<String> selectedCategoryIds = <String>[].obs;

  static const _pageSize = 10;

  @override
  void onInit() {
    super.onInit();
    categoriesPagingController.addPageRequestListener((pageKey) {
      _fetchCategoriesPage(pageKey);
    });
    coursesPagingController.addPageRequestListener((pageKey) {
      _fetchCoursesPage(pageKey);
    });

    ever(
      selectedCategoryIds,
      (ids) {
        coursesPagingController.refresh();
      },
    );
  }

  @override
  void onClose() {
    coursesPagingController.dispose();
    categoriesPagingController.dispose();
    super.onClose();
  }

  Future<void> _fetchCategoriesPage(int pageKey) async {
    try {
      final newCategories =
          await _getCategories(page: pageKey, pageSize: _pageSize);
      final isLastPage = newCategories.length < _pageSize;
      if (isLastPage) {
        categoriesPagingController.appendLastPage(newCategories);
      } else {
        categoriesPagingController.appendPage(newCategories, pageKey + 1);
      }
    } catch (error) {
      categoriesPagingController.error = error;
    }
  }

  Future<void> _fetchCoursesPage(int pageKey) async {
    try {
      final newCourses = await _getCourses(
        page: pageKey,
        pageSize: _pageSize,
      );
      final isLastPage = newCourses.length < _pageSize;
      if (isLastPage) {
        coursesPagingController.appendLastPage(newCourses);
      } else {
        coursesPagingController.appendPage(newCourses, pageKey + 1);
      }
    } catch (error) {
      coursesPagingController.error = error;
    }
  }

  Future<List<CategoryModel>> _getCategories({
    required int page,
    required int pageSize,
  }) async {
    final response = await CourseService().getCategories(
      page: page,
      pageSize: pageSize,
    );

    if (response.redirectRoute.isNotEmpty) {
      await Get.offAllNamed(response.redirectRoute);
      return [];
    }

    if (response.code == kSuccessCode) {
      final List<CategoryModel> categories = [];
      response.data.forEach((c) {
        final category = CategoryModel.fromJson(c);
        categories.add(category);
        for (final child in category.children) {
          categories.add(child);
        }
      });
      return categories;
    } else {
      throw Exception("Kategorien konnten nicht geladen werden");
    }
  }

  Future<List<CourseModel>> _getCourses({
    required int page,
    required int pageSize,
  }) async {
    final response = await CourseService().getCoursesList(
      page: page,
      pageSize: pageSize,
      categoryIds: selectedCategoryIds.toList(),
    );

    if (response.redirectRoute.isNotEmpty) {
      await Get.offAllNamed(response.redirectRoute);
      return [];
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
