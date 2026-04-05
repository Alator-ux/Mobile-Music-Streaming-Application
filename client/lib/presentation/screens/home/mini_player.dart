import 'package:client/main.dart';
import 'package:client/presentation/controllers/audio_player_controller.dart';
import 'package:client/presentation/screens/home/full_screen_player/full_screen_player.dart';
import 'package:client/presentation/widgets/play_pause_button.dart';
import 'package:flutter/material.dart';

class MiniPlayer extends StatelessWidget {
  const MiniPlayer({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = getIt<AudioPlayerController>();

    final theme = Theme.of(context);
    return ValueListenableBuilder(
      valueListenable: controller.currentTrackNotifier,
      builder: (context, value, child) {
        if (value == null) return const SizedBox.shrink();
        return InkWell(
          onTap: () {
            showModalBottomSheet(
              isScrollControlled: true,
              useSafeArea: true,
              context: context,
              builder: (context) => FullScreenPlayer(),
            );
          },
          child: SizedBox(
            height: 50,
            child: DecoratedBox(
              decoration: BoxDecoration(),
              child: Stack(
                alignment: .center,
                children: [
                  Row(
                    mainAxisAlignment: .spaceBetween,
                    children: [
                      ValueListenableBuilder(
                        valueListenable: controller.buttonNotifier,
                        builder: (context, value, child) {
                          return PlayPauseButton(
                            state: value,
                            onPlay: controller.play,
                            onPause: controller.pause,
                            size: 24,
                          );
                        },
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.favorite_outline),
                          ),
                          IconButton(
                            onPressed: controller.stop,
                            icon: Icon(Icons.close),
                          ),
                        ],
                      ),
                    ],
                  ),
                  IgnorePointer(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          value.title,
                          style: theme.textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(value.artist, style: theme.textTheme.bodySmall),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
