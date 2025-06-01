import 'package:flutter/material.dart';
import 'masuk_screen.dart';
import 'daftar_screen.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2D5016),
      body: Stack(
        children: [
          // Background waves
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: CustomPaint(
              size: Size(MediaQuery.of(context).size.width, 400),
              painter: WavePainter(),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                // Top bar with logo and flag
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/image/logopanenin.png',
                        width: 32,
                        height: 32,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'PANENin',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          fontFamily: 'Fredoka',
                        ),
                      ),
                      Spacer(),
                      Text(
                        'INA',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(width: 4),
                      Container(
                        width: 20,
                        height: 14,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2),
                        ),
                        child: Image.asset(
                          'assets/image/logopanenin.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                ),

                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Main logo/illustration
                        Container(
                          width: 200,
                          height: 200,
                          child: Image.asset(
                            'assets/image/logopanenin.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                        SizedBox(height: 40),

                        // Main title
                        Text(
                          'PANENin',
                          style: TextStyle(
                            fontSize: 48,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                            fontFamily: 'Fredoka',
                          ),
                        ),
                        SizedBox(height: 8),

                        // Subtitle
                        Text(
                          'Kita PANENin buat Kamu!',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black87,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Poppins',
                          ),
                        ),
                        SizedBox(height: 60),

                        // Login button
                        Container(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MasukPage(),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF2D5016),
                              padding: EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text(
                              'Masuk',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),

                        // Register section
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Belum punya akun?',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black54,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 12),

                        Container(
                          width: double.infinity,
                          child: OutlinedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DaftarPage(),
                                ),
                              );
                            },
                            style: OutlinedButton.styleFrom(
                              padding: EdgeInsets.symmetric(vertical: 16),
                              side: BorderSide(color: Color(0xFF2D5016), width: 2),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              backgroundColor: Colors.transparent,
                            ),
                            child: Text(
                              'Daftar',
                              style: TextStyle(
                                fontSize: 16,
                                color: Color(0xFF2D5016),
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),

                        // Terms text
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.black54,
                                height: 1.4,
                                fontFamily: 'Poppins',
                              ),
                              children: [
                                TextSpan(
                                  text: 'Dengan masuk atau mendaftar, anda menyetujui ',
                                ),
                                TextSpan(
                                  text: 'Syarat & Ketentuan',
                                  style: TextStyle(
                                    color: Color(0xFF2D5016),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                TextSpan(text: ' serta '),
                                TextSpan(
                                  text: 'Kebijakan Privasi Kami',
                                  style: TextStyle(
                                    color: Color(0xFF2D5016),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                TextSpan(text: '.'),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
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

// Custom Wave Painter
class WavePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint1 = Paint()
      ..color = Color(0xFFF5F5DC) // Light beige
      ..style = PaintingStyle.fill;

    final paint2 = Paint()
      ..color = Color(0xFFE6E6B8) // Slightly darker beige
      ..style = PaintingStyle.fill;

    // First wave
    final path1 = Path();
    path1.moveTo(0, size.height * 0.3);
    path1.quadraticBezierTo(
      size.width * 0.25, size.height * 0.1,
      size.width * 0.5, size.height * 0.2,
    );
    path1.quadraticBezierTo(
      size.width * 0.75, size.height * 0.3,
      size.width, size.height * 0.1,
    );
    path1.lineTo(size.width, size.height);
    path1.lineTo(0, size.height);
    path1.close();

    // Second wave
    final path2 = Path();
    path2.moveTo(0, size.height * 0.5);
    path2.quadraticBezierTo(
      size.width * 0.3, size.height * 0.3,
      size.width * 0.6, size.height * 0.4,
    );
    path2.quadraticBezierTo(
      size.width * 0.8, size.height * 0.45,
      size.width, size.height * 0.35,
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