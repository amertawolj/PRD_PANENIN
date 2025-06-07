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
    required int stok,
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

    await supabase.from('products').insert({
      'product_name': nama,
      'product_description': deskripsi,
      'moq': moq,
      'harvest_date': panen.toIso8601String(),
      'storage': penyimpanan,
      'cathegory': kategori,
      'image_url': imageUrl,
      'price': harga,
      'stok': stok,
      'kadaluarsa': kadaluarsa.toIso8601String(),
      'uid': supabase.auth.currentUser?.id,
    });

  }
}
