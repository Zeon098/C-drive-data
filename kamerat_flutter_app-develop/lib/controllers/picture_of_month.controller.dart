import 'package:get/get.dart';

import 'package:kamerat_flutter_app/services/picture_of_month.dart';
import 'package:kamerat_flutter_app/models/picture_of_month.dart';
import 'package:kamerat_flutter_app/utils/constants.dart';

class POMController extends GetxController {
  List<POMModel> imageList = <POMModel>[];
  bool isProcessing = false;

  Future<void> onLikeToggle(POMModel picture) async {
    if (isProcessing) return;
    isProcessing = true;
    final response = await POMService().toggleLike(picture);
    isProcessing = false;

    if (response.redirectRoute.isNotEmpty) {
      await Get.offAllNamed(response.redirectRoute);
      return;
    }

    if (response.code == kSuccessCode || response.code == kCreatedCode) {
      picture.isLiked.value = !picture.isLiked.value;
    }
  }
}
