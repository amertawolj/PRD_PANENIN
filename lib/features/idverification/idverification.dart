import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'dart:io';

class IdVerificationScreen extends StatefulWidget {
  @override
  _IdVerificationScreenState createState() => _IdVerificationScreenState();
}

class _IdVerificationScreenState extends State<IdVerificationScreen> {
  int currentStep = 0;
  File? idCardImage;
  File? faceImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Validasi ID',
          style: TextStyle(
            color: Color(0xFF4A5D23),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: IndexedStack(
        index: currentStep,
        children: [
          _buildIdentitySelectionStep(),
          _buildIdCardCaptureStep(),
          _buildFaceCaptureStep(),
          _buildSuccessStep(),
        ],
      ),
    );
  }

  Widget _buildIdentitySelectionStep() {
    return Padding(
      padding: EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Validasi Identitas',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Pastikan identitas anda telah terverifikasi untuk lanjut.',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
          SizedBox(height: 16),
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '** Data pribadi Anda dijamin aman dan sesuai dengan Ketentuan Layanan dan Kebijakan Privasi dari masing-masing pihak untuk mematuhi peraturan otoritas terkait.',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'Verifikasi Identitas akan dilakukan dengan:',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 8),
                Text('Tahap I: Pindai Kartu Identitas'),
                Text('Tahap II: Verifikasi wajah'),
              ],
            ),
          ),
          SizedBox(height: 32),
          Text(
            'Tipe Identitas',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),
          Row(
            children: [
              _buildIdentityTypeButton('KTP', true),
              SizedBox(width: 12),
              _buildIdentityTypeButton('SIM', false),
              SizedBox(width: 12),
              _buildIdentityTypeButton('Passport', false),
            ],
          ),
          SizedBox(height: 8),
          Text(
            'Pilih tipe identitas untuk verifikasi.',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
          Spacer(),
          _buildBottomButtons(),
        ],
      ),
    );
  }

  Widget _buildIdCardCaptureStep() {
    return Padding(
      padding: EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Tahap I : Pindai Identitas',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 32),
          Expanded(
            child: Column(
              children: [
                Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[400]!, width: 2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: idCardImage != null
                      ? ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.file(
                      idCardImage!,
                      fit: BoxFit.cover,
                    ),
                  )
                      : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.credit_card,
                        size: 64,
                        color: Colors.grey[400],
                      ),
                      SizedBox(height: 16),
                      ElevatedButton.icon(
                        onPressed: () => _captureIdCard(),
                        icon: Icon(Icons.camera_alt),
                        label: Text('Ambil Foto KTP'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF4A5D23),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24),
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'Pastikan Anda berada di tempat yang terang. Mohon sesuaikan penempatan Kartu Identitas dengan garis pembantu.',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[700],
                    ),
                  ),
                ),
                SizedBox(height: 32),
                _buildFormFields(),
              ],
            ),
          ),
          _buildBottomButtons(),
        ],
      ),
    );
  }

  Widget _buildFaceCaptureStep() {
    return Padding(
      padding: EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Tahap II : Verifikasi Wajah',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 64),
          Expanded(
            child: Column(
              children: [
                Container(
                  height: 300,
                  width: 250,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[400]!, width: 3),
                    borderRadius: BorderRadius.circular(150),
                  ),
                  child: faceImage != null
                      ? ClipOval(
                    child: Image.file(
                      faceImage!,
                      fit: BoxFit.cover,
                    ),
                  )
                      : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.face,
                        size: 80,
                        color: Colors.grey[400],
                      ),
                      SizedBox(height: 16),
                      ElevatedButton.icon(
                        onPressed: () => _captureFace(),
                        icon: Icon(Icons.camera_alt),
                        label: Text('Ambil Foto Wajah'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF4A5D23),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 32),
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'Pastikan Anda berada di tempat yang terang dan wajah Anda tidak tertutup oleh kacamata, rambut atau aksesoris. Mohon sesuaikan penempatan wajah dengan garis pembantu.',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[700],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          _buildBottomButtons(),
        ],
      ),
    );
  }

  Widget _buildSuccessStep() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF8FBC8F), Color(0xFF4A5D23)],
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Permintaan Verifikasi\nBerhasil Terkirim!',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(0xFF4A5D23),
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 48),
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Color(0xFF4A5D23),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.check,
                color: Colors.white,
                size: 50,
              ),
            ),
            SizedBox(height: 48),
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                'Verifikasi identitas Anda dilakukan oleh tim kami dengan waktu maksimal 2x24 jam. Kami akan memberikan notifikasi apabila verifikasi berhasil selesai!',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 48),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.popUntil(context, (route) => route.isFirst),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF4A5D23),
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Kembali ke Halaman Utama',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIdentityTypeButton(String text, bool isSelected) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? Color(0xFF4A5D23) : Colors.grey[200],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildFormFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTextField('NIK'),
        SizedBox(height: 16),
        _buildTextField('Nama Lengkap'),
        SizedBox(height: 16),
        _buildTextField('Tanggal Lahir'),
        SizedBox(height: 16),
        _buildTextField('Alamat'),
        SizedBox(height: 16),
        _buildTextField('Pekerjaan'),
      ],
    );
  }

  Widget _buildTextField(String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 8),
        TextField(
          decoration: InputDecoration(
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
              borderSide: BorderSide(color: Color(0xFF4A5D23)),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomButtons() {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: currentStep > 0 ? () => setState(() => currentStep--) : null,
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: Color(0xFF4A5D23)),
              padding: EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              'Batalkan',
              style: TextStyle(
                color: Color(0xFF4A5D23),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          child: ElevatedButton(
            onPressed: _canProceed() ? _nextStep : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF4A5D23),
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              'Lanjutkan',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }

  bool _canProceed() {
    switch (currentStep) {
      case 0:
        return true; // Always can proceed from selection
      case 1:
        return idCardImage != null; // Can proceed if ID card is captured
      case 2:
        return faceImage != null; // Can proceed if face is captured
      default:
        return false;
    }
  }

  void _nextStep() {
    if (currentStep < 3) {
      setState(() {
        currentStep++;
      });
    }
  }

  Future<void> _captureIdCard() async {
    final image = await _captureImage();
    if (image != null) {
      setState(() {
        idCardImage = image;
      });
    }
  }

  Future<void> _captureFace() async {
    final image = await _captureImage();
    if (image != null) {
      setState(() {
        faceImage = image;
      });
    }
  }

  Future<File?> _captureImage() async {
    // Navigate to camera screen and return captured image
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CameraScreen(),
      ),
    );
    return result;
  }
}

