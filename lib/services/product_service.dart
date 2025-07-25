import 'dart:io';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProductService {
  final SupabaseClient supabase = Supabase.instance.client;

  Future<void> uploadProduct({
    required String nama,
    required String deskripsi,
    required double moq,
    DateTime? panen,     // <-- nullable
    DateTime? tanam,     // <-- nullable
    required int harga,
    required String penyimpanan,
    required String kategori,
    DateTime? kadaluarsa, // <-- nullable
    required int stok,
    File? imageFile,
  }) async {
    // Check if user is authenticated
    final user = supabase.auth.currentUser;
    if (user == null) {
      throw Exception('User not authenticated');
    }

    String? imageUrl;

    // Upload image if provided
    if (imageFile != null) {
      try {
        final imageBytes = await imageFile.readAsBytes();
        final fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';

        await supabase.storage
            .from('product-image')
            .uploadBinary('images/$fileName', imageBytes);

        imageUrl = supabase.storage
            .from('product-image')
            .getPublicUrl('images/$fileName');
      } catch (e) {
        throw Exception('Failed to upload image: $e');
      }
    }

    // Insert product data
    try {
      await supabase.from('products').insert({
        'product_name': nama,
        'product_description': deskripsi,
        'moq': moq,
        'harvest_date': panen?.toIso8601String(),
        'tanam_date': tanam?.toIso8601String(),
        'storage': penyimpanan,
        'cathegory': kategori,
        'image_url': imageUrl,
        'price': harga,
        'stok': stok,
        'kadaluarsa': kadaluarsa?.toIso8601String(),
        'uid': user.id,
      });
    } catch (e) {
      throw Exception('Failed to insert product: $e');
    }
  }

  Future<void> updateProduct({
    required String id,
    required String nama,
    required String deskripsi,
    required double moq,
    DateTime? panen,     // <-- nullable sekarang
    DateTime? tanam,     // <-- nullable
    required int harga,
    required String penyimpanan,
    required String kategori,
    DateTime? kadaluarsa, // <-- nullable
    required int stok,
    File? imageFile,
  }) async {
    // Check if user is authenticated
    final user = supabase.auth.currentUser;
    if (user == null) {
      throw Exception('User not authenticated');
    }

    String? imageUrl;

    // Upload new image if provided
    if (imageFile != null) {
      try {
        final imageBytes = await imageFile.readAsBytes();
        final fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';

        await supabase.storage
            .from('product-image')
            .uploadBinary('images/$fileName', imageBytes);

        imageUrl = supabase.storage
            .from('product-image')
            .getPublicUrl('images/$fileName');
      } catch (e) {
        throw Exception('Failed to upload image: $e');
      }
    }

    // Update product data
    try {
      Map<String, dynamic> updateData = {
        'product_name': nama,
        'product_description': deskripsi,
        'moq': moq,
        'harvest_date': panen?.toIso8601String(),
        'tanam_date': tanam?.toIso8601String(),  // ini diganti dari 'tanam'
        'storage': penyimpanan,
        'cathegory': kategori,
        'price': harga,
        'stok': stok,
        'kadaluarsa': kadaluarsa?.toIso8601String(),
      };

      // Only update image_url if new image was uploaded
      if (imageUrl != null) {
        updateData['image_url'] = imageUrl;
      }

      await supabase.from('products').update(updateData).eq('id', id);
    } catch (e) {
      throw Exception('Failed to update product: $e');
    }
  }

  // Helper method to check if user is authenticated
  bool get isUserAuthenticated => supabase.auth.currentUser != null;

  // Get current user ID
  String? get currentUserId => supabase.auth.currentUser?.id;
}