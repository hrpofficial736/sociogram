import 'package:supabase_flutter/supabase_flutter.dart';

class UsersCrud {
  Future<bool> createGoogleUser(String name, String username, String email,
      String profilePhotoUrl) async {
    try {
      final existingUsersList = await Supabase.instance.client
          .from("users")
          .select("username")
          .eq("username", username);
      if (existingUsersList.isEmpty) {
        await Supabase.instance.client.from("users").insert({
          "name": name,
          "username": username,
          "email": email,
          "profile_photo_url": profilePhotoUrl
        });
        return true;
      }
      return false;
    } catch (error) {
      return false;
    }
  }
  Future<bool> createEmailPasswordUser(String name, String username, String email,
      String password) async {
    try {
      final existingUsersList = await Supabase.instance.client
          .from("users")
          .select("username")
          .eq("username", username);
      if (existingUsersList.isEmpty) {
        await Supabase.instance.client.from("users").insert({
          "name": name,
          "username": username,
          "email": email,
          "password": password
        });
        return true;
      }
      return false;
    } catch (error) {
      return false;
    }
  }
}
