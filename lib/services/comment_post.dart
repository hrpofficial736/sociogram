import 'package:supabase_flutter/supabase_flutter.dart';

class CommentsCrud {
  Future<List<Map<String, dynamic>>> getComments(int id) async {
    try {
      final List<Map<String, dynamic>> usersWhoCommented = await Supabase
          .instance.client
          .from("comments")
          .select("commentText, created_at, users(name, profile_photo_url)")
          .eq("post_id", id);
      return usersWhoCommented;
    } catch (error) {
      return [
        {"error": error}
      ];
    }
  }

  Future postAComment(int id, String username, String text) async {
    try {
      final user = await Supabase.instance.client
          .from("users")
          .select("id")
          .eq("username", username);

      await Supabase.instance.client.from("comments").insert(
          {"commentText": text, "post_id": id, "user_id": user[0]["id"]});

      
      return true;
    } catch (error) {
      return error;
    }
  }
}
