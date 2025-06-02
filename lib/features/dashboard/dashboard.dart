import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

// Import your existing feature screens
import 'package:prd_tubes/features/profile/profile.dart';
import 'package:prd_tubes/features/finance/finance.dart';
import 'package:prd_tubes/features/custservice/custservice.dart';
import 'package:prd_tubes/features/market/sales-analysis.dart';
import 'package:prd_tubes/features/ai-tracker/pilihkategori.dart';
import 'package:prd_tubes/features/orders/detail_komoditas_screen.dart';
import 'package:prd_tubes/features/orders/order_dashboard_screen.dart';
import 'package:prd_tubes/features/orders/status_pesanan_screen.dart';
import 'package:prd_tubes/features/tambah-produk/filled_tambah_produk_detail_screen.dart';
import 'package:prd_tubes/features/tambah-produk/tambah_produk_detail_screen.dart';
import 'package:prd_tubes/features/tambah-produk/tambah_produk_screen.dart';

// Add imports for your bottom navigation screens here
// import 'package:prd_tubes/features/home/home_screen.dart';  // Replace with actual path
// import 'package:prd_tubes/features/products/products_screen.dart';  // Replace with actual path
// import 'package:prd_tubes/features/messages/messages_screen.dart';  // Replace with actual path
// import 'package:prd_tubes/features/settings/settings_screen.dart';  // Replace with actual path

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Panenin Seller',
      theme: ThemeData(
        fontFamily: 'Poppins',
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: Colors.grey[50],
      ),
      home: const SeeAllFeaturesScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class SeeAllFeaturesScreen extends StatefulWidget {
  const SeeAllFeaturesScreen({super.key});

  @override
  State<SeeAllFeaturesScreen> createState() => _SeeAllFeaturesScreenState();
}

class _SeeAllFeaturesScreenState extends State<SeeAllFeaturesScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Lihat semua',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Stack(
        children: [
          // Main Content
          Padding(
            padding: const EdgeInsets.all(16),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1.0,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: _getFeatures(context).length,
              itemBuilder: (context, index) {
                final feature = _getFeatures(context)[index];
                return _buildFeatureCard(
                  context,
                  feature['icon'] as IconData,
                  feature['title'] as String,
                  feature['onTap'] as VoidCallback,
                );
              },
            ),
          ),

          // Bottom Wave Design
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: CustomPaint(
              size: Size(MediaQuery.of(context).size.width, 200),
              painter: WavePainter(),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  List<Map<String, dynamic>> _getFeatures(BuildContext context) {
    return [
      {
        'icon': Iconsax.shop,
        'title': 'Toko',
        'onTap': () => _navigateToFeature(context, 'Toko'),
      },
      {
        'icon': Iconsax.chart_1,
        'title': 'Prediksi harga',
        'onTap': () => _navigateToFeature(context, 'Prediksi Harga'),
      },
      {
        'icon': Iconsax.shopping_bag,
        'title': 'Pesanan',
        'onTap': () => _navigateToFeature(context, 'Pesanan'),
      },
      {
        'icon': Iconsax.location,
        'title': 'Pedoman aplikasi',
        'onTap': () => _navigateToFeature(context, 'Pedoman Aplikasi'),
      },
      {
        'icon': Iconsax.user,
        'title': 'Profil',
        'onTap': () => _navigateToFeature(context, 'Profil'),
      },
      {
        'icon': Iconsax.money_2,
        'title': 'Keuangan',
        'onTap': () => _navigateToFeature(context, 'Keuangan'),
      },
      {
        'icon': Iconsax.chart_21,
        'title': 'Analisis data penjualan',
        'onTap': () => _navigateToFeature(context, 'Analisis Data Penjualan'),
      },
      {
        'icon': Iconsax.clock,
        'title': 'Pelayanan pelanggan',
        'onTap': () => _navigateToFeature(context, 'Pelayanan Pelanggan'),
      },
      {
        'icon': Iconsax.people,
        'title': 'Komunitas',
        'onTap': () => _navigateToFeature(context, 'Komunitas'),
      },
      {
        'icon': Iconsax.message,
        'title': 'Pesan',
        'onTap': () => _navigateToFeature(context, 'Pesan'),
      },
      {
        'icon': Iconsax.message_question,
        'title': 'AI Chatbot',
        'onTap': () => _navigateToFeature(context, 'AI Chatbot'),
      },
      {
        'icon': Iconsax.setting_2,
        'title': 'Setelan',
        'onTap': () => _navigateToFeature(context, 'Setelan'),
      },
    ];
  }

  void _navigateToFeature(BuildContext context, String featureName) {
    switch (featureName) {
      case 'Profil':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const profileScreen()),
        );
        break;
      case 'Pelayanan Pelanggan':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => custserviceScreen()),
        );
        break;
      case 'Keuangan':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => FinanceScreen()),
        );
        break;
      case 'Analisis Data Penjualan':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SalesAnalysisScreen()),
        );
        break;
      case 'Prediksi Harga':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PilihKategoriScreen()),
        );
        break;
      default:
      // For features that don't have screens yet, show placeholder
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => FeatureScreen(featureName)),
        );
        break;
    }
  }

  // Navigation function for bottom navbar
  void _onBottomNavTap(int index) {
    // Don't update _currentIndex here since we're navigating away

    switch (index) {
      case 0:
      // Already on Beranda (current screen) - do nothing
        break;
      case 1:
      // Navigate to Produk screen
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => TambahProdukScreen()),
        );
        break;
      case 2:
      // Navigate to Analisis screen
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SalesAnalysisScreen()),
        );
        break;
      case 3:
      // Navigate to Pesan screen - replace with your actual class name
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const profileScreen()), // TEMPORARY - replace with your messages screen
        );
        break;
      case 4:
      // Navigate to Pengaturan screen - replace with your actual class name
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const profileScreen()), // TEMPORARY - replace with your settings screen
        );
        break;
    }
  }

  Widget _buildFeatureCard(BuildContext context, IconData icon, String title, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 32,
              color: const Color(0xFF4A5D23),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
          ),
        ],
      ),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: const Color(0xFF4A5D23),
        unselectedItemColor: Colors.grey,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        currentIndex: _currentIndex,
        onTap: _onBottomNavTap,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.inventory_2_outlined),
            label: 'Produk',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.analytics_outlined),
            label: 'Analisis',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message_outlined),
            label: 'Pesan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Pengaturan',
          ),
        ],
      ),
    );
  }
}

