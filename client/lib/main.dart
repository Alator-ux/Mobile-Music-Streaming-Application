import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: const HelloWorld()));
}

class HelloWorld extends StatelessWidget {
  const HelloWorld({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text('Hello, world!')));
  }
}
