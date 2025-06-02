import 'package:flutter/material.dart';
import 'package:prd_tubes/features/homepage/homepage.dart';
import 'package:prd_tubes/features/idverification/idverification.dart';
import 'package:prd_tubes/features/landing-page/daftar_screen.dart';
import 'package:prd_tubes/features/landing-page/landing-page.dart';
import 'package:prd_tubes/features/landing-page/masuk_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


void main() async{
  await Supabase.initialize(
      url: "https://mpeqosudxmqwanqlbnqe.supabase.co",
      anonKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im1wZXFvc3VkeG1xd2FucWxibnFlIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDg3OTMzNjIsImV4cCI6MjA2NDM2OTM2Mn0.uY3frt2ZQcGF-_XH5632jqwEdvnFZMxVE_QwIbbrGX0");
  runApp(MyApp());
}

final supabase = Supabase.instance.client;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => LandingPage(),
        '/masuk': (context) => MasukPage(),
        '/daftar': (context) => DaftarPage(),
        '/homepage': (context) => HomepageScreen(),
        '/logout' : (context) => MasukPage(),
        '/idverification': (context) => IdVerificationScreen(),
      },
    );
  }
}
