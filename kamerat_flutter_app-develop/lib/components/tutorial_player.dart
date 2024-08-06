import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:kamerat_flutter_app/controllers/tutorail_player.controller.dart';

class FullScreen extends StatelessWidget {
  final TutorialPlayerController controller;
  const FullScreen({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (didPop) {
        if (didPop) {
          controller.fullScreen.value = false;
        }
      },
      child: OrientationBuilder(builder: (context, orientation) {
        if (orientation == Orientation.portrait) {
          return RotatedBox(
            quarterTurns: 1,
            child: Tutorialplayer(controller: controller),
          );
        }
        return Tutorialplayer(controller: controller);
      }),
    );
  }
}

class Tutorialplayer extends StatelessWidget {
  final TutorialPlayerController controller;

  const Tutorialplayer({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => AspectRatio(
        aspectRatio: controller.videoPlayerController.value.value.aspectRatio,
        child: controller.reinitializing.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Stack(
                children: [
                  Center(
                    child: FittedBox(
                      child: SizedBox(
                        width: controller
                            .videoPlayerController.value.value.size.width,
                        height: controller
                            .videoPlayerController.value.value.size.height,
                        child: GestureDetector(
                          onTap: controller.toggleControls,
                          child: VideoPlayer(
                              controller.videoPlayerController.value),
                        ),
                      ),
                    ),
                  ),
                  if (!controller.hideControls.value &&
                      !controller.isEnded.value)
                    ForwardBackwadPlayPause(controller: controller),
                  if (controller.isEnded.value)
                    ReplayControl(controller: controller),
                  Controls(controller: controller),
                ],
              ),
      ),
    );
  }
}

class Controls extends StatelessWidget {
  final TutorialPlayerController controller;
  const Controls({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.hideControls.value
          ? Container()
          : Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: controller.fullScreen.value
                    ? const EdgeInsets.symmetric(
                        horizontal: 64.0, vertical: 8.0)
                    : const EdgeInsets.all(8.0),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 3.0,
                    horizontal: 4.0,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.onSurface,
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Obx(
                            () => Text(
                              controller.currentPosition.value,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    color:
                                        Theme.of(context).colorScheme.surface,
                                  ),
                            ),
                          ),
                          Text(
                            ' / ',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  color: Theme.of(context).colorScheme.surface,
                                ),
                          ),
                          Text(
                            controller.totalDuration.value,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  color: Theme.of(context).colorScheme.surface,
                                ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 8.0),
                      Expanded(
                        flex: 18,
                        child: ProgressIndicator(controller: controller),
                      ),
                      const SizedBox(width: 8.0),
                      Settings(controller: controller),
                      const SizedBox(width: 4.0),
                      ScreenControls(controller: controller),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}

class ReplayControl extends StatelessWidget {
  const ReplayControl({super.key, required this.controller});

  final TutorialPlayerController controller;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: IconButton(
        onPressed: controller.replay,
        icon: SizedBox(
          height: 24.0,
          width: 24.0,
          child: Image.asset("assets/icons/replay.png"),
        ),
        style: IconButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.onSurface,
        ),
      ),
    );
  }
}

class ForwardBackwadPlayPause extends StatelessWidget {
  const ForwardBackwadPlayPause({
    super.key,
    required this.controller,
  });

  final TutorialPlayerController controller;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: controller.goBackward,
            icon: SizedBox(
              height: 24.0,
              width: 24.0,
              child: Image.asset("assets/icons/backward.png"),
            ),
            style: IconButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          const SizedBox(width: 24.0),
          PlayPauseControls(controller: controller),
          const SizedBox(width: 24.0),
          IconButton(
            onPressed: controller.goForward,
            icon: SizedBox(
              height: 24.0,
              width: 24.0,
              child: Image.asset("assets/icons/forward.png"),
            ),
            style: IconButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}

class ProgressIndicator extends StatelessWidget {
  const ProgressIndicator({
    super.key,
    required this.controller,
  });

  final TutorialPlayerController controller;

