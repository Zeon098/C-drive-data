import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kamerat_flutter_app/controllers/courses.controller.dart';

import 'package:kamerat_flutter_app/components/loading_card.dart';
import 'package:kamerat_flutter_app/components/course_card.dart';
import 'package:kamerat_flutter_app/models/course.model.dart';

class Courses extends GetView<CoursesController> {
  final int refreshCount;
  final String categoryId;
  const Courses(
      {super.key, required this.refreshCount, required this.categoryId});

  @override
  Widget build(BuildContext context) {
    CoursesController controller = Get.put(
      CoursesController(),
      tag: categoryId,
    );

    controller.refreshCount.value = refreshCount;
    controller.categoryId.value = categoryId;

    return SizedBox(
      height: 255.0,
      child: PagedListView(
        scrollDirection: Axis.horizontal,
        scrollController: controller.scrollController,
        pagingController: controller.pagingController,
        builderDelegate: PagedChildBuilderDelegate<CourseModel>(
          itemBuilder: (context, course, index) {
            return CourseCard(course: course);
          },
          firstPageProgressIndicatorBuilder: (context) {
            return const Row(
              children: [
                LoadingCard(),
                LoadingCard(),
                LoadingCard(),
                LoadingCard(),
                LoadingCard(),
              ],
            );
          },
          newPageProgressIndicatorBuilder: (context) {
            return const LoadingCard();
          },
          noItemsFoundIndicatorBuilder: (context) {
            return const Center(child: Text("Keine Kurse verfügbar"));
          },
          firstPageErrorIndicatorBuilder: (context) {
            return Center(
                child: Text(
              "Could not load courses. Please try again later.",
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.error,
                  ),
            ));
          },
          newPageErrorIndicatorBuilder: (context) {
            return Center(
                child: Text(
              "Could not load courses. Please try again later.",
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.error,
                  ),
            ));
          },
        ),
      ),
    );
  }
}
