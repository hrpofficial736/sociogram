import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import '../../utils/inputs/description_textfield.dart';
import 'package:file_picker/file_picker.dart';
import '../../services/post_crud.dart';
import '../../services/get_user_credentials.dart';
import 'dart:io';

class AddPost extends StatefulWidget {
  const AddPost({super.key});
  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
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

  final TextEditingController _descriptionEditingController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.surface,
          leading: IconButton(
              icon: Icon(Icons.close, color: Theme.of(context).colorScheme.secondary),
              onPressed: () {
                Navigator.pop(context);
              }),
          title: Text('Create a Post',
              style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  fontFamily: 'Ubuntu',
                  fontWeight: FontWeight.bold)),
        ),
        body: SingleChildScrollView(
            child: Center(
                child: Column(children: [
          const SizedBox(height: 20),
          SizedBox(
              width: 350,
              height: 250,
              child: DottedBorder(
                  color: Theme.of(context).colorScheme.primary,
                  radius: const Radius.circular(12),
                  borderType: BorderType.RRect,
                  dashPattern: const [6, 3],
                  child: Center(
                      child: SizedBox(
                          width: double.infinity,
                          height: double.infinity,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                backgroundColor: Theme.of(context).colorScheme.surface,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              onPressed: () {
                                pickFile();
                              },
                              child: _file != null
                                  ? Image.file(
                                      _file!,
                                      fit: BoxFit.cover,
                                    )
                                  : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                          Icon(Icons.add, color: Theme.of(context).colorScheme.primary),
                                          SizedBox(width: 10),
                                          Text('Upload Media',
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w700,
                                                  fontFamily: 'Poppins',
                                                  color: Theme.of(context).colorScheme.primary))
                                        ])))))),
          const SizedBox(height: 30),
          const SizedBox(height: 20),
          DescriptionTextfield(
              descriptionEditingController: _descriptionEditingController),
          const SizedBox(height: 80),
          SizedBox(
              width: 200,
              height: 50,
              child: ElevatedButton(
                  onPressed: () async {
                    if (_descriptionEditingController.text == '' ||
                        _file == null) {
                      showDialog(
                          context: context,
                          builder: (context) => Center(
                              child: Container(
                                  decoration: BoxDecoration(
                                      color: Theme.of(context).colorScheme.primary,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  padding: const EdgeInsets.all(10),
                                  child: Text('Description is required!',
                                      style: TextStyle(
                                          decoration: TextDecoration.none,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Theme.of(context).colorScheme.surface)))));
                    } else {
                      final response = await PostCrud().addPost(
                          getUserCredentials()["username"]!,
                          _file!,
                          _descriptionEditingController.text,
                          getUserCredentials()["image"]!);
                      if (response) {
                        Navigator.pop(context);
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                  ),
                  child: Text("Post",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Poppins',
                          color: Colors.white)))),
        ]))));
  }
}
