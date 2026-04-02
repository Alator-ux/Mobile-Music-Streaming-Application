import 'package:flutter/material.dart';

class ControlPanel extends StatelessWidget {
  const ControlPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: .spaceBetween,
      children: [
        IconButton(onPressed: () {}, icon: Icon(Icons.shuffle)),
        Row(
          children: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.skip_previous, size: 48),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.play_arrow, size: 64),
            ),
            IconButton(onPressed: () {}, icon: Icon(Icons.skip_next, size: 48)),
          ],
        ),
        IconButton(onPressed: () {}, icon: Icon(Icons.loop)),
      ],
    );
  }
}
