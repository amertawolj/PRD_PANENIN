import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'product_dashboard_screen.dart'; // Import the ProductDashboardScreen
import 'customer_reviews_screen.dart'; // Import the CustomerReviewsScreen
import 'package:prd_tubes/features/finance/finance.dart';
class TokoProfileScreen extends StatefulWidget {
  const TokoProfileScreen({super.key});

  @override
  State<TokoProfileScreen> createState() => _TokoProfileScreenState();
}

class _TokoProfileScreenState extends State<TokoProfileScreen> {
  int selectedTab = 0; // 0 for Terbaru, 1 for Terlaris
  int selectedCategory = -1; // -1 berarti tidak ada yang dipilih, 0 = Buah, 1 = Sayur, 2 = Lainnya

  final List<ProductItem> products = [
    ProductItem(
      name: 'Tomat Ciwi',
      weight: '1 Kg',
      price: 'Rp 15,000',
      imagePath: 'assets/image/tomat.jpeg',
    ),
    ProductItem(
      name: 'Terong Penyamaran',
      weight: '50 Kg',
      price: 'Rp 25,000',
      imagePath: 'assets/image/terong.jpg',
    ),
    ProductItem(
      name: 'Jati Raya',
      weight: '130 Kg',
      price: 'Rp 85,000',
      imagePath: 'assets/image/kayujati.jpg',
    ),
  ];

  // Data kategori
  final List<Map<String, dynamic>> categories = [
    {
      'emoji': '🍎',
      'label': 'Buah',
      'activeColor': Color(0xFF5F6C37),
    },
    {
      'emoji': '🥬',
      'label': 'Sayur',
      'activeColor': Color(0xFF5F6C37),
    },
    {
      'emoji': '🌾',
      'label': 'Lainnya',
      'activeColor': Color(0xFF5F6C37),
    },
  ];

  // Data ulasan
  final List<Map<String, dynamic>> reviews = [
    {
      'name': 'Sara',
      'review': 'Tomatnya segar semua',
      'avatar': 'assets/image/avatar1.jpg',
    },
    {
      'name': 'John',
      'review': 'Saya suka jati rahal',
      'avatar': 'assets/image/avatar2.jpg',
    },
    {
      'name': 'Maya',
      'review': 'Pelayanan ramah dan cepat',
      'avatar': 'assets/image/avatar3.jpg',
    },
    {
      'name': 'Andi',
      'review': 'Kualitas produk bagus sekali',
      'avatar': 'assets/image/avatar4.jpg',
    },
  ];

