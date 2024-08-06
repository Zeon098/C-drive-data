import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

import 'package:kamerat_flutter_app/controllers/likes.controller.dart';
import 'package:kamerat_flutter_app/models/picture_of_month.dart';
import 'package:kamerat_flutter_app/utils/constants.dart';

class Likes extends GetView<LikesController> {
  const Likes({super.key});

  @override
  Widget build(BuildContext context) {
    LikesController controller = Get.put(LikesController());
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
      child: FutureBuilder(
        future: controller.getLikedPictures(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
              child: Text(
                "${snapshot.error}",
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.error,
                    ),
              ),
            );
          }
          if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            final List<POMModel> images = snapshot.data as List<POMModel>;
            return ListView.builder(
              itemCount: images.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: LikedImageCard(image: images[index]),
                );
              },
            );
          }
          return Center(
            child: Text(
              "Keine Bilder gelikt",
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
          );
        },
      ),
    );
  }
}

class LikedImageCard extends StatelessWidget {
  final POMModel image;

  const LikedImageCard({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed(
        kZoomedImageRoute,
        arguments: {"image": image},
      ),
      child: Stack(children: [
        AspectRatio(
            aspectRatio: 2,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                image.url,
                fit: BoxFit.cover,
              ),
            )),
        Positioned(
          bottom: 16.0,
          left: 16.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                toBeginningOfSentenceCase(image.authorName),
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
              ),
              Text(
                toBeginningOfSentenceCase("${image.month} ${image.year}"),
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    fontWeight: FontWeight.w500,
                    color: const Color.fromRGBO(230, 236, 232, 1)),
              )
            ],
          ),
        ),
        Positioned(
            top: 16.0,
            right: 16.0,
            child: Column(children: [
              Image.asset("assets/icons/heart_fill.png",
                  color: const Color.fromRGBO(229, 76, 71, 1)),
              const SizedBox(height: 4.0),
              Text(
                "${image.noOfLikes} likes",
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    fontWeight: FontWeight.w500,
                    color: const Color.fromRGBO(230, 236, 232, 1)),
              )
            ])),
      ]),
    );
  }
}
