import 'package:client/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

class PlayerHeader extends StatelessWidget {
  const PlayerHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisAlignment: .spaceBetween,
      children: [
        IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.keyboard_arrow_down),
        ),
        Column(
          mainAxisAlignment: .center,
          children: [
            Text(
              context.l10n.playlist.toUpperCase(),
              style: theme.textTheme.labelSmall,
            ),
            Text(
              context.l10n.tab_tracks,
              style: theme.textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        IconButton(onPressed: () {}, icon: Icon(Icons.share_rounded)),
      ],
    );
  }
}
