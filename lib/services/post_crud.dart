import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/post_model.dart';
import './image_crud.dart';
import 'dart:io';

class PostCrud {
  final table = Supabase.instance.client.from('posts');

  Future<bool> addPost(String username, File image, String description,
      String userProfilePic) async {
    final filePath = await ImageCrud().uploadPostImage(username, image);
    await table.insert({
      "user": username,
      "userProfilePic": userProfilePic,
      "image": filePath,
      "description": description,
    });
    return true;
  }

  Future<List<PostModel>> getPosts(String username) async {
    try {
      final posts = await table
          .select(
              "id, user, image, description, userProfilePic, created_at, usersWhoLiked")
          .eq("user", username);
      return posts.map((post) => PostModel.fromJson(post)).toList();
    } catch (e) {
      return [];
    }
  }
}
