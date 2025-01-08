import 'package:flutter/material.dart';
import '../../services/google_signin.dart';
import '../../screens/home/home_screen.dart';
import 'dart:async';

class GoogleButton extends StatelessWidget {
  const GoogleButton({super.key});
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: SizedBox(
            width: 300,
            height: 50,
            child: ElevatedButton(
                onPressed: () async {
                  showDialog(
                      context: context,
                      builder: (context) => const Center(
                          child: CircularProgressIndicator(
                              backgroundColor: Colors.red,
                              color: Colors.white)));
                  final response = await signInWithGoogle();
                  if (response) {
                    Timer(const Duration(seconds: 3), () {
                      Navigator.pop(context);
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const HomeScreen()));
                    });
                  } else {
                    Navigator.pop(context);
                  }
                },
                style: ElevatedButton.styleFrom(
                    shadowColor: Colors.black,
                    elevation: 8,
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black),
                child: Row(children: [
                  Image.asset("./lib/resources/images/google_logo.png",
                      width: 25, height: 25),
                  const SizedBox(width: 25),
                  const Text('Continue with Google',
                      style: TextStyle(fontFamily: 'Poppins', fontSize: 16))
                ]))));
  }
}
