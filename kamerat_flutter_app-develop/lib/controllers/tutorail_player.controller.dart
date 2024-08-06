import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:get/get.dart';
import 'dart:async';

import 'package:kamerat_flutter_app/components/tutorial_player.dart';

class TutorialPlayerController extends GetxController {
  bool hasStarted = false;
  bool statusChanged = false;
  bool isInitialized = false;

  final isPlaying = false.obs;
  final hideControls = false.obs;
  final isEnded = false.obs;
  final isMuted = false.obs;
  final fullScreen = false.obs;

  final reinitializing = false.obs;

  RxString totalDuration = ''.obs;
  RxString currentPosition = '00:00'.obs;

  late Rx<VideoPlayerController> videoPlayerController;
  late Function events;

  RxString currentRendition = ''.obs;
  List<Map<String, String>> availableRenditionsAndLinks = [];
  RxString currentPlayBackSpeed = ''.obs;
  List<String> playBackSpeeds = [
    "0.25",
    "0.50",
    "0.75",
    "1.0",
    "1.25",
    "1.50",
    "1.75",
    "2.0",
  ];

  Timer? _hideControlTimer;

  @override
  void onClose() async {
    if (isInitialized) {
      await videoPlayerController.value.dispose();
    }
    super.onClose();
  }

  Future<void> initialize(videoUrl) async {
    videoPlayerController =
        VideoPlayerController.networkUrl(Uri.parse(videoUrl)).obs;
    currentPlayBackSpeed.value =
        videoPlayerController.value.value.playbackSpeed.toString();
    await videoPlayerController.value.initialize();
    isInitialized = true;
    extractTotalDuration();
  }

  void addListeners(Function callBack) {
    events = callBack;
    videoPlayerController.value.addListener(() {
      currentPosition.value =
          formatDuration(videoPlayerController.value.value.position);
      callBack();
    });
  }

  void _startHideControlTimer() {
    _hideControlTimer?.cancel();

    _hideControlTimer = Timer(const Duration(seconds: 5), () {
      debugPrint("I'm hiding controls");
      hideControls.value = true;
    });
  }

  void playPause() async {
    if (videoPlayerController.value.value.isPlaying) {
      await videoPlayerController.value.pause();
      isPlaying.value = false;
      _hideControlTimer?.cancel();
    } else {
      await videoPlayerController.value.play();
      hideControls.value = false;
      isPlaying.value = true;
      _startHideControlTimer();
    }
  }

  void replay() async {
    await videoPlayerController.value.seekTo(Duration.zero);
    await videoPlayerController.value.play();
    hideControls.value = false;
    isEnded.value = false;
    isPlaying.value = true;
    _startHideControlTimer();
  }

  void toggleControls() {
    hideControls.value = !hideControls.value;

    if (!hideControls.value) {
      _startHideControlTimer();
    } else {
      _hideControlTimer?.cancel();
    }
  }

  void muteUnmute() {
    if (videoPlayerController.value.value.volume == 0) {
      videoPlayerController.value.setVolume(1);
      isMuted.value = false;
    } else {
      videoPlayerController.value.setVolume(0);
      isMuted.value = true;
    }
  }

  void goForward() {
    videoPlayerController.value.seekTo(
      videoPlayerController.value.value.position + const Duration(seconds: 10),
    );
  }

  void goBackward() {
    videoPlayerController.value.seekTo(
      videoPlayerController.value.value.position - const Duration(seconds: 10),
    );
  }

  void toggleFullScreen() {
    if (fullScreen.value) {
      Get.back();
    } else if (!fullScreen.value) {
      fullScreen.value = true;
      Get.to(() => FullScreen(controller: this));
    }
  }

  void changePlayBackSpeed(String speed) {
    videoPlayerController.value.setPlaybackSpeed(double.parse(speed));
    currentPlayBackSpeed.value = speed;
  }

  void addAvailableRenditions(var links) {
    availableRenditionsAndLinks = [];
    for (var link in links) {
      availableRenditionsAndLinks
          .add({'rendition': link['rendition'], 'link': link['link']});
    }
    availableRenditionsAndLinks.sort((a, b) {
      return int.parse(b['rendition']!.replaceFirst('p', '')) -
          int.parse(a['rendition']!.replaceFirst('p', ''));
    });
  }

  void changeCurrentRendition(String rendition) async {
    currentRendition.value = rendition;
    final videoUrl = findCurrentResolutionLink();

    reinitializing.value = true;
    hideControls.value = false;
    await _reinitializePlayer(videoUrl);
    reinitializing.value = false;
  }

  Future<void> _reinitializePlayer(String videoUrl) async {
    final currentPosition = await videoPlayerController.value.position;
    await videoPlayerController.value.dispose();
    videoPlayerController.value =
        VideoPlayerController.networkUrl(Uri.parse(videoUrl));
    await videoPlayerController.value.initialize();
    if (isPlaying.value) {
      await videoPlayerController.value.play();
    }
    await videoPlayerController.value.seekTo(currentPosition!);
    videoPlayerController.value.addListener(() => events);
    extractTotalDuration();
  }

  String findCurrentResolutionLink() {
    if (currentRendition.value.isNotEmpty) {
      return availableRenditionsAndLinks
          .where(
              (rendition) => rendition['rendition'] == currentRendition.value)
          .first['link']!;
    }
    currentRendition.value = availableRenditionsAndLinks.first['rendition']!;
    return availableRenditionsAndLinks.first['link']!;
  }

  void extractTotalDuration() {
    totalDuration.value =
        formatDuration(videoPlayerController.value.value.duration);
  }

  String formatDuration(Duration duration) {
    int twoDigitsHours = duration.inHours;
    int twoDigitsMinutes = duration.inMinutes.remainder(60);
    int twoDigitsSeconds = duration.inSeconds.remainder(60);

    String formattedDuration = '';

    if (twoDigitsHours != 0) {
      formattedDuration += "$twoDigitsHours:";
    }
    if (twoDigitsMinutes <= 9) {
      formattedDuration += '0$twoDigitsMinutes:';
    } else {
      formattedDuration += '$twoDigitsMinutes:';
    }

    if (twoDigitsSeconds <= 9) {
      formattedDuration += '0$twoDigitsSeconds';
    } else {
      formattedDuration += '$twoDigitsSeconds';
    }

    return formattedDuration;
  }
}
