import 'package:flutter/material.dart';
import 'package:prd_tubes/features/toko/toko_profile_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplikasi Saya',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const TokoProfileScreen(), // Mulai dari Status Pesanan Screen
      debugShowCheckedModeBanner: false,
    );
  }
}