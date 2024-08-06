import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'dart:convert';

import 'package:kamerat_flutter_app/controllers/tutorail_player.controller.dart';
import 'package:kamerat_flutter_app/services/vimeo.service.dart';
import 'package:kamerat_flutter_app/utils/constants.dart';

class HomeworkVideoController extends GetxController {
  late TutorialPlayerController _tutorialPlayerController;
  String videoId = '';
  String tutorialName = '';
  String tutorialDescription = '';

  @override
  void onInit() {
    super.onInit();

    _tutorialPlayerController = TutorialPlayerController();
  }

  @override
  void onClose() {
    _tutorialPlayerController.onClose();
    super.onClose();
  }

  Future<void> getVideoFromVimeo() async {
    try {
      final response =
          await VimeoService().getVideoDetails(videoUri: '/videos/$videoId');

      final String videoUrl = _handleResponse(response);
      if (videoUrl.isEmpty) {
        throw Exception(
            'Video konnte nicht geladen werden. Bitte versuche es später noch einmal.');
      }

      await _tutorialPlayerController.initialize(videoUrl);
    } catch (e) {
      throw Exception(
          'Video konnte nicht geladen werden. Bitte versuche es später noch einmal.');
    }
  }

  String _handleResponse(http.Response response) {
    if (response.statusCode != kSuccessCode) {
      return '';
    }
    final data = jsonDecode(response.body);

    if (data.runtimeType.toString() == '_Map<String, dynamic>') {
      debugPrint(data.toString());
      tutorialName = data['name'] ?? '';
      tutorialDescription = data['description'] ?? '';
      var links = data['play']['progressive'] ?? [];
      if (links.isEmpty) {
        return '';
      }
      _tutorialPlayerController.addAvailableRenditions(links);
      _tutorialPlayerController.currentRendition.value =
          _tutorialPlayerController
              .availableRenditionsAndLinks.first['rendition']!;
      final link =
          _tutorialPlayerController.availableRenditionsAndLinks.first['link']!;
      if (link.isNotEmpty) {
        return link;
      }
    }
    return '';
  }

  TutorialPlayerController get tutorialPlayerController =>
      _tutorialPlayerController;
}
