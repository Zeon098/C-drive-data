import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kamerat_flutter_app/components/progress_bar.dart';

import 'package:kamerat_flutter_app/controllers/learning.controller.dart';
import 'package:kamerat_flutter_app/models/learning.model.dart';
import 'package:kamerat_flutter_app/utils/format_duration.dart';
import 'package:kamerat_flutter_app/utils/constants.dart';

class Learning extends GetView<LearningController> {
  const Learning({super.key});

  @override
  Widget build(BuildContext context) {
    LearningController controller = Get.put(LearningController());

    return FutureBuilder(
        future: controller.getData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                  child: Text(
                '${snapshot.error}',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.error,
                    ),
              )),
            );
          }

          return DefaultTabController(
            length: 2,
            child: Column(children: [
              const Material(
                child: SizedBox(
                  height: 55,
                  child: TabBar(
                    physics: ClampingScrollPhysics(),
                    tabAlignment: TabAlignment.fill,
                    tabs: [Tab(text: "In Arbeit"), Tab(text: "Vollendet")],
                  ),
                ),
              ),
              Expanded(
                child: TabBarView(children: [
                  if (controller.inProgressCourses.isNotEmpty)
                    LearningCoursesList(courses: controller.inProgressCourses),
                  if (controller.inProgressCourses.isEmpty)
                    Center(
                      child: Text(
                        "Keine Kurse in Bearbeitung",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).colorScheme.tertiary),
                      ),
                    ),
                  if (controller.completeCourses.isNotEmpty)
                    LearningCoursesList(courses: controller.completeCourses),
                  if (controller.completeCourses.isEmpty)
                    Center(
                      child: Text(
                        "Keine Kurse abgeschlossen",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).colorScheme.tertiary),
                      ),
                    ),
                ]),
              )
            ]),
          );
        });
  }
}

class LearningCoursesList extends StatelessWidget {
  final List<LearningCourseModel> courses;
  const LearningCoursesList({super.key, required this.courses});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
      child: ListView.separated(
        itemCount: courses.length,
        separatorBuilder: (context, index) {
          return const SizedBox(height: 16.0);
        },
        itemBuilder: (context, index) {
          final course = courses[index];
          return GestureDetector(
            onTap: () => Get.toNamed(kCourseDetailsRoute,
                arguments: {"courseId": course.id}),
            child: Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1.0,
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        height: 75,
                        width: 75,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          image: DecorationImage(
                            image: NetworkImage(course.coverImage),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            course.courseName,
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(context).colorScheme.tertiary,
                                ),
                          ),
                          const SizedBox(height: 8.0),
                          Row(
                            children: [
                              Image.asset("assets/icons/watch.png"),
                              const SizedBox(width: 8.0),
                              Text(
                                formatDuration(course.totalCourseDuration),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                              const SizedBox(width: 4.0),
                              const Text("•"),
                              const SizedBox(width: 4.0),
                              Image.asset("assets/icons/clapper_board.png"),
                              const SizedBox(width: 4.0),
                              ShaderMask(
                                shaderCallback: (bounds) =>
                                    const LinearGradient(
                                  colors: [
                                    Color.fromRGBO(255, 159, 28, 1),
                                    Color.fromRGBO(255, 123, 28, 1)
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                ).createShader(bounds),
                                child: Text(
                                  '${course.totalSeasons} ${course.totalSeasons > 1 ? "Staffeln" : "Staffel"}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 12.0),
                  LinearProgressBar(
                      percentage: course.totalCompletedTutorials /
                          course.totalTutorials),
                  const SizedBox(height: 8.0),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${course.completedSeasons} / ${course.totalSeasons} ${course.totalSeasons == 1 ? "Staffel" : "Staffeln"}',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(
                                color: Theme.of(context).colorScheme.tertiary,
                              ),
                        ),
                        Text(
                          '${(course.totalCompletedTutorials / course.totalTutorials * 100).toInt()}%',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(
                                color: Theme.of(context).colorScheme.tertiary,
                              ),
                        )
                      ]),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
