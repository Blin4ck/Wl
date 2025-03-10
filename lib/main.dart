import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:wl/splash_screen.dart';

Future<void> main() async {
  await Supabase.initialize(
    url: 'https://nhfjrnxojqyxhbvnovnv.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im5oZmpybnhvanF5eGhidm5vdm52Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzY2MTE4MTIsImV4cCI6MjA1MjE4NzgxMn0.y6VYRqBLYz_mogfKTEhWCkDVF7ZkzmzKtGrBswNMEdk',
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: const SplashScreen(),
      ),
    );
  }
}
