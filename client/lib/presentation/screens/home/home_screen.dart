import 'package:client/extensions/context_extensions.dart';
import 'package:client/presentation/screens/home/mini_player.dart';
import 'package:client/presentation/screens/home/track_list.dart';
import 'package:client/presentation/screens/home/track_search_delegate.dart';
import 'package:client/presentation/screens/profile/profile_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ValueNotifier<int> currentPageIndex = ValueNotifier<int>(0);

  @override
  void dispose() {
    currentPageIndex.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final titles = [
      Text(context.l10n.tab_tracks),
      Text(context.l10n.tab_favorites),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black12,
        actions: [
          IconButton(
            onPressed: () =>
                showSearch(context: context, delegate: TrackSearchDelegate()),
            icon: const Icon(Icons.search),
          ),
        ],
        title: ValueListenableBuilder(
          valueListenable: currentPageIndex,
          builder: (_, index, _) {
            if (index >= titles.length) return const SizedBox.shrink();
            return titles[index];
          },
        ),
      ),
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: currentPageIndex,
          builder: (_, index, _) {
            return IndexedStack(
              index: index,
              children: [TrackList(), TrackList(), ProfileScreen()],
            );
          },
        ),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: .min,
        children: [
          MiniPlayer(),
          ValueListenableBuilder(
            valueListenable: currentPageIndex,
            builder: (context, value, child) {
              return NavigationBar(
                onDestinationSelected: (int index) =>
                    currentPageIndex.value = index,
                selectedIndex: value,
                destinations: [
                  NavigationDestination(
                    selectedIcon: const Icon(Icons.home),
                    icon: const Icon(Icons.home_outlined),
                    label: context.l10n.nav_home,
                  ),
                  NavigationDestination(
                    selectedIcon: const Icon(Icons.favorite),
                    icon: const Icon(Icons.favorite_outline),
                    label: context.l10n.nav_favorites,
                  ),
                  NavigationDestination(
                    icon: const Icon(Icons.account_circle),
                    label: context.l10n.nav_profile,
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
