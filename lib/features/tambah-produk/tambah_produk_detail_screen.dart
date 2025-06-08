import 'dart:io';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prd_tubes/services/product_service.dart';

class TambahProdukDetailScreen extends StatefulWidget {
  const TambahProdukDetailScreen({super.key});

  @override
  State<TambahProdukDetailScreen> createState() => _TambahProdukDetailScreenState();
}

class _TambahProdukDetailScreenState extends State<TambahProdukDetailScreen> {
  final ProductService _productService = ProductService();

  final TextEditingController namaController = TextEditingController();
  final TextEditingController deskripsiController = TextEditingController();
  final TextEditingController kuantitasController = TextEditingController();
  final TextEditingController tanggalTanamController = TextEditingController();
  final TextEditingController tanggalPanenController = TextEditingController();
  final TextEditingController hariController = TextEditingController();
  final TextEditingController bulanController = TextEditingController();
  final TextEditingController tahunController = TextEditingController();
  final TextEditingController hargaController = TextEditingController();
  final TextEditingController stokController = TextEditingController();

  String selectedCategory = 'Buah';
  bool isPenyimpananDropdownOpen = false;
  List<String> selectedPenyimpanan = [];

  final List<String> categories = ['Buah', 'Sayur', 'Kacang'];
  List<String> units = ['Kg', 'Gram', 'Ton'];
  final List<String> penyimpananOptions = [
    'Suhu Ruang',
    'Kulkas',
    'Freezer',
    'Tempat Kering',
    'Hindari Sinar Matahari',
    'Wadah Kedap Udara'
  ];