class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController? _controller;
  List<CameraDescription>? cameras;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    cameras = await availableCameras();
    if (cameras!.isNotEmpty) {
      _controller = CameraController(
        cameras![0],
        ResolutionPreset.high,
      );

      await _controller!.initialize();
      if (mounted) {
        setState(() {
          _isInitialized = true;
        });
      }
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInitialized) {
      return Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: CircularProgressIndicator(
            color: Color(0xFF4A5D23),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Camera preview
          Positioned.fill(
            child: CameraPreview(_controller!),
          ),

          // Overlay with frame guide
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.3),
              ),
              child: Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.height * 0.5,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Color(0xFF4A5D23),
                      width: 3,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ),

          // Top bar
          Positioned(
            top: MediaQuery.of(context).padding.top,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(Icons.close, color: Colors.white, size: 28),
                  ),
                  Spacer(),
                  Text(
                    'Posisikan dalam frame',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Spacer(),
                  SizedBox(width: 44),
                ],
              ),
            ),
          ),

          // Bottom controls
          Positioned(
            bottom: MediaQuery.of(context).padding.bottom + 32,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Text(
                  'Pastikan foto jelas dan tidak buram',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 24),
                GestureDetector(
                  onTap: _takePicture,
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      border: Border.all(
                        color: Color(0xFF4A5D23),
                        width: 4,
                      ),
                    ),
                    child: Icon(
                      Icons.camera_alt,
                      color: Color(0xFF4A5D23),
                      size: 32,
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

  Future<void> _takePicture() async {
    try {
      final XFile picture = await _controller!.takePicture();
      Navigator.pop(context, File(picture.path));
    } catch (e) {
      print('Error taking picture: $e');
    }
  }
}