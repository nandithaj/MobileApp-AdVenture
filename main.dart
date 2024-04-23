import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart';

import 'login.dart';
import 'screenselection.dart';
import 'adplaying.dart';
import 'UserData.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<UserData>(
      create: (context) => UserData(),
      child: MaterialApp(
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
     ),
    );
  }
}
