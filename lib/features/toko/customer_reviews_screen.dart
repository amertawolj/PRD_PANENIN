import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class CustomerReviewsScreen extends StatefulWidget {
  const CustomerReviewsScreen({super.key});

  @override
  State<CustomerReviewsScreen> createState() => _CustomerReviewsScreenState();
}

class _CustomerReviewsScreenState extends State<CustomerReviewsScreen> {
  String selectedFilter = 'Terbaru'; // Default filter

  // Sample reviews data
  final List<Map<String, dynamic>> reviews = [
    {
      'name': 'Andi',
      'time': '12:00',
      'rating': 5,
      'product': 'Tomat <B002>',
      'weight': '5 kg',
      'address': 'Jakarta, Kec Iv Kelca',
      'comment': 'Sayurnya segar, panen malam paginya dikirim',
      'avatar': 'assets/image/avatar1.jpg',
    },
    {
      'name': 'La ode..',
      'time': '11:46',
      'rating': 5,
      'product': 'Jati <K001>',
      'weight': '10 kg',
      'address': 'Sulawesi tenggara, raha, sampiri pantai',
      'comment': 'Mantap, saya ga sabar bikin pidio pake kayunya. Pengiriman cepat pk cargo.',
      'avatar': 'assets/image/avatar2.jpg',
      'hasImage': true,
      'productImages': [
        'assets/image/kayujati.jpg',
        'assets/image/kayujati.jpg',
      ],
    },
    {
      'name': 'Upik s..',
      'time': '11:34',
      'rating': 5,
      'product': 'Wortel <S002>',
      'weight': '5 kg',
      'address': 'Jakarta, Kec Iv Kelca',
      'comment': 'Buat paprikkan banyak diskon',
      'avatar': 'assets/image/avatar3.jpg',
    },
    {
      'name': 'Andi',
      'time': '11:22',
      'rating': 5,
      'product': 'Tomat <S002>',
      'weight': '5 kg',
      'address': 'Jakarta, Kec Iv Kelca',
      'comment': '',
      'avatar': 'assets/image/avatar4.jpg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: Column(
        children: [
          // Header
          Container(
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
                      onPressed: () => Navigator.pop(context),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'Ulasan Pelanggan',
                      style: TextStyle(
                        color: Colors.black,
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

          // Filter section
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Ulasan Terbaru',
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Poppins',
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Baca ulasan dari pelanggan kamu',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                    fontFamily: 'Poppins',
                  ),
                ),
                const SizedBox(height: 16),

                // Filter tabs
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _buildFilterTab('Terbaru', selectedFilter == 'Terbaru'),
                      const SizedBox(width: 12),
                      _buildFilterTab('Rating Tinggi', selectedFilter == 'Rating Tinggi'),
                      const SizedBox(width: 12),
                      _buildFilterTab('Rating Rendah', selectedFilter == 'Rating Rendah'),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Reviews list
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: reviews.length,
              itemBuilder: (context, index) {
                final review = reviews[index];
                return _buildReviewCard(review);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterTab(String label, bool isSelected) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedFilter = label;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF3C5232) : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? const Color(0xFF3C5232) : Colors.grey.shade300,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey.shade600,
            fontSize: 12,
            fontWeight: FontWeight.w500,
            fontFamily: 'Poppins',
          ),
        ),
      ),
    );
  }

  Widget _buildReviewCard(Map<String, dynamic> review) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
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
          // Header with avatar, name, time and rating
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFF8D6E63),
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage(review['avatar']),
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
                    size: 20,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          review['name'],
                          style: const TextStyle(
                            color: Colors.black87,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Poppins',
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              review['time'],
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 12,
                                fontFamily: 'Poppins',
                              ),
                            ),
                            const SizedBox(width: 4),
                            ...List.generate(
                              review['rating'],
                                  (index) => const Icon(
                                Icons.star,
                                color: Colors.amber,
                                size: 16,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Product info
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFF8F8F8),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Produk : ${review['product']}',
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    fontSize: 12,
                    fontFamily: 'Poppins',
                  ),
                ),
                Text(
                  'Jumlah : ${review['weight']}',
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    fontSize: 12,
                    fontFamily: 'Poppins',
                  ),
                ),
                Text(
                  'Alamat Penerima : ${review['address']}',
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    fontSize: 12,
                    fontFamily: 'Poppins',
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          // Product images if available
          if (review['hasImage'] == true) ...[
            Row(
              children: [
                ...List.generate(
                  (review['productImages'] as List).length,
                      (index) => Container(
                    margin: EdgeInsets.only(right: index < (review['productImages'] as List).length - 1 ? 8 : 0),
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                        image: AssetImage(review['productImages'][index]),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
          ],

          // Comment
          if (review['comment'].isNotEmpty) ...[
            Text(
              'Komentar : ${review['comment']}',
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 13,
                fontFamily: 'Poppins',
                height: 1.4,
              ),
            ),
          ],
        ],
      ),
    );
  }
}