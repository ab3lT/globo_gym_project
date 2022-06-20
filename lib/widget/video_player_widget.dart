// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:globo_gym/model/exercise.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatefulWidget {
  final Exercise exercise;
  final VoidCallback onInitialized;

  VideoPlayerWidget({
    Key? key,
    required this.exercise,
    required this.onInitialized,
  }) : super(key: key);

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController controller;

  @override
  void initState() {
    super.initState();
    controller = VideoPlayerController.asset(widget.exercise.videoUrl)
      ..initialize().then((value) {
        controller.setLooping(true);
        controller.play();

        widget.exercise.controller = controller;
        widget.onInitialized();
      });
  }

  @override
  Widget build(BuildContext context) => SizedBox.expand(
        child: controller.value.isInitialized
            ? VideoPlayer(controller)
            : Center(child: CircularProgressIndicator()),
      );
}
