import 'package:client/data/models/track.dart';
import 'package:client/presentation/screens/home/track_widget.dart';
import 'package:flutter/material.dart';

class TrackList extends StatelessWidget {
  final List<Track> tracks;

  const TrackList({super.key, required this.tracks});

  @override
  Widget build(BuildContext context) {
    if (tracks.isEmpty) {
      return const Center(child: Text("Список пуст"));
    }
    return ListView.separated(
      itemBuilder: (BuildContext context, int index) {
        return TrackWidget(
          track: tracks[index],
          playlist: tracks,
          index: index,
        );
      },
      separatorBuilder: (BuildContext context, int index) =>
          const SizedBox(height: 5),
      itemCount: tracks.length,
    );
  }
}
