import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:kamerat_flutter_app/controllers/tutorial_details.controller.dart';
import 'package:kamerat_flutter_app/components/tutorial_player.dart';
import 'package:kamerat_flutter_app/components/homework_card.dart';
import 'package:kamerat_flutter_app/components/progress_bar.dart';
import 'package:kamerat_flutter_app/utils/format_duration.dart';
import 'package:kamerat_flutter_app/components/app_bar.dart';
import 'package:kamerat_flutter_app/utils/constants.dart';

class TutorialDetails extends GetView<TutorialDetailsController> {
  const TutorialDetails({super.key});

  @override
  Widget build(BuildContext context) {
    TutorialDetailsController controller =
        Get.find<TutorialDetailsController>();
    return Scaffold(
      appBar: const MyAppBar(title: "Videodetails"),
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
                  controller.tutorial.tutorialName,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  formatDuration(controller.tutorial.videoDuration),
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                ),
                const SizedBox(height: 4.0),
                Obx(() {
                  if (controller.tutorialStatus.value.isEmpty) {
                    return Container();
                  }
                  if (controller.tutorialStatus.value ==
                      COURSEPROGRESS.inprogress.value) {
                    return const LinearProgressBar(percentage: 0.5);
                  }
                  return const LinearProgressBar(percentage: 1);
                }),
                const SizedBox(height: 20.0),
                Text(
                  controller.tutorial.tutorialDescription,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                ),
                const SizedBox(height: 24.0),
                if (controller.hasHomeWork)
                  HomeWorkCard(controller: controller),
              ],
            );
          },
        ),
      ),
    );
  }
}
