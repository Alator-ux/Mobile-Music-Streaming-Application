import 'package:client/presentation/controllers/audio_player_controller.dart';
import 'package:flutter/material.dart';

class PlayPauseButton extends StatelessWidget {
  final ButtonState state;
  final VoidCallback onPlay;
  final VoidCallback onPause;
  final double size;

  const PlayPauseButton({
    super.key,
    required this.state,
    required this.onPlay,
    required this.onPause,
    this.size = 64,
  });

  @override
  Widget build(BuildContext context) {
    switch (state) {
      case ButtonState.loading:
        return Container(
          margin: const EdgeInsets.all(8.0),
          width: size,
          height: size,
          child: const CircularProgressIndicator(),
        );
      case ButtonState.paused:
        return IconButton(
          icon: const Icon(Icons.play_arrow),
          iconSize: size,
          onPressed: onPlay,
        );
      case ButtonState.playing:
        return IconButton(
          icon: const Icon(Icons.pause),
          iconSize: size,
          onPressed: onPause,
        );
    }
  }
}
