import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:wl/anim/animated_route.dart';
import 'package:wl/page/helloy_page.dart';
import 'package:wl/page/login_page.dart';
import 'package:wl/page/home_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _colorAnimation;
  bool _isFirstLaunch = true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );
    _colorAnimation = ColorTween(
      begin: const Color(0xFF3F51B5),
      end: const Color(0xFF2196F3),
    ).animate(_controller);
    _controller.forward();
    _checkIfFirstLaunch();
  }

  Future<void> _checkIfFirstLaunch() async {
    final prefs = await SharedPreferences.getInstance();
    final hasLaunched = prefs.getBool('hasLaunched') ?? false;
    setState(() {
      _isFirstLaunch = !hasLaunched;
    });
    if (!hasLaunched) {
      await prefs.setBool('hasLaunched', true);
    }
    startTimer();
  }

  void startTimer() {
    Timer(const Duration(seconds: 3), () {
      if (_isFirstLaunch) {
        Navigator.of(context).pushAndRemoveUntil(
          AnimatedRoute(
              page: Helloy()), // Используем анимацию из отдельного файла
          (route) => false,
        );
      } else {
        _redirectBasedOnSession();
      }
    });
  }

  void _redirectBasedOnSession() {
    final session = Supabase.instance.client.auth.currentSession;
    if (session == null) {
      Navigator.of(context).pushAndRemoveUntil(
        AnimatedRoute(page: LoginPage()),
        (route) => false,
      );
    } else {
      Navigator.of(context).pushAndRemoveUntil(
        AnimatedRoute(page: HomePage()),
        (route) => false,
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _colorAnimation,
      builder: (context, child) {
        return Scaffold(
          body: Container(
            color: _colorAnimation.value,
            child: Center(
              child: Image.asset('images/rb_6820.png'),
            ),
          ),
        );
      },
    );
  }
}
