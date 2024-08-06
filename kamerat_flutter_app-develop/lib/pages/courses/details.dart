import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

import 'package:kamerat_flutter_app/controllers/course_details.controller.dart';
import 'package:kamerat_flutter_app/stores/course_progress.store.dart';
import 'package:kamerat_flutter_app/components/progress_bar.dart';
import 'package:kamerat_flutter_app/stores/purchase.store.dart';
import 'package:kamerat_flutter_app/components/seasons.dart';
import 'package:kamerat_flutter_app/components/app_bar.dart';
import 'package:kamerat_flutter_app/stores/user.store.dart';
import 'package:kamerat_flutter_app/utils/constants.dart';

class CourseDetails extends GetView<CourseDetailsController> {
  const CourseDetails({super.key});

  @override
  Widget build(BuildContext context) {
    CourseDetailsController controller = Get.find<CourseDetailsController>();
    return Scaffold(
      appBar: const MyAppBar(title: "Kursdetails"),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (controller.error.value.isNotEmpty) {
          return Center(
            child: Text(
              controller.error.value,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.error,
                  ),
            ),
          );
        } else {
          return Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 24.0,
                  horizontal: 16.0,
                ),
                child: RefreshIndicator(
                  onRefresh: controller.getCourseDetailsAndProgress,
                  child: ListView(
                    children: [
                      AspectRatio(
                        aspectRatio: 16 / 9,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.network(
                            controller.courseDetails.value.coverImage,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Center(
                                child: Icon(
                                  Icons.error,
                                  color: Theme.of(context).colorScheme.error,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      if (controller.isInstructorImageProvided ||
                          controller.isInstructorNameProvided)
                        const SizedBox(height: 24.0),
                      Row(
                        children: [
                          if (controller.isInstructorImageProvided)
                            CircleAvatar(
                              radius: 32.0,
                              backgroundImage: NetworkImage(
                                controller.courseDetails.value.instructorImage,
                              ),
                            ),
                          const SizedBox(width: 4.0),
                          if (controller.isInstructorNameProvided)
                            Text(
                              toBeginningOfSentenceCase(
                                controller.courseDetails.value.instructorName,
                              ),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onBackground,
                                  ),
                            )
                        ],
                      ),
                      const SizedBox(height: 16.0),
                      if (CourseProgressStore().courseStatus.isEmpty)
                        const SizedBox.shrink()
                      else if (CourseProgressStore().courseStatus ==
                          COURSEPROGRESS.inprogress.value)
                        const LinearProgressBar(percentage: 0.5)
                      else
                        const LinearProgressBar(percentage: 1.0),
                      if (CourseProgressStore().courseStatus.isNotEmpty)
                        const SizedBox(height: 16.0),
                      Text(
                        controller.courseDetails.value.courseName,
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.tertiary,
                            ),
                      ),
                      const SizedBox(height: 24.0),
                      Text(
                        controller.courseDetails.value.courseDescription,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: Theme.of(context).colorScheme.tertiary,
                            ),
                      ),
                      const SizedBox(height: 24.0),
                      Seasons(
                        seasons: controller.courseDetails.value.seasons,
                      ),
                    ],
                  ),
                ),
              ),
              if (controller.courseDetails.value.isPaid &&
                  PurchaseStore().isAvailable.value &&
                  !UserStore().isSubscribed)
                Positioned(
                  bottom: 20,
                  right: 20,
                  left: 20,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color.fromRGBO(19, 154, 67, 1),
                          Color.fromRGBO(20, 166, 47, 1),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(32.0),
                    ),
                    child: FloatingActionButton.extended(
                      backgroundColor: Colors.transparent,
                      extendedPadding: const EdgeInsets.all(32.0),
                      elevation: 0,
                      highlightElevation: 0,
                      label: Text(
                        'Upgrade für vollen Zugang (${PurchaseStore().products.first.price}/month)',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onPrimaryContainer,
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                      onPressed: () => Get.toNamed(kSubscriptionRoute),
                    ),
                  ),
                ),
            ],
          );
        }
      }),
    );
  }
}
