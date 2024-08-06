import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:kamerat_flutter_app/controllers/splash.controller.dart';

class Splash extends GetView<SplashController> {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(
        init: SplashController(),
        builder: (controller) {
          return Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SlideTransition(
                  position: controller.slideAnimation!,
                  child: ScaleTransition(
                    scale: controller.scaleAnimation!,
                    child: SlideTransition(
                      position: controller.moveAnimation!,
                      child: Obx(
                        () => controller.showClickLogo.value
                            ? Image.asset("assets/icons/logo_click.png")
                            : Image.asset("assets/icons/logo.png"),
                      ),
                    ),
                  ),
                ),
                FadeTransition(
                    opacity: controller.opacityAnimation!,
                    child: SlideTransition(
                        position: controller.moveTextAnimation!,
                        child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "KAME",
                                style: TextStyle(
                                  fontSize: 48.0,
                                  height: 1.7,
                                  fontFamily: "Impact",
                                  color: Color.fromRGBO(3, 27, 12, 1),
                                  decoration: TextDecoration.none,
                                ),
                              ),
                              Text(
                                "RAT",
                                style: TextStyle(
                                  fontSize: 48.0,
                                  height: 1.7,
                                  fontFamily: "Impact",
                                  color: Color.fromRGBO(19, 154, 67, 1),
                                  decoration: TextDecoration.none,
                                ),
                              ),
                            ]))),
              ],
            ),
          );
        });
  }
}
