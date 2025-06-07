import 'dart:io';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProductService {
  final SupabaseClient supabase = Supabase.instance.client;

  Future<void> uploadProduct({
    required String nama,
    required String deskripsi,
    required double moq,
    required DateTime panen,
    required int harga,
    required String penyimpanan,
    required String kategori,
    required DateTime kadaluarsa,
    File? imageFile,
  }) async {

    String? imageUrl;

    if (imageFile != null) {
      final imageBytes = await imageFile.readAsBytes();
      final fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';

      await supabase.storage
          .from('product')
          .uploadBinary('images/$fileName', imageBytes);

      imageUrl = supabase.storage
          .from('product')
          .getPublicUrl('images/$fileName');
    }

    // ✅ GANTI 'products' DENGAN NAMA TABEL PRODUK KAMU DI SUPABASE
    await supabase.from('products').insert({
      // 🔧 Cek dan sesuaikan semua key berikut dengan NAMA KOLOM DI SUPABASE
      'product_name': nama,               // Ganti kalau nama kolom di Supabase kamu beda
      'product_description': deskripsi,
      'moq': moq,
      'harvest_date': panen.toIso8601String(),    // Pastikan ini format ISO
      'storage': penyimpanan,
      'cathegory': kategori,
      'image_url': imageUrl,
      'price': harga,
      'kadaluarsa': kadaluarsa.toIso8601String(),
      'pemilik_id': supabase.auth.currentUser?.id, // Pastikan nama kolom foreign key-nya benar
    });

  }
}
