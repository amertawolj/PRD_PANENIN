import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:prd_tubes/features/dashboard/dashboard.dart';

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
import 'package:prd_tubes/features/notifikasi/stock_notification-screen.dart';
import 'package:prd_tubes/features/toko/toko_profile_screen.dart';

class HomepageScreen extends StatefulWidget {
  const HomepageScreen({super.key});

  @override
  State<HomepageScreen> createState() => _HomepageScreenState();
}

class _HomepageScreenState extends State<HomepageScreen> {
  final PageController _pageController = PageController();
  int _currentBottomNavIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF3C5232),
      body: SafeArea(
        child: Column(
          children: [
            // Compact Header Section
            _buildCompactHeader(),

            // Main Content Area
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16), // Reduced padding
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 16), // Reduced spacing

                        // Compact Akses Cepat Section
                        _buildAksesCepatSection(),

                        const SizedBox(height: 20), // Reduced spacing

                        // Compact Rangkuman Pesanan Section
                        _buildCompactRangkumanPesananSection(),

                        const SizedBox(height: 20), // Reduced spacing

                        // Compact Komoditas Section
                        _buildCompactKomoditasSection(),

                        const SizedBox(height: 80), // Space for bottom nav
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildCompactBottomNavBar(),
    );
  }

  Widget _buildCompactHeader() {
    return Container(
      padding: const EdgeInsets.all(16), // Reduced padding
      child: Column(
        children: [
          // Compact top bar with greeting and icons
          Row(
            children: [
              // Smaller profile avatar
              Container(
                width: 32, // Reduced size
                height: 32,
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(10), // Smaller radius
                ),
                child: const Icon(
                  Icons.person,
                  color: Colors.white,
                  size: 20, // Smaller icon
                ),
              ),
              const SizedBox(width: 10), // Reduced spacing

              // Greeting text
              const Expanded(
                child: Text(
                  'Halo, User',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18, // Smaller font
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Poppins',
                  ),
                ),
              ),

              // Compact action icons
              Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    padding: const EdgeInsets.all(6), // Reduced padding
                    constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                    icon: const Icon(Icons.mail_outline, color: Colors.white, size: 20),
                  ),
                  IconButton(
                    onPressed: () {},
                    padding: const EdgeInsets.all(6),
                    constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                    icon: const Icon(Icons.notifications_outlined, color: Colors.white, size: 20),
                  ),
                  IconButton(
                    onPressed: () {},
                    padding: const EdgeInsets.all(6),
                    constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                    icon: const Icon(Icons.settings_outlined, color: Colors.white, size: 20),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 16), // Reduced spacing

          // Compact search bar
          Container(
            height: 42, // Fixed smaller height
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.9),
              borderRadius: BorderRadius.circular(12), // Smaller radius
            ),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Cari...',
                hintStyle: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 13, // Smaller font
                ),
                prefixIcon: Icon(Icons.search, color: Colors.grey[600], size: 18),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              ),
            ),
          ),

          const SizedBox(height: 16), // Reduced spacing

          // Compact featured banner
          Container(
            height: 110, // Reduced height
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12), // Smaller radius
              image: const DecorationImage(
                image: AssetImage('assets/image/petani.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Colors.black.withOpacity(0.6),
                    Colors.transparent,
                  ],
                ),
              ),
              padding: const EdgeInsets.all(16), // Reduced padding
              child: const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'TerKini! Petani juga ikut\nmenolak RUU TNI.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15, // Smaller font
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAksesCepatSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Akses Cepat',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            fontFamily: 'Poppins',
          ),
        ),
        const SizedBox(height: 14),

        // Scrollable quick access items
        SizedBox(
          height: 110,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _getQuickAccessItems().length,
            itemBuilder: (context, index) {
              final item = _getQuickAccessItems()[index];
              return Container(
                margin: EdgeInsets.only(right: index == _getQuickAccessItems().length - 1 ? 0 : 16),
                child: _buildQuickAccessItem(
                  item['icon'] as IconData,
                  item['title'] as String,
                  item['onTap'] as VoidCallback,
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildQuickAccessItem(IconData icon, String title, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 80,
        child: Column(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(
                icon,
                size: 28,
                color: const Color(0xFF4A5D23),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                fontFamily: 'Poppins',
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCompactRangkumanPesananSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Rangkuman Pesanan',
          style: TextStyle(
            fontSize: 16, // Smaller title
            fontWeight: FontWeight.w600,
            fontFamily: 'Poppins',
          ),
        ),
        const SizedBox(height: 12),

        Container(
          padding: const EdgeInsets.all(16), // Reduced padding
          decoration: BoxDecoration(
            color: const Color(0xFF3C5232),
            borderRadius: BorderRadius.circular(12), // Smaller radius
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildCompactOrderSummaryItem('10', 'Masuk'),
              _buildCompactOrderSummaryItem('7', 'Diproses'),
              _buildCompactOrderSummaryItem('17', 'Selesai'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCompactOrderSummaryItem(String count, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16), // Reduced padding
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(10), // Smaller radius
      ),
      child: Column(
        children: [
          Text(
            count,
            style: const TextStyle(
              fontSize: 20, // Smaller number
              fontWeight: FontWeight.w700,
              fontFamily: 'Poppins',
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12, // Smaller label
              fontWeight: FontWeight.w500,
              fontFamily: 'Poppins',
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompactKomoditasSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Komoditas Terlaris',
          style: TextStyle(
            fontSize: 16, // Smaller title
            fontWeight: FontWeight.w600,
            fontFamily: 'Poppins',
          ),
        ),
        const SizedBox(height: 12),

        Container(
          padding: const EdgeInsets.all(14), // Reduced padding
          decoration: BoxDecoration(
            color: const Color(0xFF8FA26D),
            borderRadius: BorderRadius.circular(12), // Smaller radius
          ),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12), // Reduced padding
                decoration: BoxDecoration(
                  color: const Color(0xFF3C5232),
                  borderRadius: BorderRadius.circular(6), // Smaller radius
                ),
                child: const Text(
                  'Komoditas Terlaris Bulan Ini',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12, // Smaller font
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
              const SizedBox(height: 12), // Reduced spacing

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildCompactKomoditasItem('C. Rawit', 'Rp10 Jt', Colors.red),
                  _buildCompactKomoditasItem('Bawang Merah', 'Rp5 Jt', Colors.purple),
                  _buildCompactKomoditasItem('Beras', 'Rp7 Jt', Colors.brown),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCompactKomoditasItem(String name, String price, Color itemColor) {
    return Column(
      children: [
        Container(
          width: 48, // Smaller size
          height: 48,
          decoration: BoxDecoration(
            color: itemColor.withOpacity(0.2),
            borderRadius: BorderRadius.circular(10), // Smaller radius
          ),
          child: Icon(
            Icons.eco_outlined,
            color: itemColor,
            size: 24, // Smaller icon
          ),
        ),
        const SizedBox(height: 6),
        Text(
          name,
          style: const TextStyle(
            fontSize: 11, // Smaller font
            fontWeight: FontWeight.w600,
            fontFamily: 'Poppins',
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
        Text(
          price,
          style: const TextStyle(
            fontSize: 10, // Smaller font
            fontWeight: FontWeight.w400,
            fontFamily: 'Poppins',
            color: Colors.white70,
          ),
        ),
      ],
    );
  }

  void _onBottomNavTap(int index) {
    // Don't update _currentIndex here since we're navigating away

    switch (index) {
      case 0:
      // Already on Beranda (current screen) - do nothing
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SeeAllFeaturesScreen())
        );
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

  Widget _buildCompactBottomNavBar() {
    return Container(
      height: 60, // Fixed smaller height
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
        selectedFontSize: 10, // Smaller font
        unselectedFontSize: 10,
        iconSize: 20, // Smaller icons
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

  List<Map<String, dynamic>> _getQuickAccessItems() {
    return [
      {
        'icon': Iconsax.shop,
        'title': 'Toko',
        'onTap': () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => TokoProfileScreen()),
        ),
      },
      {
        'icon': Iconsax.chart_1,
        'title': 'Prediksi\nharga',
        'onTap': () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PilihKategoriScreen()),
        ),
      },
      {
        'icon': Iconsax.shopping_bag,
        'title': 'Pesanan',
        'onTap': () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => OrderDashboardScreen()),
        ),
      },
      {
        'icon': Iconsax.home_2,
        'title': 'Tambah\nPengingat',
        'onTap': () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => StockNotificationScreen()),
        ),
      },
      {
        'icon': Iconsax.add_circle,
        'title': 'Tambah\nproduk',
        'onTap': () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => TambahProdukScreen()),
        ),
      },
      {
        'icon': Iconsax.grid_1,
        'title': 'Lihat\nsemua',
        'onTap': () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SeeAllFeaturesScreen()),
        )
      },
    ];
  }

  void _navigateToFeature(String featureName) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FeatureScreen(featureName),
      ),
    );
  }

  void _navigateToSeeAllFeatures() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SeeAllFeaturesScreen(),
      ),
    );
  }

  void _navigateToOrders() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const OrderDashboardScreen(),
      ),
    );
  }

  void _navigateToProduk() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const TambahProdukScreen(),
      ),
    );
  }
  void _navigateToTrackerAI() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const PilihKategoriScreen(),
      ),
    );
  }

  void _navigateToToko() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const TokoProfileScreen(),
      ),
    );
  }

}


class FeatureScreen extends StatelessWidget {
  final String featureName;
  const FeatureScreen(this.featureName, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(featureName)),
      body: Center(child: Text('$featureName Screen')),
    );
  }
}
