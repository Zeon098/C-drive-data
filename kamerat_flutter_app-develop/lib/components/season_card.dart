import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:kamerat_flutter_app/controllers/season_card.controller.dart';
import 'package:kamerat_flutter_app/stores/course_progress.store.dart';
import 'package:kamerat_flutter_app/components/progress_bar.dart';
import 'package:kamerat_flutter_app/components/tutorial_card.dart';
import 'package:kamerat_flutter_app/utils/constants.dart';
import 'package:kamerat_flutter_app/utils/format_duration.dart';
import 'package:kamerat_flutter_app/models/season.model.dart';

class SeasonCard extends GetView<SeasonCardController> {
  final SeasonModel season;
  final int index;
  const SeasonCard({super.key, required this.season, required this.index});

  String get title => "Staffel ${index + 1}: ${season.seasonName}";

  @override
  Widget build(BuildContext context) {
    SeasonCardController controller = Get.put(
      SeasonCardController(),
      tag: title,
    );
    String seasonStatus = CourseProgressStore().getSeasonStatus(season.id);
    return GestureDetector(
      onTap: controller.toggleExpansion,
      child: Card(
        clipBehavior: Clip.none,
        surfaceTintColor: Theme.of(context).colorScheme.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
          side: const BorderSide(
            color: Color.fromRGBO(230, 236, 232, 1),
            width: 1.0,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context).colorScheme.tertiary,
                              ),
                        ),
                        const SizedBox(height: 8.0),
                        Row(
                          children: [
                            ShaderMask(
                              shaderCallback: (bounds) => const LinearGradient(
                                colors: [
                                  Color.fromRGBO(19, 154, 67, 1),
                                  Color.fromRGBO(20, 166, 47, 1)
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ).createShader(bounds),
                              child: Text(
                                formatDuration(season.totalDuration),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                              ),
                            ),
                            const SizedBox(width: 8.0),
                            Image.asset("assets/icons/watch.png"),
                            const SizedBox(width: 8.0),
                            const Text("•"),
                            const SizedBox(width: 8.0),
                            ShaderMask(
                              shaderCallback: (bounds) => const LinearGradient(
                                colors: [
                                  Color.fromRGBO(255, 159, 28, 1),
                                  Color.fromRGBO(255, 123, 28, 1)
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ).createShader(bounds),
                              child: Text(
                                "${season.tutorialsCount} ${season.tutorialsCount > 1 ? 'Episoden' : 'Episode'} ",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                              ),
                            ),
                            const SizedBox(width: 8.0),
                            Image.asset("assets/icons/clapper_board.png"),
                          ],
                        ),
                      ],
                    ),
                  ),
                  if (seasonStatus.isEmpty)
                    Obx(
                      () => Icon(
                        controller.isExpanded.value
                            ? Icons.keyboard_arrow_up
                            : Icons.keyboard_arrow_down,
                        size: 24.0,
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                    )
                  else if (seasonStatus == COURSEPROGRESS.inprogress.value)
                    const CircularInProgressBar(percentage: 0.5)
                  else
                    const CircularCompletedBar()
                ],
              ),
              Obx(
                () => controller.isExpanded.value
                    ? Column(
                        children: [
                          const SizedBox(height: 24.0),
                          const Divider(
                              color: Color.fromRGBO(230, 236, 232, 1)),
                          const SizedBox(height: 24.0),
                          FutureBuilder(
                            future: controller.getSeasonTutorials(
                              coureId: season.courseId,
                              seasonId: season.id,
                            ),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              if (snapshot.hasError) {
                                return Center(
                                  child: Text(
                                    snapshot.error.toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                          fontWeight: FontWeight.w500,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .error,
                                        ),
                                  ),
                                );
                              }
                              final tutorials = snapshot.data as List;
                              if (tutorials.isEmpty) {
                                return Center(
                                  child: Text(
                                    'No tutorials found',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                          fontWeight: FontWeight.w500,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onBackground,
                                        ),
                                  ),
                                );
                              }
                              return Column(
                                children: tutorials
                                    .map(
                                      (tutorial) => TutorialCard(
                                        tutorial: tutorial,
                                        index: tutorials.indexOf(tutorial),
                                      ),
                                    )
                                    .toList(),
                              );
                            },
                          )
                        ],
                      )
                    : const SizedBox.shrink(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