// Wave Painter for bottom decoration
class WavePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint1 = Paint()
      ..color = const Color(0xFFB8C5A0).withOpacity(0.6)
      ..style = PaintingStyle.fill;

    final paint2 = Paint()
      ..color = const Color(0xFF8FA26D).withOpacity(0.4)
      ..style = PaintingStyle.fill;

    final path1 = Path();
    path1.moveTo(0, size.height * 0.6);
    path1.quadraticBezierTo(
      size.width * 0.25,
      size.height * 0.4,
      size.width * 0.5,
      size.height * 0.5,
    );
    path1.quadraticBezierTo(
      size.width * 0.75,
      size.height * 0.6,
      size.width,
      size.height * 0.4,
    );
    path1.lineTo(size.width, size.height);
    path1.lineTo(0, size.height);
    path1.close();

    final path2 = Path();
    path2.moveTo(0, size.height * 0.8);
    path2.quadraticBezierTo(
      size.width * 0.3,
      size.height * 0.6,
      size.width * 0.6,
      size.height * 0.7,
    );
    path2.quadraticBezierTo(
      size.width * 0.8,
      size.height * 0.8,
      size.width,
      size.height * 0.6,
    );
    path2.lineTo(size.width, size.height);
    path2.lineTo(0, size.height);
    path2.close();

    canvas.drawPath(path1, paint1);
    canvas.drawPath(path2, paint2);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

// Example feature screens that can be navigated to
class FeatureScreen extends StatelessWidget {
  final String featureName;

  const FeatureScreen(this.featureName, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(featureName),
        backgroundColor: const Color(0xFF4A5D23),
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              _getFeatureIcon(featureName),
              size: 80,
              color: const Color(0xFF4A5D23),
            ),
            const SizedBox(height: 20),
            Text(
              featureName,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Fitur ini sedang dalam pengembangan',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4A5D23),
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              ),
              child: const Text(
                'Kembali',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getFeatureIcon(String featureName) {
    switch (featureName) {
      case 'Toko':
        return Iconsax.shop;
      case 'Prediksi Harga':
        return Iconsax.chart_1;
      case 'Pesanan':
        return Iconsax.shopping_bag;
      case 'Pedoman Aplikasi':
        return Iconsax.location;
      case 'Profil':
        return Iconsax.user;
      case 'Keuangan':
        return Iconsax.money_2;
      case 'Analisis Data Penjualan':
        return Iconsax.chart_21;
      case 'Pelayanan Pelanggan':
        return Iconsax.clock;
      case 'Komunitas':
        return Iconsax.people;
      case 'Pesan':
        return Iconsax.message;
      case 'AI Chatbot':
        return Iconsax.message_question;
      case 'Setelan':
        return Iconsax.setting_2;
      default:
        return Iconsax.home;
    }
  }
}

// Remove these placeholder screens since you have your own classes

// Navigation helper class
class NavigationHelper {
  static void navigateToFeature(BuildContext context, String featureName) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FeatureScreen(featureName),
      ),
    );
  }

  // You can add more specific navigation methods here
  static void navigateToToko(BuildContext context) {
    // Navigate to specific Toko screen
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const TokoScreen()),
    );
  }

  static void navigateToPrediksiHarga(BuildContext context) {
    // Navigate to specific Prediksi Harga screen
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const PrediksiHargaScreen()),
    );
  }

// Add more navigation methods as needed...
}

// Example specific feature screens
class TokoScreen extends StatelessWidget {
  const TokoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Toko'),
        backgroundColor: const Color(0xFF4A5D23),
        foregroundColor: Colors.white,
      ),
      body: const Center(
        child: Text(
          'Toko Screen',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}

class PrediksiHargaScreen extends StatelessWidget {
  const PrediksiHargaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Prediksi Harga'),
        backgroundColor: const Color(0xFF4A5D23),
        foregroundColor: Colors.white,
      ),
      body: const Center(
        child: Text(
          'Prediksi Harga Screen',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}