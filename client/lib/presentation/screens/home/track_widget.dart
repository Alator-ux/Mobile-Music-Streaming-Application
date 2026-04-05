import 'package:client/data/models/track.dart';
import 'package:client/main.dart';
import 'package:client/presentation/controllers/audio_player_controller.dart';
import 'package:client/utils/duration_formatter.dart';
import 'package:flutter/material.dart';

class TrackWidget extends StatelessWidget {
  final Track track;
  final int index;
  final List<Track> playlist;

  const TrackWidget({
    super.key,
    required this.track,
    required this.playlist,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final controller = getIt<AudioPlayerController>();
    return ListTile(
      contentPadding: const .only(left: 5),
      title: Text(
        track.title,
        style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
        overflow: .ellipsis,
      ),
      subtitle: Text(
        track.artist,
        style: theme.textTheme.bodyMedium,
        overflow: .ellipsis,
      ),
      leading: AspectRatio(
        aspectRatio: 1,
        child: ClipRRect(
          borderRadius: .circular(4),
          child: Image.network(
            track.coverUrl,
            fit: .cover,
            errorBuilder: (_, _, _) {
              return const Icon(Icons.music_note);
            },
          ),
        ),
      ),
      trailing: Row(
        mainAxisSize: .min,
        children: [
          Text(formatDuration(Duration(seconds: track.duration))),
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
        ],
      ),
      onTap: () {
        controller.playSpecificTrack(playlist, index);
      },
    );
  }
}
