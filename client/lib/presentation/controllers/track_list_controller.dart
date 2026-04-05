import 'package:client/data/datasources/remote/track_api_service.dart';
import 'package:client/data/models/track.dart';
import 'package:client/presentation/states/track_list_state.dart';
import 'package:flutter/cupertino.dart';

class TrackListController extends ChangeNotifier {
  final TrackApiService _trackService = TrackApiService();
  List<Track> tracks = [];

  TrackListState _state = const TrackListLoading();

  TrackListState get state => _state;

  Future<void> fetchAllTracks() async {
    updateState(TrackListLoading());
    try {
      tracks = await _trackService.getTracks();
      updateState(TrackListSuccess(tracks));
    } catch (e) {
      updateState(TrackListError(e.toString().replaceAll('Exception: ', '')));
    }
  }

  void updateState(TrackListState newState) {
    if (_state == newState) return;
    _state = newState;
    notifyListeners();
  }
}