  //image picker
  final ImagePicker _picker = ImagePicker();
  XFile? _pickedImage;
  Future<void> pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _pickedImage = image;
      });
      print('File path: ${image.path}');
    }
  }

  Future<void> _selectTanggalTanam() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.green.shade600,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        tanggalTanamController.text =
        "${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}";
      });
    }
  }

  Future<void> _selectTanggalPanen() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.green.shade600,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        tanggalPanenController.text =
        "${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}";
      });
    }
  }

  Widget _buildPenyimpananChip(String option) {
    bool isSelected = selectedPenyimpanan.contains(option);
    return GestureDetector(
      onTap: () {
        setState(() {
          if (isSelected) {
            selectedPenyimpanan.remove(option);
          } else {
            selectedPenyimpanan.add(option);
          }
        });
      },
      child: Container(
        margin: const EdgeInsets.only(right: 8, bottom: 8),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
        decoration: BoxDecoration(
          color: isSelected ? Colors.green.shade100 : Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: isSelected ? Colors.green.shade400 : Colors.grey.shade300,
          ),
          boxShadow: isSelected ? [
            BoxShadow(
              color: Colors.green.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 3,
              offset: const Offset(0, 2),
            ),
          ] : null,
        ),
        child: Text(
          option,
          style: TextStyle(
            color: isSelected ? Colors.green.shade700 : Colors.grey.shade600,
            fontSize: 13,
            fontWeight: isSelected ? FontWeight.w500 : FontWeight.w400,
            fontFamily: 'Poppins',
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAF8),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Tambah Produk',
          style: TextStyle(
            color: Colors.black87,
            fontSize: 18,
            fontWeight: FontWeight.w600,
            fontFamily: 'Poppins',
          ),
        ),
        centerTitle: false,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image picker section (aligned left)
                  Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: pickImage,
                      child: Container(
                        width: 90,
                        height: 90,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Colors.green.shade100,
                              Colors.green.shade200,
                            ],
                          ),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.green.shade300,
                            width: 1.5,
                          ),
                          image: _pickedImage != null
                              ? DecorationImage(
                            image: FileImage(File(_pickedImage!.path)),
                            fit: BoxFit.cover,
                          )
                              : null,
                        ),
                        child: _pickedImage == null
                            ? Icon(
                          Icons.add_a_photo,
                          size: 28,
                          color: Colors.green.shade600,
                        )
                            : null,
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Category section
                  Text(
                    'Kategori Produk',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Poppins',
                      color: Colors.grey.shade800,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Pilih kategori produk',
                    style: TextStyle(
                      fontSize: 12,
                      fontFamily: 'Poppins',
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Category chips - Made flexible to prevent overflow
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: categories.map((category) {
                        bool isSelected = selectedCategory == category;
                        return Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: GestureDetector(
                            onTap: () => setState(() => selectedCategory = category),
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
                              decoration: BoxDecoration(
                                color: isSelected ? Colors.green.shade100 : Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: isSelected ? Colors.green.shade400 : Colors.grey.shade300,
                                ),
                                boxShadow: isSelected ? [
                                  BoxShadow(
                                    color: Colors.green.withOpacity(0.2),
                                    spreadRadius: 1,
                                    blurRadius: 3,
                                    offset: const Offset(0, 2),
                                  ),
                                ] : null,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    category == 'Buah' ? Icons.apple :
                                    category == 'Sayur' ? Icons.eco : Icons.grain,
                                    size: 15,
                                    color: isSelected ? Colors.green.shade600 : Colors.grey,
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    category,
                                    style: TextStyle(
                                      color: isSelected ? Colors.green.shade700 : Colors.grey,
                                      fontSize: 13,
                                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                                      fontFamily: 'Poppins',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Product name field
                  Text(
                    'Nama Produk',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Poppins',
                      color: Colors.grey.shade800,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: namaController,
                    decoration: InputDecoration(
                      hintText: '0/200 karakter',
                      hintStyle: const TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                        fontFamily: 'Poppins',
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.green.shade400, width: 2),
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Product description field
                  Text(
                    'Deskripsi Produk',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Poppins',
                      color: Colors.grey.shade800,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: deskripsiController,
                    maxLines: 3,
                    decoration: InputDecoration(
                      hintText: '12/1000 karakter',
                      hintStyle: const TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                        fontFamily: 'Poppins',
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.green.shade400, width: 2),
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                  ),

                  const SizedBox(height: 20),
                  Text(
                    'Harga per Kg',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Poppins',
                      color: Colors.grey.shade800,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: const Text(
                          'Rp',
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Poppins',
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TextField(
                          controller: hargaController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: 'Masukkan harga',
                            hintStyle: const TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                              fontFamily: 'Poppins',
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: Colors.grey.shade300),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: Colors.grey.shade300),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: Colors.green.shade400, width: 2),
                            ),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),
                  Text(
                    'Stok',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Poppins',
                      color: Colors.grey.shade800,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: const Text(
                          'Kg',
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Poppins',
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TextField(
                          controller: stokController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: 'Stok',
                            hintStyle: const TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                              fontFamily: 'Poppins',
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: Colors.grey.shade300),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: Colors.grey.shade300),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: Colors.green.shade400, width: 2),
                            ),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Quantity section (fixed kg unit)
                  Text(
                    'Kuantitas Minimum Pemesanan',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Poppins',
                      color: Colors.grey.shade800,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: kuantitasController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: 'min 0.5',
                            hintStyle: const TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                              fontFamily: 'Poppins',
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: Colors.grey.shade300),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: Colors.grey.shade300),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: Colors.green.shade400, width: 2),
                            ),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: const Text(
                          'kg',
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Poppins',
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Tanggal Tanam field
                  Text(
                    'Tanggal Tanam',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Poppins',
                      color: Colors.grey.shade800,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Sesuaikan waktu tanam dan panen, dapatkan notifikasi ketika waktu panen sudah dekat',
                    style: TextStyle(
                      fontSize: 12,
                      fontFamily: 'Poppins',
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: () => _selectTanggalTanam(),
                    child: AbsorbPointer(
                      child: TextField(
                        controller: tanggalTanamController,
                        decoration: InputDecoration(
                          hintText: 'HH/BB/TTTT',
                          hintStyle: const TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                            fontFamily: 'Poppins',
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          suffixIcon: Icon(
                            Icons.calendar_today,
                            color: Colors.green.shade600,
                            size: 20,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Colors.grey.shade300),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Colors.grey.shade300),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Colors.green.shade400, width: 2),
                          ),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Tanggal Panen field
                  Text(
                    'Tanggal Panen',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Poppins',
                      color: Colors.grey.shade800,
                    ),
                  ),
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: () => _selectTanggalPanen(),
                    child: AbsorbPointer(
                      child: TextField(
                        controller: tanggalPanenController,
                        decoration: InputDecoration(
                          hintText: 'HH/BB/TTTT',
                          hintStyle: const TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                            fontFamily: 'Poppins',
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          suffixIcon: Icon(
                            Icons.calendar_today,
                            color: Colors.green.shade600,
                            size: 20,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Colors.grey.shade300),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Colors.grey.shade300),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Colors.green.shade400, width: 2),
                          ),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Consumption period section - Made flexible to prevent overflow
                  Text(
                    'Baik Dikonsumsi Sebelum',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Poppins',
                      color: Colors.grey.shade800,
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Flexible row for consumption period
                  Row(
                    children: [
                      // Hari
                      Flexible(
                        child: Row(
                          children: [
                            SizedBox(
                              width: 45,
                              child: TextField(
                                controller: hariController,
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                  hintText: '0',
                                  hintStyle: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14,
                                    fontFamily: 'Poppins',
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(color: Colors.grey.shade300),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(color: Colors.grey.shade300),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(color: Colors.green.shade400, width: 2),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                                ),
                              ),
                            ),
                            const SizedBox(width: 6),
                            const Flexible(
                              child: Text(
                                'hari',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontFamily: 'Poppins',
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      // Bulan
                      Flexible(
                        child: Row(
                          children: [
                            SizedBox(
                              width: 45,
                              child: TextField(
                                controller: bulanController,
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                  hintText: '0',
                                  hintStyle: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14,
                                    fontFamily: 'Poppins',
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(color: Colors.grey.shade300),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(color: Colors.grey.shade300),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(color: Colors.green.shade400, width: 2),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                                ),
                              ),
                            ),
                            const SizedBox(width: 6),
                            const Flexible(
                              child: Text(
                                'bulan',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontFamily: 'Poppins',
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      // Tahun
                      Flexible(
                        child: Row(
                          children: [
                            SizedBox(
                              width: 45,
                              child: TextField(
                                controller: tahunController,
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                  hintText: '0',
                                  hintStyle: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14,
                                    fontFamily: 'Poppins',
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(color: Colors.grey.shade300),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(color: Colors.grey.shade300),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(color: Colors.green.shade400, width: 2),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                                ),
                              ),
                            ),
                            const SizedBox(width: 6),
                            const Flexible(
                              child: Text(
                                'tahun',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontFamily: 'Poppins',
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Penyimpanan section
                  Text(
                    'Penyimpanan',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Poppins',
                      color: Colors.grey.shade800,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Pilih cara penyimpanan yang tepat',
                    style: TextStyle(
                      fontSize: 12,
                      fontFamily: 'Poppins',
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Penyimpanan dropdown-like field
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isPenyimpananDropdownOpen = !isPenyimpananDropdownOpen;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: isPenyimpananDropdownOpen
                              ? Colors.green.shade400
                              : Colors.grey.shade300,
                          width: isPenyimpananDropdownOpen ? 2 : 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              selectedPenyimpanan.isEmpty
                                  ? 'Pilih cara penyimpanan'
                                  : selectedPenyimpanan.join(', '),
                              style: TextStyle(
                                color: selectedPenyimpanan.isEmpty
                                    ? Colors.grey
                                    : Colors.black87,
                                fontSize: 14,
                                fontFamily: 'Poppins',
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Icon(
                            isPenyimpananDropdownOpen
                                ? Icons.keyboard_arrow_up
                                : Icons.keyboard_arrow_down,
                            color: Colors.grey.shade600,
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Penyimpanan options (shown when dropdown is open)
                  if (isPenyimpananDropdownOpen) ...[
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey.shade300),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            spreadRadius: 1,
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Wrap(
                        children: penyimpananOptions.map((option) => _buildPenyimpananChip(option)).toList(),
                      ),
                    ),
                  ],

                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),

          // Bottom buttons section
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 0,
                  blurRadius: 4,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Row(
              children: [
                // Batalkan button
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.grey.shade700,
                      side: BorderSide(color: Colors.grey.shade300),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Batalkan',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 12),

                // Simpan button
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      try {
                        // Calculate expiry date
                        int days = int.tryParse(hariController.text) ?? 0;
                        int months = int.tryParse(bulanController.text) ?? 0;
                        int years = int.tryParse(tahunController.text) ?? 0;

                        DateTime tanamDate = DateTime.parse(tanggalTanamController.text.split('/').reversed.join('-'));
                        DateTime harvestDate = DateTime.parse(tanggalPanenController.text.split('/').reversed.join('-'));
                        DateTime expiryDate = DateTime(
                          harvestDate.year + years,
                          harvestDate.month + months,
                          harvestDate.day + days,
                        );

                        await _productService.uploadProduct(
                          nama: namaController.text,
                          deskripsi: deskripsiController.text,
                          moq: double.tryParse(kuantitasController.text) ?? 0.0,
                          tanam: tanamDate,
                          panen: harvestDate,
                          harga: int.tryParse(hargaController.text) ?? 0,
                          penyimpanan: selectedPenyimpanan.join(', '),
                          kategori: selectedCategory,
                          kadaluarsa: expiryDate,
                          stok: int.tryParse(stokController.text) ?? 0,
                          imageFile: _pickedImage != null ? File(_pickedImage!.path) : null,
                        );

                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Produk berhasil disimpan!')),
                        );
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Error: $e')),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green.shade700,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 2,
                    ),
                    child: const Text(
                      'Simpan',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Poppins',
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
}