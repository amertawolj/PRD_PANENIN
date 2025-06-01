import 'package:flutter/material.dart';
import 'tambah_produk_screen.dart';

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
      home: const TambahProdukScreen(), // Mulai dari Status Pesanan Screen
      debugShowCheckedModeBanner: false,
    );
  }
}