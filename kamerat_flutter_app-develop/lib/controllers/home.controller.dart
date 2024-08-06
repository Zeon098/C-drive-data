import 'package:get/get.dart';

import 'package:kamerat_flutter_app/services/news_feed.service.dart';
import 'package:kamerat_flutter_app/services/picture_of_month.dart';
import 'package:kamerat_flutter_app/services/course.service.dart';
import 'package:kamerat_flutter_app/models/picture_of_month.dart';
import 'package:kamerat_flutter_app/models/category.model.dart';
import 'package:kamerat_flutter_app/models/response.model.dart';
import 'package:kamerat_flutter_app/utils/constants.dart';

class HomeController extends GetxController {
  RxString news = "".obs;
  RxList<POMModel> pictures = <POMModel>[].obs;
  RxList<CategoryModel> categories = <CategoryModel>[].obs;

  RxBool isLoading = true.obs;

  RxInt refreshCount = 0.obs;

  @override
  void onReady() {
    getData();
  }

  Future<void> getData() async {
    final [picturesResponse, categoriesResponse, newsResponse] =
        await Future.wait([
      POMService().getPictures(),
      CourseService().getCategories(page: 0, pageSize: 50),
      NewsFeedService().getNewsFeed(),
    ]);

    _handlePicturesResponse(picturesResponse);
    _handleCategoriesResponse(categoriesResponse);
    _handleNewsResponse(newsResponse);

    isLoading.value = false;
    refreshCount.value++;
  }

  void _handleNewsResponse(ResponseModel response) async {
    final List<String> allNews = [];
    if (response.code == kSuccessCode) {
      for (final feedItem in response.data["result"]) {
        allNews.add(feedItem["text"]);
      }
    } else {
      await Get.offAllNamed(
        response.redirectRoute.isNotEmpty
            ? response.redirectRoute
            : kServiceDownRoute,
      );
    }
    news.value = "${allNews.join(" • ")} • ";
  }

  void _handleCategoriesResponse(ResponseModel response) async {
    categories.clear();
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

  void _handlePicturesResponse(ResponseModel response) async {
    pictures.clear();
    if (response.code == kSuccessCode) {
      for (final picture in response.data) {
        pictures.add(POMModel.fromJson(picture));
      }
    } else {
      await Get.offAllNamed(
        response.redirectRoute.isNotEmpty
            ? response.redirectRoute
            : kServiceDownRoute,
      );
    }
  }
}
