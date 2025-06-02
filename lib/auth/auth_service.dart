import 'package:supabase_flutter/supabase_flutter.dart';

// Corrected AuthService
class AuthService {
  final SupabaseClient supabase = Supabase.instance.client; // Removed asterisk

  //sign in
  Future<AuthResponse> signInWithPassword(
      String email, String password) async {
    return await supabase.auth.signInWithPassword( // Removed asterisk
      email: email,
      password: password,
    );
  }

  Future<void> loginUser(String identifier, String password) async {
    String emailToUse = identifier;

    // Kalau input bukan email, berarti username, cari email di profiles
    if (!identifier.contains('@')) {
      final profile = await supabase
          .from('profiles')
          .select('email')
          .eq('username', identifier)
          .maybeSingle();

      if (profile == null) throw Exception('Username tidak ditemukan');

      emailToUse = profile['email'];
    }

    final authResponse = await supabase.auth.signInWithPassword(
      email: emailToUse,
      password: password,
    );

    if (authResponse.user == null) {
      throw Exception('Login gagal');
    }

    // Ambil profil lengkap juga bisa kalau perlu
    final userProfile = await supabase
        .from('profiles')
        .select()
        .eq('id', authResponse.user!.id)
        .maybeSingle();

    print('Welcome ${userProfile?['username']}');
  }

  Future<String?> getEmailByUsername(String username) async {
    final response = await supabase
        .from('profiles') // ganti sesuai nama tabelmu
        .select('email')
        .eq('username', username)
        .maybeSingle();

    return response?['email'] as String?;
  }
  Future<Map<String, dynamic>?> getUserProfile(String userId) async {
    final response = await supabase
        .from('profiles')
        .select()
        .eq('id', userId)
        .maybeSingle();

    return response;
  }
  //sign up
  Future<AuthResponse> signUp(
      String email, String password) async {
    return await supabase.auth.signUp( // Removed asterisk
      email: email,
      password: password,
    );
  }

  //sign out
  Future<void> signOut() async {
    await supabase.auth.signOut(); // Removed asterisk
  }

  String? getCurrentUserEmail() {
    final session = supabase.auth.currentSession; // Fixed variable name
    final user = session?.user;
    return user?.email;
  }
}