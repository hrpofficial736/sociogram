import 'dart:async';
import 'package:flutter/material.dart';
import '../splash/splash_screen.dart';
import '../../utils/widgets/screen_sections/home_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const HomeWidget()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return const SplashScreen();
  }
}
