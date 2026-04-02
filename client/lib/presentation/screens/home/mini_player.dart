import 'package:client/presentation/screens/home/full_screen_player/full_screen_player.dart';
import 'package:flutter/material.dart';

class MiniPlayer extends StatelessWidget {
  const MiniPlayer({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: () {
        showModalBottomSheet(
          isScrollControlled: true,
          useSafeArea: true,
          context: context,
          builder: (context) => FullScreenPlayer(),
        );
      },
      child: SizedBox(
        height: 50,
        child: DecoratedBox(
          decoration: BoxDecoration(),
          child: Stack(
            alignment: .center,
            children: [
              Row(
                mainAxisAlignment: .spaceBetween,
                children: [
                  IconButton(onPressed: () {}, icon: Icon(Icons.play_arrow)),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.favorite_outline),
                      ),
                      IconButton(onPressed: () {}, icon: Icon(Icons.close)),
                    ],
                  ),
                ],
              ),
              IgnorePointer(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '5k ELO',
                      style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'ALBLAK 52',
                      style: theme.textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
