import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:kamerat_flutter_app/controllers/picture_of_month.controller.dart';
import 'package:kamerat_flutter_app/models/picture_of_month.dart';
import 'package:kamerat_flutter_app/utils/months_mapping.dart';
import 'package:kamerat_flutter_app/stores/user.store.dart';
import 'package:kamerat_flutter_app/utils/constants.dart';

class PictureOfMonthGallery extends GetView<POMController> {
  final List<POMModel> imageList;
  const PictureOfMonthGallery({super.key, required this.imageList});

  @override
  Widget build(BuildContext context) {
    final POMController controller = Get.put(POMController());
    controller.imageList = imageList;

    return CarouselSlider(
      options: CarouselOptions(
        enlargeCenterPage: true,
        reverse: true,
        viewportFraction: 0.7,
        clipBehavior: Clip.none,
        initialPage: 0,
      ),
      items: controller.imageList.map((image) {
        return PictureOfMonth(
          image: image,
          onLikeToggle: controller.onLikeToggle,
        );
      }).toList(),
    );
  }
}

class PictureOfMonth extends StatelessWidget {
  final POMModel image;

  final Function onLikeToggle;

  const PictureOfMonth(
      {super.key, required this.image, required this.onLikeToggle});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed(
        kZoomedImageRoute,
        arguments: {"image": image},
      ),
      child: Container(
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.05),
              offset: Offset(0, 3.433),
              blurRadius: 17.164,
              spreadRadius: 0,
            )
          ],
        ),
        child: Column(
          children: [
            Expanded(
              flex: 8,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(8.0),
                        topRight: Radius.circular(8.0)),
                    child: Image.network(
                      image.url,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      errorBuilder: (context, error, stackTrace) {
                        return Center(
                          child: Icon(
                            Icons.error,
                            color: Theme.of(context).colorScheme.error,
                          ),
                        );
                      },
                    ),
                  ),
                  if (UserStore().isLoggedIn)
                    Positioned(
                      top: 8,
                      right: 20,
                      child: GestureDetector(
                        onTap: () {
                          onLikeToggle(image);
                        },
                        child: Obx(
                          () => image.isLiked.value
                              ? Image.asset(
                                  "assets/icons/heart_fill.png",
                                  color: Theme.of(context).colorScheme.error,
                                )
                              : Image.asset(
                                  "assets/icons/heart.png",
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onPrimaryContainer,
                                ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(8.0),
                      bottomRight: Radius.circular(8.0)),
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.15),
                      offset: Offset(0, 0),
                      blurRadius: 4,
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: Text(
                  "${getMonthInGerman(image.month)} ${image.year}",
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
