import 'package:client/data/models/track.dart';
import 'package:client/presentation/controllers/track_list_controller.dart';
import 'package:client/presentation/screens/home/track_list.dart';
import 'package:client/presentation/states/track_list_state.dart';
import 'package:client/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

class TrackSearchDelegate extends SearchDelegate {
  final TrackListController trackListController;
  List<Track> _allTracks = [];
  List<Track> _searchResults = [];

  TrackSearchDelegate({required this.trackListController});

  @override
  String? get searchFieldLabel => null; 

  @override
  Widget buildSearchField(BuildContext context) {
    return TextField(
      autofocus: true,
      style: TextStyle(
        color: Theme.of(context).textTheme.bodyLarge?.color,
      ),
      decoration: InputDecoration(
        hintText: context.l10n.tab_tracks, 
        hintStyle: const TextStyle(color: Colors.grey),
        border: InputBorder.none,
      ),
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
          _performSearch();
        },
        icon: const Icon(Icons.clear_rounded),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    _performSearch();
    
    if (_searchResults.isEmpty && query.isNotEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.music_note, size: 64, color: Colors.grey),
            const SizedBox(height: 16),
            Text(
              context.l10n.no_search_results, 
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              context.l10n.try_change_query, 
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.grey,
              ),
            ),
          ],
        ),
      );
    }
    
    if (_searchResults.isEmpty && query.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.search, size: 64, color: Colors.grey),
            const SizedBox(height: 16),
            Text(
              context.l10n.enter_track_or_artist, 
              style: const TextStyle(color: Colors.grey),
            ),
          ],
        ),
      );
    }
    
    return TrackList(tracks: _searchResults);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (trackListController.state is TrackListSuccess) {
      final successState = trackListController.state as TrackListSuccess;
      _allTracks = successState.tracks;
      _performSearch();
      return buildResults(context);
    } else if (trackListController.state is TrackListLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (trackListController.state is TrackListError) {
      final errorState = trackListController.state as TrackListError;
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(context.l10n.error_unknown), 
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                trackListController.fetchAllTracks();
              },
              child: Text(context.l10n.retry),
            ),
          ],
        ),
      );
    }
    
    return const SizedBox.shrink();
  }
  
  void _performSearch() {
    if (query.isEmpty) {
      _searchResults = [];
      return;
    }
    
    final searchTerm = query.toLowerCase().trim();
    _searchResults = _allTracks.where((track) {
      return track.title.toLowerCase().contains(searchTerm) ||
             track.artist.toLowerCase().contains(searchTerm);
    }).toList();
  }
}