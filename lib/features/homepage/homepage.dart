import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
import 'package:prd_tubes/features/tambah-produk/tambah_produk_detail_screen.dart';
import 'package:prd_tubes/features/tambah-produk/tambah_produk_screen.dart';
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
        child: CustomScrollView(
          slivers: [
            // Header section as a sliver
            SliverToBoxAdapter(
              child: _buildCompactHeader(),
            ),

            // Main content section as a sliver
            SliverToBoxAdapter(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 16),

                      // Compact Akses Cepat Section
                      _buildAksesCepatSection(),

                      const SizedBox(height: 20),

                      // Compact Rangkuman Pesanan Section
                      _buildCompactRangkumanPesananSection(),

                      const SizedBox(height: 20),

                      // Compact Komoditas Section
                      _buildCompactKomoditasSection(),

                      const SizedBox(height: 80), // Space for bottom nav
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  Widget _buildCompactHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Compact top bar with greeting and icons
          Row(
            children: [
              // Smaller profile avatar
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.person,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              const SizedBox(width: 10),

              // Greeting text
              const Expanded(
                child: Text(
                  'Halo, User',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
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
                    padding: const EdgeInsets.all(6),
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

          const SizedBox(height: 16),

          // Compact search bar
          Container(
            height: 42,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.9),
              borderRadius: BorderRadius.circular(12),
            ),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Cari...',
                hintStyle: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 13,
                ),
                prefixIcon: Icon(Icons.search, color: Colors.grey[600], size: 18),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Compact featured banner
          Container(
            height: 110,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
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
              padding: const EdgeInsets.all(16),
              child: const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'TerKini! Petani juga ikut\nmenolak RUU TNI.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
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
            fontSize: 16,
            fontWeight: FontWeight.w600,
            fontFamily: 'Poppins',
          ),
        ),
        const SizedBox(height: 12),

        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFF3C5232),
            borderRadius: BorderRadius.circular(12),
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
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Text(
            count,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              fontFamily: 'Poppins',
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
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
            fontSize: 16,
            fontWeight: FontWeight.w600,
            fontFamily: 'Poppins',
          ),
        ),
        const SizedBox(height: 12),

        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: const Color(0xFF8FA26D),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                decoration: BoxDecoration(
                  color: const Color(0xFF3C5232),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Text(
                  'Komoditas Terlaris Bulan Ini',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
              const SizedBox(height: 12),

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
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: itemColor.withOpacity(0.2),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            Icons.eco_outlined,
            color: itemColor,
            size: 24,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          name,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            fontFamily: 'Poppins',
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
        Text(
          price,
          style: const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w400,
            fontFamily: 'Poppins',
            color: Colors.white70,
          ),
        ),
      ],
    );
  }

  void _onBottomNavTap(int index) {
    switch (index) {
      case 0:
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SeeAllFeaturesScreen())
        );
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

  Widget _buildBottomNavBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(0),
          topRight: Radius.circular(0),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: const Offset(0, -2),
            blurRadius: 10,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: const Color(0xFF4A5D23),
          unselectedItemColor: const Color(0xFF9CA3AF),
          selectedFontSize: 12,
          unselectedFontSize: 10,
          iconSize: 24,
          elevation: 0,
          currentIndex: _currentBottomNavIndex,
          onTap: (index) {
            setState(() {
              _currentBottomNavIndex = index;
            });
            if (index == 0) Navigator.push(context, MaterialPageRoute(builder: (context) => HomepageScreen()));
            if (index == 1) Navigator.push(context, MaterialPageRoute(builder: (context) => TambahProdukScreen()));
            if (index == 2) Navigator.push(context, MaterialPageRoute(builder: (context) => OrderDashboardScreen()));
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: 'Beranda',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.inventory_2_outlined),
              activeIcon: Icon(Icons.store),
              label: 'Toko',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.analytics_outlined),
              activeIcon: Icon(Icons.shopping_bag),
              label: 'Pesanan',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.message_outlined),
              activeIcon: Icon(Icons.message),
              label: 'Pesan',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_2_outlined),
              activeIcon: Icon(Icons.person),
              label: 'Profil',
            ),
          ],
        ),
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
        'icon': Iconsax.shopping_bag,
        'title': 'Pesanan',
        'onTap': () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => OrderDashboardScreen()),
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
        'icon': Iconsax.chart_1,
        'title': 'Prediksi\nharga',
        'onTap': () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PilihKategoriScreen()),
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