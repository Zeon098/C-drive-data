import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TabBarController extends GetxController
    with GetSingleTickerProviderStateMixin {
  RxInt tabIndex = 0.obs;
  late TabController tabController;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(_updateIndex);
  }

  @override
  void onClose() {
    tabController.removeListener(update);
    tabController.dispose();
    super.onClose();
  }

  void _updateIndex() {
    if (tabController.index == 0) {
      tabIndex.value = 0;
    } else {
      tabIndex.value = 1;
    }
  }
}
