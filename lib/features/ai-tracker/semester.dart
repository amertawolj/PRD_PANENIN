import 'package:flutter/material.dart';

class SemesterScreen extends StatefulWidget {
  const SemesterScreen({super.key});

  @override
  State<SemesterScreen> createState() => _SemesterScreenState();
}

class _SemesterScreenState extends State<SemesterScreen> {
  bool _isSemester1Expanded = false;
  bool _isSemester2Expanded = false;

  final List<CommodityData> _commodities = [
    CommodityData(
      name: 'Tomat',
      price: 'Rp20.000,00/kg',
      prediction: 'Prediksi +Rp 2.000,00',
      trend: TrendType.up,
      icon: '🍅',
    ),
    CommodityData(
      name: 'Pisang',
      price: 'Rp30.000,00/kg',
      prediction: 'Prediksi -Rp 2.000,00',
      trend: TrendType.down,
      icon: '🍌',
    ),
    CommodityData(
      name: 'Jati',
      price: 'Rp48.000,00/kg',
      prediction: 'Prediksi -Rp 3.000,00',
      trend: TrendType.down,
      icon: '🌾',
    ),
  ];

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
          'Semester',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
            fontFamily: 'Poppins',
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Semester 1
            _buildSemesterCard(
              title: 'Semester 1',
              isExpanded: _isSemester1Expanded,
              onTap: () {
                setState(() {
                  _isSemester1Expanded = !_isSemester1Expanded;
                });
              },
              showCommodities: _isSemester1Expanded,
            ),

            const SizedBox(height: 16),

            // Semester 2
            _buildSemesterCard(
              title: 'Semester 2',
              isExpanded: _isSemester2Expanded,
              onTap: () {
                setState(() {
                  _isSemester2Expanded = !_isSemester2Expanded;
                });
              },
              showCommodities: _isSemester2Expanded,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSemesterCard({
    required String title,
    required bool isExpanded,
    required VoidCallback onTap,
    required bool showCommodities,
  }) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        color: const Color(0xFF3C5232),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        children: [
          // Header
          GestureDetector(
            onTap: onTap,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
              decoration: BoxDecoration(
                color: const Color(0xFF3C5232),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  Icon(
                    isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                    color: Colors.white,
                    size: 24,
                  ),
                ],
              ),
            ),
          ),

          // Expanded content
          if (showCommodities) ...[
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              decoration: const BoxDecoration(
                color: Color(0xFF3C5232),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                ),
              ),
              child: Column(
                children: _commodities.map((commodity) =>
                    _buildCommodityItem(commodity)
                ).toList(),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildCommodityItem(CommodityData commodity) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          // Commodity icon
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.orange[100],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                commodity.icon,
                style: const TextStyle(fontSize: 20),
              ),
            ),
          ),

          const SizedBox(width: 12),

          // Commodity info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  commodity.name,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                    fontFamily: 'Poppins',
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  commodity.price,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                    fontFamily: 'Poppins',
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  commodity.prediction,
                  style: TextStyle(
                    fontSize: 11,
                    color: commodity.trend == TrendType.up ? Colors.green : Colors.red,
                    fontFamily: 'Poppins',
                  ),
                ),
              ],
            ),
          ),

          // Trend indicator
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: commodity.trend == TrendType.up ? Colors.green[50] : Colors.red[50],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  commodity.trend == TrendType.up ? Icons.trending_up : Icons.trending_down,
                  size: 16,
                  color: commodity.trend == TrendType.up ? Colors.green : Colors.red,
                ),
                const SizedBox(width: 4),
                Text(
                  commodity.trend == TrendType.up ? 'naik' : 'turun',
                  style: TextStyle(
                    fontSize: 10,
                    color: commodity.trend == TrendType.up ? Colors.green : Colors.red,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Poppins',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CommodityData {
  final String name;
  final String price;
  final String prediction;
  final TrendType trend;
  final String icon;

  CommodityData({
    required this.name,
    required this.price,
    required this.prediction,
    required this.trend,
    required this.icon,
  });
}

enum TrendType { up, down }