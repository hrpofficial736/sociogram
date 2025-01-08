import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../services/get_user_credentials.dart';
import '../../utils/widgets/screen_sections/posts_on_profile.dart';
import '../../services/post_crud.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import '../../services/image_crud.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({super.key});
  @override
  State<StatefulWidget> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState () {
    super.initState();
  }
  File? _image;
  Future<void> pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result != null && result.files.isNotEmpty) {
      setState(() {
        _image = File(result.files.single.path!);
      });
      if (_image != null) {
        final String username = getUserCredentials()["username"]!;
        String path = await ImageCrud().uploadProfileImage(username, _image!);
        print(path);
        await Supabase.instance.client.from("users").update({
          "profile_photo_url": path
        }).eq("username", username).single();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.surface,
            leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                }),
            title: Text('Profile',
                style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontFamily: 'Ubuntu',
                    fontWeight: FontWeight.bold)),
            actions: [
              IconButton(
                  icon: Icon(Icons.share, color: Theme.of(context).colorScheme.secondary),
                  onPressed: () {})
            ]),
        body: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            const SizedBox(height: 30),
            Center(
              child: Stack(children: [GestureDetector(
                onTap: () => pickFile(),
                child: CircleAvatar(
                radius: 50,
                backgroundColor: Colors.transparent,
                backgroundImage: _image == null ? CachedNetworkImageProvider(
                  getUserCredentials()["image"]!,
                ) : FileImage(_image!),
              )
              ),
            
            
          Positioned(
              right: 0,
              top: 0,
              child: GestureDetector(
                onTap: () => pickFile(),
                child: CircleAvatar(
                  radius: 15, // Size of the pencil icon
                  backgroundColor:
                      Colors.white, // Background of the pencil icon
                  child: Icon(
                    Icons.edit,
                    size: 18, // Pencil icon size
                    color: Theme.of(context).colorScheme.primary, // Pencil icon color
                  ),
                ),
              ),
            ),
              ])),
            const SizedBox(height: 15),
            Text(
              getUserCredentials()["name"]!,
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
                fontSize: 30,
                fontFamily: 'Inria',
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              getUserCredentials()["username"]!,
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
                fontSize: 17,
                fontFamily: 'Inria',
                fontWeight: FontWeight.w600,
              ),
            ),
            PostsOnProfile(
              posts: PostCrud().getPosts(getUserCredentials()["username"]!),
            ),
          ]),
        ));
  }
}
