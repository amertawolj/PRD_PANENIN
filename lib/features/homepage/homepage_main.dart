import 'package:flutter/material.dart';
import 'homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Panenin App',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: HomepageScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}