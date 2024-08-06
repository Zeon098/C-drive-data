import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:kamerat_flutter_app/controllers/index.controller.dart';
import 'package:kamerat_flutter_app/components/bottom_nav.dart';

class MainScreen extends GetView<IndexController> {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    IndexController controller = Get.find<IndexController>();
    return Obx(
      () => Scaffold(
        appBar: controller.getCurrentAppBar(),
        body: controller.getCurrentScreen(),
        bottomNavigationBar:
            BottomNavBar(onTabChanged: controller.updateCurrentIndex),
      ),
    );
  }
}
