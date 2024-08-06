import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kamerat_flutter_app/utils/constants.dart';

import 'package:kamerat_flutter_app/utils/format_duration.dart';
import 'package:kamerat_flutter_app/models/course.model.dart';

class CourseTile extends StatelessWidget {
  final CourseModel course;
  const CourseTile({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      child: ListTile(
        leading: Container(
          height: 75,
          width: 75,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            image: DecorationImage(
              image: NetworkImage(course.coverImageUrl),
              fit: BoxFit.contain,
            ),
          ),
        ),
        title: Text(course.courseName),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8.0),
            Row(
              children: [
                Image.asset("assets/icons/watch.png"),
                const SizedBox(width: 8.0),
                Text(
                  formatDuration(course.totalVideoDuration),
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ],
            ),
          ],
        ),
        onTap: () => Get.toNamed(kCourseDetailsRoute,
            arguments: {"courseId": course.id}),
      ),
    );
  }
}
