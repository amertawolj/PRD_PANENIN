import 'package:flutter/material.dart';

class MasukPage extends StatefulWidget {
  @override
  State<MasukPage> createState() => _MasukPageState();
}

class _MasukPageState extends State<MasukPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

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
                // Header with back button
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                        onPressed: () => Navigator.pop(context),
                      ),
                      Text(
                        'Masuk',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          fontFamily: 'Poppins',
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
                          'assets/image/Group 35@2x.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                ),

                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        children: [
                          SizedBox(height: 40),

                          // Logo illustration
                          Container(
                            width: 150,
                            height: 150,
                            child: Image.asset(
                              'assets/image/Group 35@2x.png',
                              fit: BoxFit.contain,
                            ),
                          ),
                          SizedBox(height: 40),

                          // Login form
                          Container(
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.95),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Email/Username field
                                _buildTextField(
                                  'Username, Nomor Telepon, atau Email',
                                  _emailController,
                                  false,
                                ),
                                SizedBox(height: 16),

                                // Password field
                                _buildTextField(
                                  'Password',
                                  _passwordController,
                                  true,
                                ),
                                SizedBox(height: 8),

                                // Forgot password
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: TextButton(
                                    onPressed: () {
                                      // Handle forgot password
                                    },
                                    child: Text(
                                      'Lupa password?',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFF2D5016),
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'Poppins',
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 16),

                                // Login button
                                Container(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      // Handle login
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Color(0xFF2D5016),
                                      padding: EdgeInsets.symmetric(vertical: 16),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    child: Text(
                                      'Lanjut!',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: 'Poppins',
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 24),

                                // Divider
                                Row(
                                  children: [
                                    Expanded(
                                      child: Divider(
                                        color: Colors.grey[400],
                                        thickness: 1,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 16),
                                      child: Text(
                                        'Atau',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey[600],
                                          fontFamily: 'Poppins',
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Divider(
                                        color: Colors.grey[400],
                                        thickness: 1,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 24),

                                // Social login buttons
                                _buildSocialButton(
                                  'Masuk dengan Google',
                                  Icons.g_mobiledata,
                                      () {
                                    // Handle Google login
                                  },
                                ),
                                SizedBox(width: 12),
                                _buildSocialButton(
                                  'Masuk dengan Apple',
                                  Icons.apple,
                                      () {
                                    // Handle Apple login
                                  },
                                ),
                                SizedBox(width: 12),
                                _buildSocialButton(
                                  'Masuk dengan kode OTP',
                                  Icons.phone,
                                      () {
                                    // Handle OTP login
                                  },
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 40),
                        ],
                      ),
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

  Widget _buildTextField(String label, TextEditingController controller, bool isPassword) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: controller,
          obscureText: isPassword ? _obscurePassword : false,
          decoration: InputDecoration(
            hintText: label,
            hintStyle: TextStyle(
              color: Colors.grey[500],
              fontSize: 14,
              fontFamily: 'Poppins',
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Color(0xFF2D5016)),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            suffixIcon: isPassword
                ? IconButton(
              icon: Icon(
                _obscurePassword ? Icons.visibility_off : Icons.visibility,
                color: Colors.grey[600],
              ),
              onPressed: () {
                setState(() {
                  _obscurePassword = !_obscurePassword;
                });
              },
            )
                : null,
          ),
        ),
      ],
    );
  }

  Widget _buildSocialButton(String text, IconData icon, VoidCallback onPressed) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 12),
      child: OutlinedButton.icon(
        onPressed: onPressed,
        icon: Icon(
          icon,
          color: Colors.black87,
          size: 20,
        ),
        label: Text(
          text,
          style: TextStyle(
            fontSize: 14,
            color: Colors.black87,
            fontWeight: FontWeight.w500,
            fontFamily: 'Poppins',
          ),
        ),
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 14),
          side: BorderSide(color: Colors.grey[300]!),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
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