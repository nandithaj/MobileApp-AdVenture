import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'login.dart';
import 'screenselection.dart';
import 'adplaying.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login Page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // Define routes
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(),
        '/screenSelection': (context) => ScreenSelectionPage(),
         '/adPlaying': (context) => AdPlayingPage(), // Add route for AdPlayingPage
      },
    );
  }
}
