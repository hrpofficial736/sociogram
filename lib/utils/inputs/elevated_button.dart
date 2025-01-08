import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String text;
  final VoidCallback handleSubmit;
  const Button({super.key, required this.text, required this.handleSubmit});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 300,
        height: 50,
        child: ElevatedButton(
            onPressed: handleSubmit,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: Text(text,
                style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Poppins',
                    color: Colors.white))));
  }
}
