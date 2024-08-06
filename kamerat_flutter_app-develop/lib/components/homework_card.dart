import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:kamerat_flutter_app/controllers/tutorial_details.controller.dart';
import 'package:kamerat_flutter_app/components/homework_image.dart';
import 'package:kamerat_flutter_app/components/homework_video.dart';

class HomeWorkCard extends StatelessWidget {
  final TutorialDetailsController controller;

  const HomeWorkCard({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: controller.toggleHomeWorkCardExpansion,
      child: Card(
        clipBehavior: Clip.none,
        surfaceTintColor: Theme.of(context).colorScheme.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
          side: const BorderSide(
            color: Color.fromRGBO(230, 236, 232, 1),
            width: 1.0,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 20.0,
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Hausaufgaben",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).colorScheme.tertiary,
                        ),
                  ),
                  Obx(
                    () => Icon(
                      controller.isCardExpanded.value
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                      size: 24.0,
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                  ),
                ],
              ),
              Obx(
                () => controller.isCardExpanded.value
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Divider(
                            color: Color.fromRGBO(230, 236, 232, 1),
                          ),
                          const SizedBox(height: 16.0),
                          if (controller.homeWorkVideoLink.isNotEmpty)
                            GestureDetector(
                              onTap: () => controller.showHomeWorkVideos.value =
                                  !controller.showHomeWorkVideos.value,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    "assets/icons/play.png",
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    width: 18,
                                    height: 18,
                                  ),
                                  const SizedBox(width: 8.0),
                                  Expanded(
                                    child: Text(
                                      "Video",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                            fontWeight: FontWeight.w500,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .tertiary,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          Obx(
                            () => controller.showHomeWorkVideos.value
                                ? const SizedBox(height: 8.0)
                                : const SizedBox.shrink(),
                          ),
                          Obx(
                            () => controller.showHomeWorkVideos.value
                                ? Padding(
                                    padding: const EdgeInsets.only(left: 24.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: controller.homeWorkVideoLink
                                          .map(
                                            (video) => TextButton(
                                              style: TextButton.styleFrom(
                                                padding: const EdgeInsets.only(
                                                  bottom: 8.0,
                                                ),
                                                minimumSize: Size.zero,
                                                splashFactory:
                                                    NoSplash.splashFactory,
                                                tapTargetSize:
                                                    MaterialTapTargetSize
                                                        .shrinkWrap,
                                              ),
                                              onPressed: () => Get.to(
                                                () => HomeworkVideo(
                                                  videoId: video,
                                                ),
                                              ),
                                              child: Text(
                                                'Video ${controller.homeWorkVideoLink.indexOf(video) + 1}',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall!
                                                    .copyWith(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .tertiary,
                                                    ),
                                              ),
                                            ),
                                          )
                                          .toList(),
                                    ),
                                  )
                                : const SizedBox.shrink(),
                          ),
                          if (controller.homeWorkImageUrl.isNotEmpty)
                            const SizedBox(height: 16.0),
                          if (controller.homeWorkFileUrl.isNotEmpty)
                            GestureDetector(
                              onTap: controller.openHomeWorkFile,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset("assets/icons/homework.png"),
                                  const SizedBox(width: 8.0),
                                  Expanded(
                                    child: Text(
                                      "Datei",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                            fontWeight: FontWeight.w500,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .tertiary,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          if (controller.homeWorkFileUrl.isNotEmpty)
                            const SizedBox(height: 16.0),
                          if (controller.homeWorkImageUrl.isNotEmpty)
                            GestureDetector(
                              onTap: () => Get.to(
                                () => HomeWorkImage(
                                  tutorialTitle:
                                      controller.tutorial.tutorialName,
                                  imageUrl: controller.homeWorkImageUrl,
                                ),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset("assets/icons/hausa.png"),
                                  const SizedBox(width: 8.0),
                                  Expanded(
                                    child: Text(
                                      "Bilder",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                            fontWeight: FontWeight.w500,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .tertiary,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          if (controller.homeWorkImageUrl.isNotEmpty)
                            const SizedBox(height: 16.0),
                          if (controller.homeWorkText.isNotEmpty)
                            GestureDetector(
                              onTap: () => controller.showHomeWorkText.value =
                                  !controller.showHomeWorkText.value,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset("assets/icons/tipps.png"),
                                  const SizedBox(width: 8.0),
                                  Expanded(
                                    child: Text(
                                      "Text",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                            fontWeight: FontWeight.w500,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .tertiary,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          Obx(
                            () => controller.showHomeWorkText.value
                                ? const SizedBox(height: 8.0)
                                : const SizedBox.shrink(),
                          ),
                          Obx(
                            () => controller.showHomeWorkText.value
                                ? Text(controller.tutorial.homeworkText)
                                : const SizedBox.shrink(),
                          )
                        ],
                      )
                    : Container(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
