import 'package:flutter/material.dart';

class ListMenu extends StatelessWidget {
  final IconData icon;
  final String text;
  final void Function()? onTap;
  const ListMenu(
      {super.key, required this.icon, required this.text, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return ListTile(
        onTap: onTap,
        leading: Icon(icon,
            size: 20, color: text == "Log Out" ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.secondary),
        title: Text(text,
            style: TextStyle(
                color: text == "Log Out" ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.secondary,
                fontSize: 17,
                fontFamily: 'Inria',
                fontWeight: FontWeight.bold)));
  }
}
