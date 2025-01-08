import 'package:flutter/material.dart';
import 'dart:async';
import '../../../utils/widgets/screen_sections/login_widget.dart';
import '../../splash/splash_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const LoginWidget()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return const SplashScreen();
  }
}
