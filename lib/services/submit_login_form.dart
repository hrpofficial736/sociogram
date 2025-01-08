import 'package:flutter/material.dart';
import '../screens/home/home_screen.dart';
import 'dart:async';
import '../supabase_client.dart';

void submitLoginForm(
    BuildContext context,
    TextEditingController emailController,
    TextEditingController passwordController) async {
  if (emailController.text == '' || passwordController.text == '') {
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
    await service.client.auth.signInWithPassword(
        email: emailController.text, password: passwordController.text);
    Timer(const Duration(seconds: 3), () {
      
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const HomeScreen()));
    });
  } catch (e) {
    Navigator.pop(context);
    showDialog(
        context: context,
        builder: (context) => Center(
            child: Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                padding: const EdgeInsets.all(10),
                child: Text('$e',
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)))));
  }
}
