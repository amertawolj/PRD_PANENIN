import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'tambah_produk_detail_screen.dart';
import 'filled_tambah_produk_detail_screen.dart'; // Add this import

class TambahProdukScreen extends StatefulWidget {
  const TambahProdukScreen({super.key});

  @override
  State<TambahProdukScreen> createState() => _TambahProdukScreenState();
}

class _TambahProdukScreenState extends State<TambahProdukScreen> {
  int selectedTab = 0; // 0 for Terbaru, 1 for Terlaris

  final List<ProductItem> products = [
    ProductItem(
      name: 'Tomat Ciwi',
      weight: '1 Kg',
      status: 'Low Stock',
      statusColor: Colors.red,
      imagePath: 'assets/image/tomat.jpeg',
    ),
    ProductItem(
      name: 'Wortel Bekasi',
      weight: '50 Kg',
      status: 'Available',
      statusColor: Colors.green.shade600,
      imagePath: 'assets/image/wortel.jpg',
    ),
    ProductItem(
      name: 'Terong Penyamaran',
      weight: '50 Kg',
      status: 'Available',
      statusColor: Colors.green.shade600,
      imagePath: 'assets/image/terong.jpg',
    ),
    ProductItem(
      name: 'Jati Raya',
      weight: '130 Kg',
      status: 'Available',
      statusColor: Colors.green.shade600,
      imagePath: 'assets/image/kayujati.jpg',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAF8), // Light greenish background
      body: Stack(
        children: [
          // Main content wrapped in SingleChildScrollView
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // App Bar
                Container(
                  color: Colors.white,
                  child: SafeArea(
                    bottom: false,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.arrow_back_ios, color: Colors.black87),
                            onPressed: () => Navigator.pop(context),
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            'Tambah Produk',
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Header section with description - now part of main screen with black text
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: const Text(
                    'Restok dan menambahkan produk baru',
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Search Bar
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.green.shade50,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.green.shade200),
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Cari produk...',
                        hintStyle: TextStyle(
                          color: Colors.green.shade400,
                          fontSize: 14,
                          fontFamily: 'Poppins',
                        ),
                        prefixIcon: Icon(
                          Iconsax.search_normal,
                          color: Colors.green.shade500,
                          size: 20,
                        ),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                      ),
                      style: TextStyle(
                        color: Colors.green.shade700,
                        fontSize: 14,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Tab bar and filter section
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      // Terbaru tab
                      GestureDetector(
                        onTap: () => setState(() => selectedTab = 0),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          decoration: BoxDecoration(
                            color: selectedTab == 0 ? Colors.green.shade600 : Colors.transparent,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Text(
                            'Terbaru',
                            style: TextStyle(
                              color: selectedTab == 0 ? Colors.white : Colors.grey.shade600,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(width: 16),

                      // Terlaris tab
                      GestureDetector(
                        onTap: () => setState(() => selectedTab = 1),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          decoration: BoxDecoration(
                            color: selectedTab == 1 ? Colors.green.shade600 : Colors.transparent,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Text(
                            'Terlaris',
                            style: TextStyle(
                              color: selectedTab == 1 ? Colors.white : Colors.grey.shade600,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ),
                      ),

                      const Spacer(),

                      // Filter button
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              spreadRadius: 1,
                              blurRadius: 2,
                              offset: const Offset(0, 1),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Filter',
                              style: TextStyle(
                                color: Colors.grey.shade700,
                                fontSize: 14,
                                fontFamily: 'Poppins',
                              ),
                            ),
                            const SizedBox(width: 4),
                            Icon(Iconsax.filter, size: 16, color: Colors.grey.shade700),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // Products grid with minimum height to ensure proper layout
                Container(
                  constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height * 0.6,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.8,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                      ),
                      itemCount: products.length + 1, // +1 for add button
                      itemBuilder: (context, index) {
                        if (index == products.length) {
                          // Add new product button
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const TambahProdukDetailScreen(),
                                ),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.green.shade50,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: Colors.green.shade200,
                                  width: 1.5,
                                  style: BorderStyle.solid,
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: Colors.green.shade100,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.add,
                                      size: 32,
                                      color: Colors.green.shade600,
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  Text(
                                    'Produk Baru',
                                    style: TextStyle(
                                      color: Colors.green.shade700,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Poppins',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }

                        final product = products[index];
                        return ProductCard(
                          product: product,
                          onTap: () {
                            // Navigate to FilledTambahProdukDetailScreen if product is Tomat Ciwi
                            if (product.name == 'Tomat Ciwi') {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const FilledTambahProdukDetailScreen(),
                                ),
                              );
                            }
                            // You can add navigation for other products here if needed
                          },
                        );
                      },
                    ),
                  ),
                ),

                // Bottom curved design - same as DetailKomoditasScreen
                _buildBottomCurvedDesign(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Bottom curved design method from DetailKomoditasScreen
  Widget _buildBottomCurvedDesign() {
    return Container(
      height: 120,
      width: double.infinity,
      child: CustomPaint(
        painter: CurvedBottomPainter(),
      ),
    );
  }
}


// Bottom curved painter - copied from DetailKomoditasScreen
class CurvedBottomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint1 = Paint()
      ..color = const Color(0xFF2E7D32).withOpacity(0.15)
      ..style = PaintingStyle.fill;

    final paint2 = Paint()
      ..color = const Color(0xFF388E3C).withOpacity(0.2)
      ..style = PaintingStyle.fill;

    final paint3 = Paint()
      ..color = const Color(0xFF1B5E20).withOpacity(0.12)
      ..style = PaintingStyle.fill;

    // First wave
    final path1 = Path();
    path1.moveTo(0, size.height * 0.4);
    path1.quadraticBezierTo(
      size.width * 0.25, size.height * 0.2,
      size.width * 0.5, size.height * 0.3,
    );
    path1.quadraticBezierTo(
      size.width * 0.75, size.height * 0.4,
      size.width, size.height * 0.4,
    );
    path1.lineTo(size.width, size.height);
    path1.lineTo(0, size.height);
    path1.close();

    // Second wave
    final path2 = Path();
    path2.moveTo(0, size.height * 0.6);
    path2.quadraticBezierTo(
      size.width * 0.4, size.height * 0.4,
      size.width * 0.6, size.height * 0.5,
    );
    path2.quadraticBezierTo(
      size.width * 0.8, size.height * 0.6,
      size.width, size.height * 0.6,
    );
    path2.lineTo(size.width, size.height);
    path2.lineTo(0, size.height);
    path2.close();

    // Third wave
    final path3 = Path();
    path3.moveTo(0, size.height * 0.8);
    path3.quadraticBezierTo(
      size.width * 0.5, size.height * 0.6,
      size.width * 0.75, size.height * 0.7,
    );
    path3.quadraticBezierTo(
      size.width * 0.9, size.height * 0.8,
      size.width, size.height * 0.8,
    );
    path3.lineTo(size.width, size.height);
    path3.lineTo(0, size.height);
    path3.close();

    canvas.drawPath(path1, paint1);
    canvas.drawPath(path2, paint2);
    canvas.drawPath(path3, paint3);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class ProductCard extends StatelessWidget {
  final ProductItem product;
  final VoidCallback? onTap; // Add onTap callback

  const ProductCard({super.key, required this.product, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector( // Wrap with GestureDetector
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.green.withOpacity(0.08),
              spreadRadius: 1,
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product image container
            Expanded(
              flex: 3,
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                ),
                child: Stack(
                  children: [
                    // Product image
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                      ),
                      child: Image.asset(
                        product.imagePath,
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          // Fallback to colored container if image fails to load
                          return Container(
                            width: double.infinity,
                            height: double.infinity,
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
                              size: 40,
                            ),
                          );
                        },
                      ),
                    ),
                    // Status badge
                    Positioned(
                      top: 8,
                      left: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: product.statusColor,
                          borderRadius: BorderRadius.circular(6),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              spreadRadius: 1,
                              blurRadius: 2,
                              offset: const Offset(0, 1),
                            ),
                          ],
                        ),
                        child: Text(
                          product.status,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Product details
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      product.name,
                      style: TextStyle(
                        color: Colors.grey.shade800,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Poppins',
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      product.weight,
                      style: TextStyle(
                        color: Colors.green.shade600,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProductItem {
  final String name;
  final String weight;
  final String status;
  final Color statusColor;
  final String imagePath;

  ProductItem({
    required this.name,
    required this.weight,
    required this.status,
    required this.statusColor,
    required this.imagePath,
  });
}