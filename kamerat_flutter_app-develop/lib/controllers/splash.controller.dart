import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:kamerat_flutter_app/utils/constants.dart';

class SplashController extends GetxController
    with GetSingleTickerProviderStateMixin {
  AnimationController? animationController;
  Animation<Offset>? slideAnimation;
  Animation<double>? scaleAnimation;
  Animation<Offset>? moveAnimation;
  Animation<Offset>? moveTextAnimation;
  Animation<double>? opacityAnimation;

  AudioPlayer audioPlayer = AudioPlayer();

  RxBool showClickLogo = false.obs;

  final int _totalDuration = kTotalSplashDuration;
  final int _slideDuration = 300;
  final int _scaleDuration = 1800;

  final double _slideBegin = -3.0;
  final double _slideEnd = 0.5;

  final double _scaleBegin = 1.0;
  final double _scaleMiddle = 2.0;

  final double _logMoveEnd = -0.5;
  final double _textMoveStart = -0.3;

  final double _opacityBegin = 0.0;
  final double _opacityEnd = 1.0;

  @override
  void onInit() {
    super.onInit();
    final double slideEndDuration = _slideDuration / _totalDuration;
    final double scaleEndDuration = _scaleDuration / _totalDuration;
    final double clickStartDuration = 1000 / _totalDuration;
    final double clickEndDuration = 1200 / _totalDuration;

    animationController = AnimationController(
      duration: Duration(milliseconds: _totalDuration),
      vsync: this,
    );

    slideAnimation = Tween<Offset>(
      begin: Offset(0.0, _slideBegin),
      end: Offset(0.0, _slideEnd),
    ).animate(CurvedAnimation(
      parent: animationController!,
      curve: Interval(0, slideEndDuration, curve: Curves.easeInOut),
    ));

    scaleAnimation = TweenSequence([
      TweenSequenceItem(
          tween: Tween<double>(begin: _scaleBegin, end: _scaleMiddle),
          weight: 35),
      TweenSequenceItem(
          tween: Tween<double>(begin: _scaleMiddle, end: _scaleMiddle),
          weight: 30),
      TweenSequenceItem(
          tween: Tween<double>(begin: _scaleMiddle, end: _scaleBegin),
          weight: 35),
    ]).animate(CurvedAnimation(
      parent: animationController!,
      curve:
          Interval(slideEndDuration, scaleEndDuration, curve: Curves.easeInOut),
    ));

    moveAnimation =
        Tween<Offset>(begin: Offset.zero, end: Offset(0, _logMoveEnd)).animate(
            CurvedAnimation(
                parent: animationController!,
                curve: Interval(scaleEndDuration, 1.0, curve: Curves.easeOut)));

    moveTextAnimation =
        Tween<Offset>(begin: Offset(0, _textMoveStart), end: Offset.zero)
            .animate(CurvedAnimation(
                parent: animationController!,
                curve: Interval(scaleEndDuration, 1.0, curve: Curves.easeIn)));

    opacityAnimation = Tween<double>(begin: _opacityBegin, end: _opacityEnd)
        .animate(CurvedAnimation(
            parent: animationController!,
            curve: Interval(scaleEndDuration, 1.0, curve: Curves.easeIn)));

    scaleAnimation!.addListener(() {
      showClickLogo.value = animationController!.value > clickStartDuration &&
          animationController!.value <= clickEndDuration;
    });

    animationController!.addStatusListener(navigateToNext);

    animationController!.forward();
    playSound();
  }

  Future<void> playSound() async {
    await audioPlayer.play(AssetSource('audio/camera_flash.mp3'));
  }

  void navigateToNext(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      Get.offAllNamed(kMainRoute);
    }
  }

  @override
  void dispose() {
    animationController!.removeStatusListener(navigateToNext);
    animationController!.dispose();
    audioPlayer.dispose();
    super.dispose();
  }
}
