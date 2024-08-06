import 'package:flutter_file_dialog/flutter_file_dialog.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'dart:io';

import 'package:kamerat_flutter_app/services/picture_of_month.dart';
import 'package:kamerat_flutter_app/models/picture_of_month.dart';
import 'package:kamerat_flutter_app/utils/constants.dart';

class LikesController extends GetxController {
  Future<List<POMModel>> getLikedPictures() async {
    final response = await POMService().getLikedPictures();

    if (response.redirectRoute.isNotEmpty) {
      await Get.offAllNamed(response.redirectRoute);
      return [];
    }

    if (response.code == kSuccessCode) {
      final List<POMModel> pictures = [];
      for (final picture in response.data) {
        pictures.add(POMModel.fromJson(picture));
      }
      return pictures;
    } else {
      throw Exception(
          "Bilder konnten nicht geladen werden. Bitte versuche es später noch einmal.");
    }
  }
}

class ZoomedImageController extends GetxController {
  final RxBool isZoomed = false.obs;

  void toggleZoom() {
    isZoomed.value = !isZoomed.value;
  }

  void downloadImage(String url, String fileName) async {
    Directory directory = await getTemporaryDirectory();
    String? filePath = '${directory.path}/$fileName.jpg';
    http.Response response = await http.get(Uri.parse(url));
    File file = File(filePath);

    await file.writeAsBytes(response.bodyBytes);

    final params = SaveFileDialogParams(sourceFilePath: filePath);
    filePath = await FlutterFileDialog.saveFile(params: params);
    if (filePath == null) {
      Get.snackbar(
        "Fehler",
        "Herunterladen des Bildes fehlgeschlagen.",
        duration: const Duration(seconds: 3),
      );
    } else {
      Get.snackbar(
        "Erfolg",
        "Image downloaded Erfolgfully.",
        duration: const Duration(seconds: 3),
      );
    }
  }
}
