import 'package:flutter/material.dart';
import 'package:prd_tubes/features/homepage/homepage.dart';
import 'package:prd_tubes/features/landing-page/masuk_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AuthState>(
      stream: Supabase.instance.client.auth.onAuthStateChange,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        // Cek apakah user sudah login
        final session = snapshot.data?.session;
        if (session != null) {
          return const HomepageScreen();
        } else {
          return MasukPage();
        }
      },
    );
  }
}
