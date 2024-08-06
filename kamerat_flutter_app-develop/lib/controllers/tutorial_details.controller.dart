import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'dart:convert';

import 'package:kamerat_flutter_app/controllers/tutorail_player.controller.dart';
import 'package:kamerat_flutter_app/stores/course_progress.store.dart';
import 'package:kamerat_flutter_app/services/learning.service.dart';
import 'package:kamerat_flutter_app/services/vimeo.service.dart';
import 'package:kamerat_flutter_app/models/tutorial.model.dart';
import 'package:kamerat_flutter_app/utils/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class TutorialDetailsController extends GetxController {
  TutorialModel tutorial = TutorialModel.empty();

  late TutorialPlayerController _tutorialPlayerController;

  final tutorialStatus = ''.obs;

  final isCardExpanded = false.obs;
  final showHomeWorkText = false.obs;
  final showHomeWorkVideos = false.obs;

  @override
  void onInit() {
    super.onInit();

    _tutorialPlayerController = TutorialPlayerController();
    tutorial = Get.arguments['tutorial'] as TutorialModel;
    tutorialStatus.value = CourseProgressStore().getTutorialStatus(tutorial.id);
  }

  @override
  void onClose() {
    _tutorialPlayerController.onClose();
    super.onClose();
  }

  Future<void> getVideoFromVimeo() async {
    try {
      final response =
          await VimeoService().getVideoDetails(videoUri: tutorial.videoUri);

      final String videoUrl = _handleResponse(response);

      if (videoUrl.isEmpty) {
        throw Exception(
            'Video konnte nicht geladen werden. Bitte versuche es später noch einmal.');
      }

      await _tutorialPlayerController.initialize(videoUrl);
      _addListenerToPlayer();
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

  void _addListenerToPlayer() {
    _tutorialPlayerController.addListeners(() {
      if (tutorialStatus.value.isEmpty) {
        _updateTutorialStatusToInProgress();
      }
      if (_tutorialPlayerController
          .videoPlayerController.value.value.isCompleted) {
        _updateTutorialStatusToCompleted();
      }
    });
  }

  Future<void> _updateTutorialStatusToInProgress() async {
    final response = await LearningService().upsertCourseSubscription(
      courseId: tutorial.courseId,
      seasonId: tutorial.seasonId,
      tutorialId: tutorial.id,
      event: "start",
    );

    if (response.redirectRoute.isNotEmpty) {
      await Get.offAllNamed(response.redirectRoute);
      return;
    }

    tutorialStatus.value = "inProgress";
  }

  Future<void> _updateTutorialStatusToCompleted() async {
    _tutorialPlayerController.isEnded.value = true;
    _tutorialPlayerController.hideControls.value = true;
    final response = await LearningService().upsertCourseSubscription(
      courseId: tutorial.courseId,
      seasonId: tutorial.seasonId,
      tutorialId: tutorial.id,
      event: "end",
    );

    if (response.redirectRoute.isNotEmpty) {
      await Get.offAllNamed(response.redirectRoute);
      return;
    }

    tutorialStatus.value = "completed";
  }

  void toggleHomeWorkCardExpansion() {
    isCardExpanded.value = !isCardExpanded.value;
    if (isCardExpanded.value == false) {
      showHomeWorkVideos.value = !showHomeWorkVideos.value;
      showHomeWorkText.value = !showHomeWorkText.value;
    }
  }

  TutorialPlayerController get tutorialPlayerController =>
      _tutorialPlayerController;

  bool get hasHomeWork =>
      tutorial.homeworkVideoLink.isNotEmpty ||
      tutorial.homeworkImageUrl.isNotEmpty ||
      tutorial.homeworkfileUrl.isNotEmpty ||
      tutorial.homeworkText.isNotEmpty;

  List<String> get homeWorkVideoLink => tutorial.homeworkVideoLink;
  String get homeWorkImageUrl => tutorial.homeWorkImageUrl;
  String get homeWorkFileUrl => tutorial.homeWorkFileUrl;
  String get homeWorkText => tutorial.homeworkText;

  Future<void> openHomeWorkFile() async {
    final url = Uri.parse(homeWorkFileUrl);

    try {
      await launchUrl(url);
    } catch (e) {
      Get.snackbar('Fehler', 'Failed to open file');
    }
  }
}
