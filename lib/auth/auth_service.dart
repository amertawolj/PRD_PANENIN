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
        .from('profiles') // ganti sesuai nama tabel kamu
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