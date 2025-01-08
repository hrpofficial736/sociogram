import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String inputText;
  final bool isPassword;
  final TextEditingController textController;
  const CustomTextField(
      {super.key,
      required this.inputText,
      required this.isPassword,
      required this.textController});
  @override
  Widget build(BuildContext context) {
    return TextField(
        controller: textController,
        style:
            const TextStyle(fontFamily: 'Inria', fontWeight: FontWeight.w100),
        obscureText: isPassword,
        obscuringCharacter: '*',
        cursorColor: Colors.black,
        decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: Colors.black,
                width: 3,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: Colors.black,
                width: 2,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: Colors.black,
                width: 3,
              ),
            ),
            labelText: inputText,
            labelStyle:
                const TextStyle(color: Colors.black, fontFamily: 'Ubuntu')));
  }
}
