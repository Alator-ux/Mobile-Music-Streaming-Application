import 'package:client/data/models/track.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class AudioPlayerController {
  final progressNotifier = ValueNotifier<ProgressBarState>(
    ProgressBarState(
      current: Duration.zero,
      buffered: Duration.zero,
      total: Duration.zero,
    ),
  );
  final buttonNotifier = ValueNotifier<ButtonState>(ButtonState.paused);
  final currentTrackNotifier = ValueNotifier<Track?>(null);

  List<Track> _playlist = [];
  int _index = 0;

  late AudioPlayer _audioPlayer;

  AudioPlayerController() {
    _init();
  }

  void _init() async {
    _audioPlayer = AudioPlayer();

    _audioPlayer.playerStateStream.listen((playerState) {
      final isPlaying = playerState.playing;
      final processingState = playerState.processingState;
      if (processingState == ProcessingState.loading ||
          processingState == ProcessingState.buffering) {
        buttonNotifier.value = ButtonState.loading;
      } else if (!isPlaying) {
        buttonNotifier.value = ButtonState.paused;
      } else if (processingState != ProcessingState.completed) {
        buttonNotifier.value = ButtonState.playing;
      } else {
        //_audioPlayer.seek(Duration.zero);
        //_audioPlayer.pause();
        next();
      }
    });

    _audioPlayer.positionStream.listen((position) {
      final oldState = progressNotifier.value;
      progressNotifier.value = ProgressBarState(
        current: position,
        buffered: oldState.buffered,
        total: oldState.total,
      );
    });

    _audioPlayer.bufferedPositionStream.listen((bufferedPosition) {
      final oldState = progressNotifier.value;
      progressNotifier.value = ProgressBarState(
        current: oldState.current,
        buffered: bufferedPosition,
        total: oldState.total,
      );
    });

    _audioPlayer.durationStream.listen((totalDuration) {
      final oldState = progressNotifier.value;
      progressNotifier.value = ProgressBarState(
        current: oldState.current,
        buffered: oldState.buffered,
        total: totalDuration ?? Duration.zero,
      );
    });
  }

  void playSpecificTrack(List<Track> playlist, int index) async {
    _playlist = playlist;
    _index = index;

    final track = _playlist[_index];
    currentTrackNotifier.value = track;

    try {
      buttonNotifier.value = ButtonState.loading;

      final audioSource = LockCachingAudioSource(
        Uri.parse(track.audioUrl),
        tag: track.title,
      );
      await _audioPlayer.setAudioSource(audioSource);
      _audioPlayer.play();
    } catch (e) {
      debugPrint("Ошибка: $e");
      buttonNotifier.value = ButtonState.paused;
    }
  }

  void play() {
    _audioPlayer.play();
  }

  void pause() {
    _audioPlayer.pause();
  }

  void seek(Duration position) {
    _audioPlayer.seek(position);
  }

  void stop() {
    _audioPlayer.stop();
    currentTrackNotifier.value = null;
  }

  void next() {
    if (_playlist.isEmpty) return;

    if (_index < _playlist.length - 1) {
      playSpecificTrack(_playlist, _index + 1);
    } else {
      playSpecificTrack(_playlist, 0);
    }
  }

  void previous() {
    if (_playlist.isEmpty) return;

    if (_index > 0) {
      playSpecificTrack(_playlist, _index - 1);
    } else {
      playSpecificTrack(_playlist, _playlist.length - 1);
    }
  }

  void dispose() {
    _audioPlayer.dispose();
  }
}

class ProgressBarState {
  ProgressBarState({
    required this.current,
    required this.buffered,
    required this.total,
  });

  final Duration current;
  final Duration buffered;
  final Duration total;
}

enum ButtonState { paused, playing, loading }
