import 'package:flutter/material.dart';

class DescriptionTextfield extends StatelessWidget {
  final TextEditingController descriptionEditingController;
  const DescriptionTextfield(
      {super.key, required this.descriptionEditingController});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 350,
        height: 280,
        child: TextField(
            controller: descriptionEditingController,
            cursorColor: Theme.of(context).colorScheme.secondary,
            style: const TextStyle(fontFamily: 'Ubuntu'),
            maxLines: 10,
            maxLength: 300,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Theme.of(context).colorScheme.secondary),
                  borderRadius: BorderRadius.circular(10),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Theme.of(context).colorScheme.secondary),
                  borderRadius: BorderRadius.circular(10),
                ),
                hintText: "A nice and lovely day...",
                hintStyle: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontFamily: 'Cookie',
                    fontSize: 21,
                    fontWeight: FontWeight.w500),
                labelStyle: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700),
                labelText: "Description",
                alignLabelWithHint: true)));
  }
}
