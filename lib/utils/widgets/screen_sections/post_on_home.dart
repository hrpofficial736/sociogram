import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:file_picker/file_picker.dart';
import '../../../services/post_crud.dart';
import 'dart:io';
import '../../../services/get_user_credentials.dart';

class PostOnHome extends StatefulWidget {
  const PostOnHome({super.key});
  @override
  State<PostOnHome> createState() => _PostOnHomeState();
}

class _PostOnHomeState extends State<PostOnHome> {
  final TextEditingController textEditingController = TextEditingController();
  File? _file;
  Future<void> pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result != null && result.files.isNotEmpty) {
      setState(() {
        _file = File(result.files.single.path!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: 140,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).colorScheme.tertiary,
                spreadRadius: 1,
                blurRadius: 10,
                offset: Offset(0, 3),
              ),
            ],
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Container(
              padding: const EdgeInsets.all(10),
              child: Row(children: [
                CircleAvatar(
                  backgroundImage: CachedNetworkImageProvider(
                      getUserCredentials()["image"]!),
                  radius: 18,
                ),
                const SizedBox(width: 20),
                TextField(
                    controller: textEditingController,
                    style: const TextStyle(fontFamily: "Poppins"),
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        constraints: BoxConstraints(maxWidth: 250),
                        hintText: "Write something...",
                        hintStyle: TextStyle(
                            color: Theme.of(context).colorScheme.secondary,
                            decoration: TextDecoration.none)),
                    cursorColor: Theme.of(context).colorScheme.secondary),
                _file != null
                    ? Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          border: Border.all(color: Theme.of(context).colorScheme.secondary),
                          borderRadius: BorderRadius.circular(30),
                          image: DecorationImage(
                            image: FileImage(_file!),
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                    : const SizedBox()
              ])),
          const SizedBox(height: 3),
          Container(
              padding: const EdgeInsets.only(left: 15),
              child: Row(children: [
                Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).colorScheme.surface),
                      child: Row(spacing: 10, children: [
                        Icon(Icons.attach_file, size: 20, color: Theme.of(context).colorScheme.primary),
                        Text("Attach an image",
                            style: TextStyle(
                                fontFamily: "Inria", color: Theme.of(context).colorScheme.secondary))
                      ]),
                      onPressed: () {
                        pickFile();
                      },
                    )),
                const SizedBox(width: 80),
                ElevatedButton(
                    onPressed: () async {
                      if (textEditingController.text == '' || _file == null) {
                        showDialog(
                            context: context,
                            builder: (context) => Center(
                                child: Container(
                                    decoration: BoxDecoration(
                                        color: Theme.of(context).colorScheme.primary,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    padding: const EdgeInsets.all(10),
                                    child: Text(
                                        'Description is required!',
                                        style: TextStyle(
                                            decoration: TextDecoration.none,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Theme.of(context).colorScheme.secondary)))));
                      } else {
                        await PostCrud().addPost(
                            getUserCredentials()["username"]!,
                            _file!,
                            textEditingController.text,
                            getUserCredentials()["image"]!);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                    ),
                    child: Text("Post",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Poppins',
                            color: Colors.white)))
              ]))
        ]));
  }
}
