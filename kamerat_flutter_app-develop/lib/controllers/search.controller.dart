import 'package:get/get.dart';

import 'package:kamerat_flutter_app/controllers/search_overlay.controller.dart';
import 'package:kamerat_flutter_app/services/course.service.dart';
import 'package:kamerat_flutter_app/models/category.model.dart';
import 'package:kamerat_flutter_app/utils/constants.dart';

class MySearchController extends GetxController {
  final RxInt refreshCount = 0.obs;
  final RxList<CategoryModel> categories = <CategoryModel>[].obs;

  final SearchOverlayController searchOverlayController =
      SearchOverlayController();

  @override
  void onInit() {
    super.onInit();
    searchOverlayController.onInit();
  }

  @override
  void onClose() {
    searchOverlayController.onClose();
    super.onClose();
  }

  Future<void> getCategories() async {
    categories.clear();
    final response = await CourseService().getCategories(page: 0, pageSize: 50);
    if (response.code == kSuccessCode) {
      for (final category in response.data) {
        categories.add(CategoryModel.fromJson(category));
      }
    } else {
      await Get.offAllNamed(
        response.redirectRoute.isNotEmpty
            ? response.redirectRoute
            : kServiceDownRoute,
      );
    }
  }

  Future<void> onRefresh() async {
    refreshCount.value++;
  }
}
