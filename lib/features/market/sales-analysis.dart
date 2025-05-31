import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class SalesAnalysisScreen extends StatelessWidget {
  const SalesAnalysisScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Analisis Data Penjualan',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Monthly Sales Chart Section
              _buildMonthlyalesSection(),
              const SizedBox(height: 24),

              // Commodity Sales Section
              _buildCommoditySalesSection(),
              const SizedBox(height: 24),

              // Product Prices Section
              _buildProductPricesSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMonthlyalesSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Pemasukan Bulanan',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Detail Pemasukan Beberapa Bulan Terakhir (dalam Juta)',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 16),

          // Chart placeholder using dummy image
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: const DecorationImage(
                image: AssetImage('assets/image/graphdummy.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCommoditySalesSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Penjualan Komoditas',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 16),

          // Highest Sales
          const Text(
            'Penjualan Tertinggi - Maret 2025',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 12),

          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildCommodityCard(
                  'Cabe Rawit',
                  '232 kg',
                  '+20% dari April',
                  true,
                ),
                const SizedBox(width: 12),
                _buildCommodityCard(
                  'Terong Nangor',
                  '210 kg',
                  '+25% dari April',
                  true,
                ),
                const SizedBox(width: 12),
                _buildCommodityCard(
                  'Bawang',
                  '198 kg',
                  '+15% dari April',
                  true,
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Lowest Sales
          const Text(
            'Penjualan Terendah - Maret 2025',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 12),

          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildCommodityCard(
                  'Sawi',
                  '49 kg',
                  '-40% dari April',
                  false,
                ),
                const SizedBox(width: 12),
                _buildCommodityCard(
                  'Wortel',
                  '27 kg',
                  '-55% dari April',
                  false,
                ),
                const SizedBox(width: 12),
                _buildCommodityCard(
                  'Ubi Jalar',
                  '25 kg',
                  '-25% dari April',
                  false,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCommodityCard(String name, String amount, String percentage, bool isPositive) {
    return Container(
      width: 120, // Fixed width for horizontal scrolling
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.grey,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            amount,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(
                isPositive ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                size: 16,
                color: isPositive ? Colors.green : Colors.red,
              ),
              Expanded(
                child: Text(
                  percentage,
                  style: TextStyle(
                    fontSize: 10,
                    color: isPositive ? Colors.green : Colors.red,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProductPricesSection() {
    final products = [
      {'name': 'Cabe Rawit', 'weight': '232 kg', 'price': 'Rp47.500,00'},
      {'name': 'Bawang Merah', 'weight': '198 kg', 'price': 'Rp33.200,00'},
      {'name': 'Bawang Putih', 'weight': '123 kg', 'price': 'Rp29.900,00'},
      {'name': 'Sawi', 'weight': '49 kg', 'price': 'Rp25.200,00'},
      {'name': 'Wortel', 'weight': '27 kg', 'price': 'Rp24.400,00'},
    ];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                'Harga Jual Produk',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              const Spacer(),
              Text(
                '/kg',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          ...products.map((product) => _buildProductPriceItem(
            product['name']!,
            product['weight']!,
            product['price']!,
          )).toList(),
        ],
      ),
    );
  }

  Widget _buildProductPriceItem(String name, String weight, String price) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Terjual $weight',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          Text(
            price,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}