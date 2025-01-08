import 'package:flutter/material.dart';
import '../../../utils/forms/register/register_form.dart';
import '../../auth/login/login_screen.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 80),
            child: SingleChildScrollView(
                child: Column(children: [
              const Text('Register on Sociogram',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontFamily: 'Poppins')),
              const SizedBox(height: 50),
              const SizedBox(height: 460, child: RegisterForm()),
              const SizedBox(height: 20),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const LoginScreen()));
                  },
                  child: const Text(
                      "Already have an account? Register instead.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.red,
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.red,
                          fontSize: 13,
                          fontFamily: 'Poppins')))
            ]))));
  }
}
