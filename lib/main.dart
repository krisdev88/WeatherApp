import 'package:flutter/material.dart';

import 'SplashScreen.dart';


void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  final String _title = 'Clean Air and Weather';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(title: _title),
    );
  }
}

