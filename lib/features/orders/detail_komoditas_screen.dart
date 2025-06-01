import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class DetailKomoditasScreen extends StatelessWidget {
  const DetailKomoditasScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Iconsax.arrow_left_2, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Detail Komoditas',
          style: TextStyle(
            fontFamily: 'Poppins',
            color: Colors.black87,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Wilayah Konsumen Section
                  _buildSectionTitle('Wilayah Konsumen'),
                  const SizedBox(height: 16),
                  _buildConsumerRegionItem('Jakarta', 'Estimasi Permintaan', '1000 kg'),
                  const SizedBox(height: 12),
                  _buildConsumerRegionItem('Surabaya', 'Estimasi Permintaan', '800 kg'),
                  const SizedBox(height: 12),
                  _buildConsumerRegionItem('Bandung', 'Estimasi Permintaan', '600 kg'),

                  const SizedBox(height: 32),

                  // Permintaan Bulanan Section
                  _buildSectionTitle('Permintaan Bulanan'),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildMonthlyDemand('Januari', '1200 kg'),
                      _buildMonthlyDemand('Februari', '1100 kg'),
                      _buildMonthlyDemand('Maret', '1300 kg'),
                    ],
                  ),

                  const SizedBox(height: 32),

                  // Berita Terkait Section
                  _buildSectionTitle('Berita Terkait'),
                  const SizedBox(height: 16),
                  _buildNewsItem(
                    'Kenaikan Harga Tomat di Pasar',
                    'Mengapa Ini Terjadi?',
                  ),
                  const SizedBox(height: 12),
                  _buildNewsItem(
                    'Tips Menanam Tomat yang Menguntungkan',
                    'Untuk Petani',
                  ),
                  const SizedBox(height: 12),
                  _buildNewsItem(
                    'Analisis Pasar Tomat 2023',
                    'Tren dan Prediksi',
                  ),
                ],
              ),
            ),
            // Bottom curved design
            _buildBottomCurvedDesign(),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontFamily: 'Poppins',
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Colors.black87,
      ),
    );
  }

  Widget _buildConsumerRegionItem(String city, String subtitle, String amount) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.blue.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(
            Iconsax.chart,
            color: Colors.blue,
            size: 20,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                city,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
              Text(
                subtitle,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
        Text(
          amount,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }

  Widget _buildMonthlyDemand(String month, String amount) {
    return Column(
      children: [
        Text(
          month,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          amount,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }

  Widget _buildNewsItem(String title, String subtitle) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          child: const Icon(
            Iconsax.document_text,
            color: Colors.grey,
            size: 20,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

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