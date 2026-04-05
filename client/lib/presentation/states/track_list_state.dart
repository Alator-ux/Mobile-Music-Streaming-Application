import 'package:client/data/models/track.dart';

sealed class TrackListState {
  const TrackListState();
}

class TrackListLoading extends TrackListState {
  const TrackListLoading();
}

class TrackListSuccess extends TrackListState {
  final List<Track> tracks;

  const TrackListSuccess(this.tracks);
}

class TrackListError extends TrackListState {
  final String message;

  const TrackListError(this.message);
}
