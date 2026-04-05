import 'package:client/main.dart';
import 'package:client/presentation/controllers/audio_player_controller.dart';
import 'package:flutter/material.dart';

class TrackInfo extends StatelessWidget {
  const TrackInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final controller = getIt<AudioPlayerController>();

    return ValueListenableBuilder(
      valueListenable: controller.currentTrackNotifier,
      builder: (context, value, child) {
        return Row(
          mainAxisAlignment: .spaceBetween,
          children: [
            Column(
              crossAxisAlignment: .start,
              children: [
                Text(value!.title, style: theme.textTheme.headlineMedium),
                Text(value.artist, style: theme.textTheme.titleMedium),
              ],
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.favorite_outline),
                ),
                IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)),
              ],
            ),
          ],
        );
      },
    );
  }
}
