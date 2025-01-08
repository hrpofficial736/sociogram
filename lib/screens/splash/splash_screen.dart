import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});
  @override
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        backgroundColor: Colors.red,
        body: Center(
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(Icons.connect_without_contact, size: 30, color: Colors.white),
          SizedBox(width: 10),
          Text('SocioGram',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w900)),
        ])));
  }
}
