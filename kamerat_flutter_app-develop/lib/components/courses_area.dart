import 'package:dynamic_tabbar/dynamic_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:kamerat_flutter_app/controllers/courses_area.controller.dart';
import 'package:kamerat_flutter_app/models/category.model.dart';
import 'package:kamerat_flutter_app/components/courses.dart';
import 'package:kamerat_flutter_app/utils/constants.dart';

class CoursesArea extends GetView<CoursesAreaController> {
  final int refreshCount;
  final List<CategoryModel> categories;
  const CoursesArea({
    super.key,
    required this.refreshCount,
    required this.categories,
  });

  @override
  Widget build(BuildContext context) {
    CoursesAreaController controller = Get.put(CoursesAreaController());
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 24.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Kurs Kategorien",
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).colorScheme.tertiary,
                        ),
                  ),
                  TextButton(
                      onPressed: () => Get.toNamed(
                            kCourseCatalogueRoute,
                            arguments: {'id': controller.currentCategoryId},
                          ),
                      child: Text(
                        "Alles Sehen",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                      ))
                ],
              ),
            ),
            Column(children: [
              SizedBox(
                height: 64,
                child: DynamicTabBarWidget(
                  isScrollable: true,
                  showBackIcon: false,
                  showNextIcon: false,
                  onTabChanged: (int? index) {
                    controller.currentCategoryId.value = categories[index!].id;
                  },
                  onTabControllerUpdated: (tabController) {
                    controller.currentCategoryId.value =
                        categories[tabController.index].id;
                  },
                  dynamicTabs: categories.map((category) {
                    return TabData(
                      index: categories.indexOf(category),
                      title: Tab(text: category.title),
                      content: const SizedBox.shrink(),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 16.0),
              Obx(
                () => Courses(
                  refreshCount: refreshCount,
                  categoryId: controller.currentCategoryId.value.isNotEmpty
                      ? controller.currentCategoryId.value
                      : categories.first.id,
                  key: Key(
                    controller.currentCategoryId.value.isNotEmpty
                        ? controller.currentCategoryId.value
                        : categories.first.id,
                  ),
                ),
              ),
            ]),
          ],
        ));
  }
}
