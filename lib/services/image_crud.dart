import 'package:supabase_flutter/supabase_flutter.dart';
import 'dart:io';

class ImageCrud {
  Future<String> uploadPostImage(
    String username,
    File image,
  ) async {
    final fileName = "$username-${DateTime.now().toString()}";
    final filePath = "$username/posts/$fileName";
    await Supabase.instance.client.storage
        .from('images')
        .upload(filePath, image);
    return filePath;
  }

  Future<String> uploadProfileImage(String username, File image) async {
    String pathToBeStored = "";
    final fileName = "$username-${DateTime.now().toString()}";
    final filePath = "$username/profilePhoto/$fileName";
    await Supabase.instance.client.storage
        .from("images")
        .upload(filePath, image);
    pathToBeStored = getPublicImageUrl(filePath);
    print("path is $pathToBeStored");
    return pathToBeStored;
  }

  Future<List<FileObject>> getImages(String username) async {
    final files = await Supabase.instance.client.storage
        .from('images')
        .list(path: username);
    return files;
  }

  String getPublicImageUrl(String path) {
    final response =
        Supabase.instance.client.storage.from('images').getPublicUrl(path);
    return response;
  }
}
