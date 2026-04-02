import 'package:client/presentation/screens/home/track_widget.dart';
import 'package:flutter/material.dart';

class TrackList extends StatefulWidget {
  const TrackList({super.key});

  @override
  State<TrackList> createState() => _TrackListState();
}

class _TrackListState extends State<TrackList> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (BuildContext context, int index) {
        return TrackWidget();
      },
      separatorBuilder: (BuildContext context, int index) =>
          const SizedBox(height: 5),
      itemCount: 25,
    );
  }
}
