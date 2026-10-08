import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detail')),
      body: const Center(
        child: Hero(
          tag: 'hero-icon',
          child: Icon(
            Icons.rocket_launch,
            size: 160,
            color: Colors.indigo,
            semanticLabel: 'Ikon roket',
          ),
        ),
      ),
    );
  }
}
