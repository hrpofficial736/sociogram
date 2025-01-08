import 'package:flutter/material.dart';
import '../supabase_client.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../screens/home/home_screen.dart';
import '../services/users_crud.dart';
import 'dart:async';

void submitRegisterForm(
    BuildContext context,
    TextEditingController nameController,
    TextEditingController emailController,
    TextEditingController passwordController) async {
  if (nameController.text == '' ||
      emailController.text == '' ||
      passwordController.text == '') {
    showDialog(
        context: context,
        builder: (context) => Center(
            child: Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                padding: const EdgeInsets.all(10),
                child: Text('Please fill all the details!',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.surface)))));
    return;
  }
  showDialog(
      context: context,
      builder: (context) => Center(
          child: CircularProgressIndicator(
              backgroundColor: Theme.of(context).colorScheme.primary, color: Theme.of(context).colorScheme.surface)));
  try {
    final service = SupabaseAuth();
    await Supabase.instance.client.auth.signUp(
        email: emailController.text,
        password: passwordController.text,
        data: {"name": nameController.text});
        await UsersCrud().createEmailPasswordUser(nameController.text, emailController.text.split("@")[0],emailController.text, passwordController.text);
    Timer(const Duration(seconds: 3), () {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const HomeScreen()));
    });
  } catch (e) {
    Navigator.pop(context);
    print(e);
  }
}
