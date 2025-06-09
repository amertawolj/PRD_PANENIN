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
import 'package:prd_tubes/features/toko/toko_profile_screen.dart';

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
  int _currentBottomNavIndex = 0;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Fixed Header Section (Non-scrollable)
          Container(
            color: Colors.white,
            child: SafeArea(
              bottom: false,
              child: Column(
                children: [
                  // App Bar
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
                          onPressed: () => Navigator.pop(context),
                        ),
                        const Text(
                          'Lihat semua',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Scrollable Content Section
          Expanded(
            child: Stack(
              children: [
                // Main Content
                CustomScrollView(
                  slivers: [
                    SliverPadding(
                      padding: const EdgeInsets.all(16),
                      sliver: SliverGrid(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 1.0,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                        ),
                        delegate: SliverChildBuilderDelegate(
                              (context, index) {
                            final filteredFeatures = _getFilteredFeatures(context);
                            if (index >= filteredFeatures.length) return null;

                            final feature = filteredFeatures[index];
                            return _buildFeatureCard(
                              context,
                              feature['icon'] as IconData,
                              feature['title'] as String,
                              feature['onTap'] as VoidCallback,
                            );
                          },
                          childCount: _getFilteredFeatures(context).length,
                        ),
                      ),
                    ),
                    // Add some bottom padding to account for wave decoration
                    const SliverPadding(
                      padding: EdgeInsets.only(bottom: 200),
                    ),
                  ],
                ),

                // Bottom Wave Design (Fixed at bottom)
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
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  List<Map<String, dynamic>> _getFilteredFeatures(BuildContext context) {
    final allFeatures = _getFeatures(context);
    if (_searchQuery.isEmpty) {
      return allFeatures;
    }

    return allFeatures.where((feature) {
      final title = (feature['title'] as String).toLowerCase();
      return title.contains(_searchQuery);
    }).toList();
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
      case 'Toko':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => TokoProfileScreen()),
        );
        break;
      default:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => FeatureScreen(featureName)),
        );
        break;
    }
  }

  void _onBottomNavTap(int index) {
    switch (index) {
      case 0:
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => TambahProdukScreen()),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SalesAnalysisScreen()),
        );
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const profileScreen()),
        );
        break;
      case 4:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const profileScreen()),
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
      height: 60,
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
        selectedFontSize: 10,
        unselectedFontSize: 10,
        iconSize: 20,
        currentIndex: _currentBottomNavIndex,
        onTap: (index) {
          setState(() {
            _currentBottomNavIndex = index;
          });
        },
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

  static void navigateToToko(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const TokoProfileScreen()),
    );
  }

  static void navigateToPrediksiHarga(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const PrediksiHargaScreen()),
    );
  }
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