  // Navigation function for Product button
  void _navigateToProductDashboard() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ProductDashboardScreen(),
      ),
    );
  }

  // Navigation function for Ulasan button
  void _navigateToCustomerReviews() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const CustomerReviewsScreen(),
      ),
    );
  }
  void _navigateToFinance() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const FinanceScreen(),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Dark Green header section
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF042631), // Dark green
                    Color(0xFF5F6C37), // Slightly lighter dark green
                  ],
                ),
              ),
              child: SafeArea(
                bottom: false,
                child: Column(
                  children: [
                    // App bar
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
                            onPressed: () => Navigator.pop(context),
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            'Toko',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Poppins',
                            ),
                          ),
                          const Spacer(),
                          IconButton(
                            icon: const Icon(Icons.more_vert, color: Colors.white),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),

                    // Profile section
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        children: [
                          const SizedBox(height: 8),
                          // Profile image
                          Container(
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                            child: ClipOval(
                              child: Image.asset(
                                'assets/image/tomat.jpeg',
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    decoration: const BoxDecoration(
                                      color: Color(0xFF8D6E63),
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.person,
                                      size: 35,
                                      color: Colors.white,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),

                          const SizedBox(height: 10),

                          // Name and rating
                          const Text(
                            'TUNG TUNG SAYUR',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Poppins',
                            ),
                          ),

                          const SizedBox(height: 2),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Rating: ',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 12,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                              ...List.generate(4, (index) => const Icon(
                                Icons.star,
                                color: Colors.amber,
                                size: 14,
                              )),
                              const Icon(
                                Icons.star_border,
                                color: Colors.white70,
                                size: 14,
                              ),
                              const Text(
                                ' 4.9/5',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 12,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 16),

                          // Stats row
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _buildStatColumn('20rb', 'Pengikut'),
                              Container(
                                height: 35,
                                width: 1,
                                color: Colors.white30,
                              ),
                              _buildStatColumn('20', 'Produk'),
                              Container(
                                height: 35,
                                width: 1,
                                color: Colors.white30,
                              ),
                              _buildStatColumn('200rb+', 'Terjual'),
                            ],
                          ),

                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // White content section
            Container(
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),

                  // Category section
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'Kategori Produk',
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),

                  const SizedBox(height: 8),

                  // Category buttons (Selectable)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: List.generate(categories.length, (index) {
                        final category = categories[index];
                        final isSelected = selectedCategory == index;

                        return Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(
                              right: index < categories.length - 1 ? 8 : 0,
                            ),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  // Toggle selection: jika sudah dipilih, maka unselect
                                  if (selectedCategory == index) {
                                    selectedCategory = -1;
                                  } else {
                                    selectedCategory = index;
                                  }
                                });
                              },
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                padding: const EdgeInsets.symmetric(vertical: 10),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? category['activeColor']
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(6),
                                  border: Border.all(
                                    color: isSelected
                                        ? category['activeColor']
                                        : const Color(0xFF2E7D32),
                                    width: 1,
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                        category['emoji'],
                                        style: const TextStyle(fontSize: 14)
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      category['label'],
                                      style: TextStyle(
                                        color: isSelected
                                            ? Colors.white
                                            : category['activeColor'],
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'Poppins',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),

                  const SizedBox(height: 18),

                  // Sales stats section - Made larger
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        Expanded(
                          child: _buildSalesCard('Total Penjualan\n+10%', 'Rp 15,000,000', isLarge: true),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: _buildSalesCard('Produk Terjual', '3000', subtitle: 'Bulan ini', isLarge: true),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: _buildSalesCard('Pelanggan', '35', subtitle: '+12%', isLarge: true),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Action buttons
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: _navigateToProductDashboard, // Navigate to ProductDashboardScreen
                            child: _buildActionButton(Icons.shopping_basket, 'Produk'),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: GestureDetector(
                            onTap: _navigateToCustomerReviews, // Navigate to CustomerReviewsScreen
                            child: _buildActionButton(Icons.chat_bubble_outline, 'Ulasan'),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: GestureDetector(
                            onTap: _navigateToFinance,
                            child: _buildActionButton(Icons.trending_up, 'Keuangan'),
                          )
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),
                ],
              ),
            ),

            // Products section
            Container(
              color: const Color(0xFFF5F5F5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),

                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'Produk',
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Tab bar
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () => setState(() => selectedTab = 0),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                            decoration: BoxDecoration(
                              color: selectedTab == 0 ? const Color(0xFF3C5232) : Colors.transparent,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Text(
                              'Terbaru',
                              style: TextStyle(
                                color: selectedTab == 0 ? Colors.white : Colors.grey.shade600,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(width: 12),

                        GestureDetector(
                          onTap: () => setState(() => selectedTab = 1),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                            decoration: BoxDecoration(
                              color: selectedTab == 1 ? const Color(0xFF3C5232) : Colors.transparent,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Text(
                              'Terlaris',
                              style: TextStyle(
                                color: selectedTab == 1 ? Colors.white : Colors.grey.shade600,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ),
                        ),

                        const Spacer(),

                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Colors.grey.shade300),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Filter',
                                style: TextStyle(
                                  color: Colors.grey.shade700,
                                  fontSize: 12,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                              const SizedBox(width: 3),
                              Icon(Iconsax.filter, size: 12, color: Colors.grey.shade700),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Products grid
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.85,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        final product = products[index];
                        return _buildProductCard(product);
                      },
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Customer reviews section - Made horizontal
                  Container(
                    width: double.infinity,
                    color: Colors.white,
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Ulasan Pelanggan',
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Poppins',
                              ),
                            ),
                            Text(
                              'Lihat komentar pelanggan',
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 12,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 12),

                        // Horizontal review cards
                        SizedBox(
                          height: 120,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: reviews.length,
                            itemBuilder: (context, index) {
                              final review = reviews[index];
                              return Container(
                                width: 200,
                                margin: EdgeInsets.only(
                                  right: index < reviews.length - 1 ? 12 : 0,
                                ),
                                child: _buildHorizontalReviewCard(
                                  review['name'],
                                  review['review'],
                                  review['avatar'],
                                ),
                              );
                            },
                          ),
                        ),

                        const SizedBox(height: 16),

                        // Selengkapnya button
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: _navigateToCustomerReviews, // Also navigate to CustomerReviewsScreen
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF3C5232),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              elevation: 0,
                            ),
                            child: const Text(
                              'Selengkapnya',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 6),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatColumn(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w700,
            fontFamily: 'Poppins',
          ),
        ),
        const SizedBox(height: 1),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 11,
            fontFamily: 'Poppins',
          ),
        ),
      ],
    );
  }

  Widget _buildSalesCard(String title, String value, {String? subtitle, bool isLarge = false}) {
    return Container(
      padding: const EdgeInsets.all(16), // Made larger
      decoration: BoxDecoration(
        color: const Color(0xFFF9F9F9),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: const Color(0xFF2E7D32), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 10,
              fontFamily: 'Poppins',
              height: 1.2,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: TextStyle(
              color: Colors.grey.shade800,
              fontSize: 14, // Made larger
              fontWeight: FontWeight.w600,
              fontFamily: 'Poppins',
              height: 1.2,
            ),
          ),
          if (subtitle != null) ...[
            const SizedBox(height: 2),
            Text(
              subtitle,
              style: TextStyle(
                color: Colors.grey.shade500,
                fontSize: 9, // Made smaller
                fontFamily: 'Poppins',
                height: 1.2,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildActionButton(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFF9F9F9),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: const Color(0xFF2E7D32), width: 1),
      ),
      child: Column(
        children: [
          Icon(icon, color: Colors.grey.shade600, size: 18),
          const SizedBox(height: 3),
          Text(
            label,
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 11,
              fontFamily: 'Poppins',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductCard(ProductItem product) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
              child: Image.asset(
                product.imagePath,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.green.shade100,
                          Colors.green.shade200,
                        ],
                      ),
                    ),
                    child: Icon(
                      Icons.eco,
                      color: Colors.green.shade400,
                      size: 35,
                    ),
                  );
                },
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Poppins',
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    product.weight,
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 9,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  Text(
                    product.price,
                    style: const TextStyle(
                      color: Color(0xFF2E7D32),
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHorizontalReviewCard(String name, String review, String avatarPath) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F8F8),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: const Color(0xFF8D6E63),
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage(avatarPath),
                    fit: BoxFit.cover,
                    onError: (exception, stackTrace) {},
                  ),
                ),
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color(0xFF8D6E63),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  name,
                  style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: List.generate(5, (index) => const Icon(
              Icons.star,
              color: Colors.amber,
              size: 14,
            )),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: Text(
              review,
              style: TextStyle(
                color: Colors.grey.shade700,
                fontSize: 12,
                fontFamily: 'Poppins',
                height: 1.3,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

class ProductItem {
  final String name;
  final String weight;
  final String price;
  final String imagePath;

  ProductItem({
    required this.name,
    required this.weight,
    required this.price,
    required this.imagePath,
  });
}