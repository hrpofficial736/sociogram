import 'package:flutter/material.dart';
import '../../inputs/text_field.dart';
import '../../inputs/elevated_button.dart';
import '../../inputs/google_button.dart';
import '../../../services/submit_login_form.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});
  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final email = 'Email', password = 'Password';
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  void handleSubmitForm() {
    submitLoginForm(context, emailController, passwordController);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox(
            child: Container(
                decoration: const BoxDecoration(color: Colors.white),
                child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(children: [
                      CustomTextField(
                          inputText: email,
                          isPassword: false,
                          textController: emailController),
                      const SizedBox(height: 30),
                      CustomTextField(
                          inputText: password,
                          isPassword: true,
                          textController: passwordController),
                      const SizedBox(height: 30),
                      Button(text: 'Login', handleSubmit: handleSubmitForm),
                      const SizedBox(height: 20),
                      const Row(children: [
                        Expanded(
                            flex: 1,
                            child: Divider(color: Colors.grey, thickness: 1)),
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Text('Or',
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w500))),
                        Expanded(
                            child: Divider(color: Colors.grey, thickness: 1))
                      ]),
                      const SizedBox(height: 40),
                      const GoogleButton()
                    ])))));
  }
}
