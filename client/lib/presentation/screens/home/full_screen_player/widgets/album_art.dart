import 'package:flutter/material.dart';

class AlbumArt extends StatelessWidget {
  const AlbumArt({super.key});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: ClipRRect(
        borderRadius: .circular(15),
        child: Image.network(
          'https://t2.genius.com/unsafe/430x430/https%3A%2F%2Fimages.genius.com%2Ff71c66885ab455155421ca924a4e9854.1000x1000x1.png',
          fit: .cover,
        ),
      ),
    );
  }
}
