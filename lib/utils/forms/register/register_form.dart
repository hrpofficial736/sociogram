import 'package:flutter/material.dart';
import '../../inputs/text_field.dart';
import '../../inputs/elevated_button.dart';
import '../../inputs/google_button.dart';
import '../../../services/submit_register_form.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});
  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final name = 'Name', email = 'Email', password = 'Password';
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  void handleSubmitForm() {
    submitRegisterForm(
        context, nameController, emailController, passwordController);
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
                          inputText: name,
                          isPassword: false,
                          textController: nameController),
                      const SizedBox(height: 30),
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
                      Button(text: 'Register', handleSubmit: handleSubmitForm),
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
