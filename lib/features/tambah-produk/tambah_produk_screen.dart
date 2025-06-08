import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'tambah_produk_detail_screen.dart';
import 'filled_tambah_produk_detail_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class TambahProdukScreen extends StatefulWidget {
  const TambahProdukScreen({super.key});

  @override
  State<TambahProdukScreen> createState() => _TambahProdukScreenState();
}

class _TambahProdukScreenState extends State<TambahProdukScreen> {
  int selectedTab = 0; // 0 for Terbaru, 1 for Terlaris
  List<ProductItem> products = []; // Empty list initially
  bool isLoading = true; // To show loading state
  final SupabaseClient supabase = Supabase.instance.client;

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    try {
      print('Loading products...');
      print('Current user ID: ${supabase.auth.currentUser?.id}');

      final response = await supabase
          .from('products')
          .select()
          .eq('uid', supabase.auth.currentUser?.id ?? '');

      print('Response: $response');
      print('Number of products: ${response.length}');

      setState(() {
        products = response.map<ProductItem>((product) => ProductItem(
          id: product['id'].toString(),
          name: product['product_name'] ?? '',
          weight: '${product['stok']} kg',
          price: 'Rp ${product['price'] ?? 0}',
          status: product['stok'] > 0 ? 'Tersedia' : 'Habis',
          statusColor: product['stok'] > 0 ? Colors.green : Colors.red,
          imagePath: product['image_url'] ?? 'assets/default_product.png',
        )).toList();
        isLoading = false;
      });
    } catch (e) {
      print('Error loading products: $e');
      setState(() => isLoading = false);
    }
  }

  Future<void> _deleteProduct(ProductItem product) async {
    // Show confirmation dialog
    bool? confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Hapus Produk'),
        content: Text('Apakah Anda yakin ingin menghapus ${product.name}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text('Batal'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text('Hapus', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirm == true) {
      try {
        await supabase.from('products').delete().eq('id', product.id);
        _loadProducts(); // Refresh the list
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Produk berhasil dihapus')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal menghapus produk: $e')),
        );
      }
    }
  }

  void _editProduct(ProductItem product) {
    // Navigate to the same add screen (without edit functionality)
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TambahProdukDetailScreen(
          productData: product.toMap(), // Your product data map
          isEditing: true,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAF8),
      body: Column(
        children: [
          // Compact App Bar
          Container(
            color: Colors.white,
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios, color: Colors.black87, size: 20),
                      onPressed: () => Navigator.pop(context),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(minWidth: 24, minHeight: 24),
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'Tambah Produk',
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Scrollable content
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 12),

                  // Compact header
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: const Text(
                      'Restok dan menambahkan produk baru',
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Compact Search Bar
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.green.shade200, width: 0.5),
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Cari produk...',
                          hintStyle: TextStyle(
                            color: Colors.grey.shade500,
                            fontSize: 13,
                            fontFamily: 'Poppins',
                          ),
                          prefixIcon: Icon(
                            Iconsax.search_normal,
                            color: Colors.grey.shade500,
                            size: 18,
                          ),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        ),
                        style: TextStyle(
                          color: Colors.grey.shade700,
                          fontSize: 13,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Tab bar and filter section
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        // Terbaru tab
                        GestureDetector(
                          onTap: () => setState(() => selectedTab = 0), // Fixed: Added missing onTap
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color: selectedTab == 0 ? Color(0xFF3C5232) : Colors.transparent,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              'Terbaru',
                              style: TextStyle(
                                color: selectedTab == 0 ? Colors.white : Colors.grey.shade600,
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(width: 12),

                        // Terlaris tab
                        GestureDetector(
                          onTap: () => setState(() => selectedTab = 1),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color: selectedTab == 1 ? Color(0xFF3C5232) : Colors.transparent,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              'Terlaris',
                              style: TextStyle(
                                color: selectedTab == 1 ? Colors.white : Colors.grey.shade600,
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ),
                        ),

                        const Spacer(),

                        // Compact filter button
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.grey.shade300, width: 0.5),
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.08),
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
                                  color: Colors.grey.shade600,
                                  fontSize: 13,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                              const SizedBox(width: 4),
                              Icon(Iconsax.filter, size: 14, color: Colors.grey.shade600),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Products grid with better mobile sizing
                  Container(
                    constraints: BoxConstraints(
                      minHeight: MediaQuery.of(context).size.height * 0.5,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.75,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                        itemCount: isLoading ? 1 : products.length + 1,
                        itemBuilder: (context, index) {
                          if (index == 0) {
                            if (isLoading) {
                              return Center(child: CircularProgressIndicator());
                            }
                            // Add new product button
                            return GestureDetector(
                              onTap: () async {
                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const TambahProdukDetailScreen(),
                                  ),
                                );
                                _loadProducts(); // Refresh products when returning
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.green.shade50,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: Colors.green.shade200,
                                    width: 1,
                                    style: BorderStyle.solid,
                                  ),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: Colors.green.shade100,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        Icons.add,
                                        size: 24,
                                        color: Color(0xFF3C5232),
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      'Produk Baru',
                                      style: TextStyle(
                                        color: Colors.green.shade700,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'Poppins',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }
                          final product = products[index - 1];
                          return ProductCard(
                            product: product,
                            onTap: () {
                              // Navigate to product detail if needed
                              // You can add navigation logic here
                            },
                            onEdit: () => _editProduct(product),
                            onDelete: () => _deleteProduct(product),
                          );
                        },
                      ),
                    ),
                  ),

                  // Bottom curved design
                  _buildBottomCurvedDesign(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomCurvedDesign() {
    return Container(
      height: 80, // Reduced height for mobile
      width: double.infinity,
      child: CustomPaint(
        painter: CurvedBottomPainter(),
      ),
    );
  }
}

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
  final VoidCallback? onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const ProductCard({
    super.key,
    required this.product,
    this.onTap,
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.green.withOpacity(0.06),
              spreadRadius: 1,
              blurRadius: 4,
              offset: const Offset(0, 2),
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
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
                child: Stack(
                  children: [
                    // Product image
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                      child: product.imagePath.startsWith('http')
                          ? Image.network(
                        product.imagePath,
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
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
                            child: Center(
                              child: Icon(
                                Icons.eco,
                                color: Colors.green.shade400,
                                size: 32,
                              ),
                            ),
                          );
                        },
                      )
                          : Image.asset(
                        product.imagePath,
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
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
                            child: Center(
                              child: Icon(
                                Icons.eco,
                                color: Colors.green.shade400,
                                size: 32,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    // Status badge
                    Positioned(
                      top: 6,
                      left: 6,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                        decoration: BoxDecoration(
                          color: product.statusColor,
                          borderRadius: BorderRadius.circular(4),
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
                            fontSize: 9,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ),
                    ),
                    // Edit and Delete buttons
                    Positioned(
                      top: 6,
                      right: 6,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (onEdit != null)
                            GestureDetector(
                              onTap: onEdit,
                              child: Container(
                                padding: EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: Colors.blue.withOpacity(0.8),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Icon(Icons.edit, color: Colors.white, size: 12),
                              ),
                            ),
                          SizedBox(width: 4),
                          if (onDelete != null)
                            GestureDetector(
                              onTap: onDelete,
                              child: Container(
                                padding: EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: Colors.red.withOpacity(0.8),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Icon(Icons.delete, color: Colors.white, size: 12),
                              ),
                            ),
                        ],
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
                padding: const EdgeInsets.all(8),
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
      ),
    );
  }
}

class ProductItem {
  final String id;
  final String name;
  final String weight;
  final String price;
  final String status;
  final Color statusColor;
  final String imagePath;

  // Tambahan field untuk form/detail
  final String? description;
  final double? moq;
  final String? category;
  final DateTime? tanamDate;
  final DateTime? panenDate;
  final DateTime? kadaluarsaDate;
  final List<String>? penyimpanan;

  ProductItem({
    required this.id,
    required this.name,
    required this.weight,
    required this.price,
    required this.status,
    required this.statusColor,
    required this.imagePath,
    this.description,
    this.moq,
    this.category,
    this.tanamDate,
    this.panenDate,
    this.kadaluarsaDate,
    this.penyimpanan,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nama': name,
      'deskripsi': description,
      'stok': int.tryParse(weight.replaceAll(' kg', '')) ?? 0,
      'harga': int.tryParse(price.replaceAll('Rp ', '').replaceAll(',', '')) ?? 0,
      'moq': moq,
      'kategori': category,
      'tanam': tanamDate?.toIso8601String(),
      'panen': panenDate?.toIso8601String(),
      'kadaluarsa': kadaluarsaDate?.toIso8601String(),
      'penyimpanan': penyimpanan?.join(', '),
      'image_url': imagePath,
    };
  }

  factory ProductItem.fromMap(Map<String, dynamic> map) {
    return ProductItem(
      id: map['id'],
      name: map['nama'],
      weight: "${map['stok']} kg",
      price: "Rp ${map['harga']}",
      status: 'Tersedia',
      statusColor: Colors.green,
      imagePath: map['image_url'] ?? '',
      description: map['deskripsi'],
      moq: (map['moq'] as num?)?.toDouble(),
      category: map['kategori'],
      tanamDate: map['tanam'] != null ? DateTime.parse(map['tanam']) : null,
      panenDate: map['panen'] != null ? DateTime.parse(map['panen']) : null,
      kadaluarsaDate: map['kadaluarsa'] != null ? DateTime.parse(map['kadaluarsa']) : null,
      penyimpanan: map['penyimpanan']?.toString().split(', '),
    );
  }
}