  @override
  Widget build(BuildContext context) {
    return VideoProgressIndicator(
      controller.videoPlayerController.value,
      allowScrubbing: true,
      colors: VideoProgressColors(
        playedColor: Theme.of(context).colorScheme.primary,
        bufferedColor: Theme.of(context).colorScheme.onPrimary,
        backgroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
      ),
    );
  }
}

class Settings extends StatelessWidget {
  final TutorialPlayerController controller;

  const Settings({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          showMaterialModalBottomSheet(
            context: context,
            builder: (_) => SettingsModal(controller: controller),
          );
        },
        icon: SizedBox(
          height: 24.0,
          width: 24.0,
          child: Image.asset("assets/icons/settings.png"),
        ),
        style: IconButton.styleFrom(
          minimumSize: Size.zero,
          padding: EdgeInsets.zero,
          splashFactory: NoSplash.splashFactory,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ));
  }
}

class SettingsModal extends StatelessWidget {
  final TutorialPlayerController controller;

  const SettingsModal({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        listTileTheme: const ListTileThemeData(
          contentPadding: EdgeInsets.all(0.0),
          shape: null,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          borderRadius: BorderRadius.circular(8.0),
        ),
        padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 32.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Text(
                "Wiedergabegeschwindigkeit",
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
              ),
              trailing: Obx(
                () => DropdownButton<String>(
                  value: controller.currentPlayBackSpeed.value,
                  dropdownColor: Theme.of(context).colorScheme.surface,
                  elevation: 0,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                  underline: const SizedBox.shrink(),
                  icon: Icon(
                    Icons.keyboard_arrow_down,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  onChanged: (String? newSpeed) {
                    if (newSpeed != null) {
                      controller.changePlayBackSpeed(newSpeed);
                      Get.back();
                    }
                  },
                  items: controller.playBackSpeeds.map(
                    (speed) {
                      return DropdownMenuItem<String>(
                        value: speed,
                        child: Text('${speed}x'),
                      );
                    },
                  ).toList(),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            ListTile(
              title: Text(
                "Videoqualität",
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
              ),
              trailing: Obx(
                () => DropdownButton<String>(
                  value: controller.currentRendition.value,
                  dropdownColor: Theme.of(context).colorScheme.surface,
                  elevation: 0,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                  underline: const SizedBox.shrink(),
                  icon: Icon(
                    Icons.keyboard_arrow_down,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  onChanged: (String? newRendition) {
                    if (newRendition != null) {
                      controller.changeCurrentRendition(newRendition);
                      Get.back();
                    }
                  },
                  items: controller.availableRenditionsAndLinks.map(
                    (rendition) {
                      return DropdownMenuItem<String>(
                        value: rendition['rendition']!,
                        child: Text(rendition['rendition']!),
                      );
                    },
                  ).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ScreenControls extends StatelessWidget {
  final TutorialPlayerController controller;

  const ScreenControls({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: controller.toggleFullScreen,
      icon: Obx(
        () => controller.fullScreen.value
            ? SizedBox(
                height: 20.0,
                width: 20.0,
                child: Image.asset("assets/icons/exit_full_screen.png"),
              )
            : SizedBox(
                height: 20.0,
                width: 20.0,
                child: Image.asset("assets/icons/full_screen.png"),
              ),
      ),
      style: IconButton.styleFrom(
        minimumSize: Size.zero,
        padding: EdgeInsets.zero,
        splashFactory: NoSplash.splashFactory,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
    );
  }
}

class PlayPauseControls extends StatelessWidget {
  final TutorialPlayerController controller;

  const PlayPauseControls({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: controller.playPause,
      icon: Obx(
        () => controller.isPlaying.value
            ? const Icon(
                Icons.pause,
                size: 32.0,
                color: Colors.white,
              )
            : const Icon(
                Icons.play_arrow_rounded,
                size: 32.0,
                color: Colors.white,
              ),
      ),
      style: IconButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.onSurface,
      ),
    );
  }
}
