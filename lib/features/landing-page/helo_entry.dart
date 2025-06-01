import 'package:flutter/material.dart';
import 'landing-page.dart'; // pastikan file ini di lib/

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      home: LandingPage(), // langsung render screen kamu
      debugShowCheckedModeBanner: false,
    );
  }
}