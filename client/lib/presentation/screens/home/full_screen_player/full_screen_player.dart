import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:client/presentation/screens/home/full_screen_player/widgets/album_art.dart';
import 'package:client/presentation/screens/home/full_screen_player/widgets/control_panel.dart';
import 'package:client/presentation/screens/home/full_screen_player/widgets/player_header.dart';
import 'package:client/presentation/screens/home/full_screen_player/widgets/track_info.dart';
import 'package:flutter/material.dart';

class FullScreenPlayer extends StatelessWidget {
  const FullScreenPlayer({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const .all(8.0),
      child: Column(
        children: [
          PlayerHeader(),
          Padding(padding: const .only(top: 8.0), child: AlbumArt()),
          Spacer(),
          TrackInfo(),
          Spacer(),
          ProgressBar(
            progress: Duration(seconds: 30),
            total: Duration(minutes: 2),
            progressBarColor: theme.colorScheme.primary,
            baseBarColor: theme.colorScheme.primary.withValues(alpha: 0.2),
            thumbColor: theme.colorScheme.primary,
            timeLabelTextStyle: theme.textTheme.bodySmall,
          ),
          Spacer(),
          ControlPanel(),
          Spacer(),
        ],
      ),
    );
  }
}
