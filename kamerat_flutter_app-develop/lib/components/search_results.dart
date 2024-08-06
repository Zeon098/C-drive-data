import 'package:flutter/material.dart';

import 'package:kamerat_flutter_app/controllers/search_overlay.controller.dart';
import 'package:kamerat_flutter_app/models/tutorial.model.dart';
import 'package:kamerat_flutter_app/models/course.model.dart';
import 'package:kamerat_flutter_app/models/season.model.dart';

class CoursesResult extends StatelessWidget {
  const CoursesResult({
    super.key,
    required this.controller,
    required this.course,
  });

  final SearchOverlayController controller;
  final CourseModel course;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: TextButton(
        onPressed: () => controller.navigateToCourse(course.id),
        child: Align(
          alignment: Alignment.topLeft,
          child: Row(
            children: [
              Container(
                height: 48.0,
                width: 48.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  image: DecorationImage(
                    image: NetworkImage(course.coverImageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 8.0),
              Column(
                children: [
                  Text(
                    course.courseName,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.w600,
                          color: const Color.fromRGBO(30, 35, 30, 1),
                        ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SeasonsResult extends StatelessWidget {
  const SeasonsResult({
    super.key,
    required this.controller,
    required this.season,
  });

  final SearchOverlayController controller;
  final SeasonModel season;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: TextButton(
        onPressed: () => controller.navigateToCourse(season.courseId),
        child: Align(
          alignment: Alignment.topLeft,
          child: Row(
            children: [
              const SizedBox(
                height: 48.0,
                width: 48.0,
              ),
              const SizedBox(width: 8.0),
              Text(
                season.seasonName,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: const Color.fromRGBO(30, 35, 30, 1),
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TutorialsResult extends StatelessWidget {
  const TutorialsResult({
    super.key,
    required this.controller,
    required this.tutorial,
  });

  final SearchOverlayController controller;
  final TutorialModel tutorial;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: TextButton(
        onPressed: () => controller.navigateToTutorial(tutorial),
        child: Align(
          alignment: Alignment.topLeft,
          child: Row(
            children: [
              Container(
                height: 48.0,
                width: 48.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  image: DecorationImage(
                    image: NetworkImage(tutorial.videoThumbnail),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 8.0),
              Text(
                tutorial.tutorialName,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: const Color.fromRGBO(30, 35, 30, 1),
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
