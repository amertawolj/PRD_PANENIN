import 'dart:io';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProductService {
  final SupabaseClient supabase = Supabase.instance.client;

  Future<void> uploadProduct({
    required String nama,
    required String deskripsi,
    required int stok,
    required int harga,
    required String penyimpanan,
    required DateTime batasKonsumsi,
    File? imageFile,
  }) async {
    String? imageUrl;
    if (imageFile != null) {
      final imageBytes = await imageFile.readAsBytes();
      final fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';
      final storageResponse = await supabase.storage
          .from('product-image') // nama bucket kamu
          .uploadBinary('images/$fileName', imageBytes);

      final publicUrl = supabase.storage
          .from('product')
          .getPublicUrl('images/$fileName');
      imageUrl = publicUrl;
    }

    // 2. Insert ke database
    await supabase.from('produk').insert({
      'nama': nama,
      'deskripsi': deskripsi,
      'stok': stok,
      'harga': harga,
      'penyimpanan': penyimpanan,
      'batas_konsumsi': batasKonsumsi.toIso8601String(),
      'gambar_url': imageUrl,
      'user_id': supabase.auth.currentUser?.id, // relasi user
    });
  }
}
