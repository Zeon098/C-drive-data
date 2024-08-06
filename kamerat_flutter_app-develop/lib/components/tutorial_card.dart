import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:kamerat_flutter_app/stores/course_progress.store.dart';
import 'package:kamerat_flutter_app/components/progress_bar.dart';
import 'package:kamerat_flutter_app/stores/user.store.dart';
import 'package:kamerat_flutter_app/utils/format_duration.dart';
import 'package:kamerat_flutter_app/models/tutorial.model.dart';
import 'package:kamerat_flutter_app/utils/constants.dart';

class TutorialCard extends StatelessWidget {
  final TutorialModel tutorial;
  final int index;
  const TutorialCard({super.key, required this.tutorial, required this.index});

  String get title => "Epi ${index + 1}: ${tutorial.tutorialName}";

  @override
  Widget build(BuildContext context) {
    String tutorialStatus =
        CourseProgressStore().getTutorialStatus(tutorial.id);
    final userStore = UserStore();
    return GestureDetector(
      onTap: () {
        if (tutorial.tutorialType == 'paid' && !userStore.isSubscribed) {
          return;
        }
        Get.toNamed(kTutorialDetailsRoute, arguments: {"tutorial": tutorial});
      },
      child: ImageFiltered(
        imageFilter: tutorial.tutorialType == 'paid' && !userStore.isSubscribed
            ? ImageFilter.blur(sigmaX: 2, sigmaY: 2)
            : ImageFilter.blur(sigmaX: 0, sigmaY: 0),
        child: Card(
          surfaceTintColor: Theme.of(context).colorScheme.surface,
          margin: const EdgeInsets.only(bottom: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      tutorial.videoThumbnail,
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(
                          Icons.error,
                          color: Theme.of(context).colorScheme.error,
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context).colorScheme.tertiary,
                              ),
                        ),
                        const SizedBox(height: 4.0),
                        Text(
                          formatDuration(tutorial.videoDuration),
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                color: Theme.of(context).colorScheme.tertiary,
                              ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  if (tutorialStatus.isEmpty)
                    Image.asset(
                      "assets/icons/play.png",
                      color: Theme.of(context).colorScheme.primary,
                      width: 40.0,
                      height: 40.0,
                    )
                  else if (tutorialStatus == COURSEPROGRESS.inprogress.value)
                    const CircularInProgressBar(percentage: 0.5)
                  else
                    const CircularCompletedBar()
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
