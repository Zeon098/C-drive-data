import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:kamerat_flutter_app/controllers/homework_video.controller.dart';
import 'package:kamerat_flutter_app/components/tutorial_player.dart';
import 'package:kamerat_flutter_app/components/app_bar.dart';

class HomeworkVideo extends GetView<HomeworkVideoController> {
  final String videoId;
  const HomeworkVideo({super.key, required this.videoId});

  @override
  Widget build(BuildContext context) {
    HomeworkVideoController controller = Get.put(HomeworkVideoController());
    controller.videoId = videoId;
    return Scaffold(
      appBar: const MyAppBar(title: "Homework details"),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
        child: FutureBuilder(
          future: controller.getVideoFromVimeo(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(
                  '${snapshot.error}',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Theme.of(context).colorScheme.error),
                ),
              );
            }
            return ListView(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Tutorialplayer(
                      controller: controller.tutorialPlayerController),
                ),
                const SizedBox(height: 24.0),
                Text(
                  controller.tutorialName,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                ),
                const SizedBox(height: 20.0),
                Text(
                  controller.tutorialDescription,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
