import 'package:client/main.dart';
import 'package:client/presentation/controllers/audio_player_controller.dart';
import 'package:flutter/material.dart';

class AlbumArt extends StatelessWidget {
  const AlbumArt({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = getIt<AudioPlayerController>();
    return ValueListenableBuilder(
      valueListenable: controller.currentTrackNotifier,
      builder: (context, value, child) {
        return AspectRatio(
          aspectRatio: 1,
          child: ClipRRect(
            borderRadius: .circular(15),
            child: Image.network(value!.coverUrl, fit: .cover),
          ),
        );
      },
    );
  }
}
