import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

import 'package:kamerat_flutter_app/controllers/likes.controller.dart';
import 'package:kamerat_flutter_app/models/picture_of_month.dart';

class ZoomedImage extends GetView<ZoomedImageController> {
  const ZoomedImage({super.key});

  @override
  Widget build(BuildContext context) {
    ZoomedImageController controller = Get.find<ZoomedImageController>();
    POMModel image = Get.arguments["image"] as POMModel;
    return Obx(
      () => Scaffold(
        body: Stack(
          children: [
            SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: InteractiveViewer(
                onInteractionStart: (details) {
                  controller.isZoomed.value = true;
                },
                child: GestureDetector(
                  onTap: controller.toggleZoom,
                  child: Image.network(
                    image.url,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            controller.isZoomed.value
                ? Container()
                : Positioned(
                    top: 0,
                    right: 0,
                    left: 0,
                    child: AppBar(
                      leading: GestureDetector(
                        onTap: Get.back,
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: Theme.of(context).colorScheme.tertiary,
                        ),
                      ),
                      actions: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Row(
                            children: [
                              Image.asset("assets/icons/heart.png",
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground),
                              const SizedBox(width: 8.0),
                              Text(
                                "${image.noOfLikes} likes",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                      fontWeight: FontWeight.w500,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onBackground,
                                    ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
          ],
        ),
        bottomSheet: !controller.isZoomed.value
            ? Container(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      toBeginningOfSentenceCase(image.authorName),
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      toBeginningOfSentenceCase("${image.month} ${image.year}"),
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).colorScheme.onBackground),
                    ),
                  ],
                ),
              )
            : const SizedBox(),
      ),
    );
  }
}
