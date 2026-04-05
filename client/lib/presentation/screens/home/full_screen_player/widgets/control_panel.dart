import 'package:client/main.dart';
import 'package:client/presentation/controllers/audio_player_controller.dart';
import 'package:client/presentation/widgets/play_pause_button.dart';
import 'package:flutter/material.dart';

class ControlPanel extends StatelessWidget {
  const ControlPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = getIt<AudioPlayerController>();

    return Row(
      mainAxisAlignment: .spaceBetween,
      children: [
        IconButton(onPressed: () {}, icon: Icon(Icons.shuffle)),
        Row(
          children: [
            IconButton(
              onPressed: controller.previous,
              icon: Icon(Icons.skip_previous, size: 48),
            ),
            ValueListenableBuilder(
              valueListenable: controller.buttonNotifier,
              builder: (context, value, child) {
                return PlayPauseButton(
                  state: value,
                  onPlay: controller.play,
                  onPause: controller.pause,
                );
              },
            ),
            IconButton(
              onPressed: controller.next,
              icon: Icon(Icons.skip_next, size: 48),
            ),
          ],
        ),
        IconButton(onPressed: () {}, icon: Icon(Icons.loop)),
      ],
    );
  }
}
