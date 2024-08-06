import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:kamerat_flutter_app/controllers/home.controller.dart';
import 'package:kamerat_flutter_app/components/picture_of_month.dart';
import 'package:kamerat_flutter_app/components/courses_area.dart';
import 'package:kamerat_flutter_app/components/news_ticker.dart';
import 'package:kamerat_flutter_app/utils/constants.dart';

class Home extends GetView<HomeController> {
  const Home({super.key});
  @override
  Widget build(BuildContext context) {
    HomeController controller = Get.put(HomeController());
    return Stack(children: [
      Obx(
        () {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return HomeBody(controller: controller);
          }
        },
      ),
      Align(
        alignment: Alignment.bottomCenter,
        child: Obx(
          () => controller.isLoading.value
              ? const SizedBox.shrink()
              : NewsTicker(text: controller.news.value),
        ),
      ),
    ]);
  }
}

class HomeBody extends StatelessWidget {
  final HomeController controller;

  const HomeBody({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24.0),
      child: RefreshIndicator(
        onRefresh: controller.getData,
        child: ListView(
          children: [
            const POMHeader(),
            const SizedBox(height: 16.0),
            PictureOfMonthGallery(imageList: controller.pictures),
            Obx(
              () => CoursesArea(
                refreshCount: controller.refreshCount.value,
                categories: controller.categories,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class POMHeader extends StatelessWidget {
  const POMHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Bild des Monats",
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
          ),
          TextButton(
              onPressed: () => Get.toNamed(kLikesRoute),
              child: Text(
                "Siehe Likes",
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ))
        ],
      ),
    );
  }
}
