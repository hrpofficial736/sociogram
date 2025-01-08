import 'package:flutter/material.dart';
import '../../../screens/auth/register/register_screen.dart';
import '../../forms/login/login_form.dart';

class LoginWidget extends StatelessWidget {
  const LoginWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 80),
            child: SingleChildScrollView(
                child: Column(children: [
              const Text('Log in to SocioGram',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontFamily: 'Poppins')),
              const SizedBox(height: 50),
              const SizedBox(height: 375, child: LoginForm()),
              const SizedBox(height: 30),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const RegisterScreen()));
                  },
                  child: const Text("Don't have an account? Register instead.",
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
