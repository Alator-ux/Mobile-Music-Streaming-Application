import 'package:client/utils/api_helpers.dart';

class Track {
  final String title;
  final String artist;
  final String coverUrl;
  final String audioUrl;
  final int duration;

  Track({
    required this.title,
    required this.artist,
    required this.coverUrl,
    required this.audioUrl,
    required this.duration,
  });

  factory Track.fromJson(Map<String, dynamic> json) {
    const String pcIp = "localhost:9000";
    final List<dynamic>? artistsList = json['artists'];
    final String artistName = (artistsList != null && artistsList.isNotEmpty)
        ? artistsList.join(", ")
        : 'Неизвестный исполнитель';

    return Track(
      title: json['title'],
      artist: artistName,
      coverUrl: fixUrl(json['cover_url'], pcIp),
      audioUrl: fixUrl(json['file_url'], pcIp),
      duration: json['duration'] ?? 0,
    );
  }
}
