import 'package:get/get.dart';
import 'dart:async';

class ServiceDownController extends GetxController {
  RxBool changeImage = false.obs;
  late Timer timer;

  @override
  void onInit() {
    super.onInit();
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      changeImage.value = !changeImage.value;
    });
  }

  @override
  void onClose() {
    timer.cancel();
    super.onClose();
  }
}
