import 'package:flutter/material.dart';

class TrackWidget extends StatefulWidget {
  const TrackWidget({super.key});

  @override
  State<TrackWidget> createState() => _TrackWidgetState();
}

class _TrackWidgetState extends State<TrackWidget> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListTile(
      contentPadding: const .only(left: 5),
      title: Text('5k ELO', style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),),
      subtitle: Text('ALBLAK 52', style: theme.textTheme.bodyMedium,),
      leading: AspectRatio(
        aspectRatio: 1,
        child: ClipRRect(
          borderRadius: .circular(4),
          child: Image.network(
            'https://t2.genius.com/unsafe/430x430/https%3A%2F%2Fimages.genius.com%2Ff71c66885ab455155421ca924a4e9854.1000x1000x1.png',
            fit: .cover,
          ),
        ),
      ),
      trailing: Row(
        mainAxisSize: .min,
        children: [
          Text('2:06'),
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
        ],
      ),
      onTap: () {},
    );
  }
}
