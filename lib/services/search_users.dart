import 'package:supabase_flutter/supabase_flutter.dart';

Future<List<dynamic>> searchUsers(String text) async {
  try {
    final users = await Supabase.instance.client
        .from("users")
        .select("name, username, profile_photo_url")
        .or("name.ilike.%$text%,username.ilike.%$text%");
    return users;
  } catch (error) {
    return [error];
  }
}
