import 'package:flutter/material.dart';

class AdPlayingPage extends StatelessWidget {
  const AdPlayingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ad Playing'),
      ),
      body: Center(
        child: const Text(
          'This is the ad playing page.',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
