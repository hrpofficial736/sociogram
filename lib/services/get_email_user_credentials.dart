import 'package:supabase_flutter/supabase_flutter.dart';

Future<String> getEmailUserProfilePhoto(String email) async {
  final userCredentials = await Supabase.instance.client
      .from("users")
      .select("profile_photo_url")
      .eq("email", email);
      Supabase.instance.client.auth.currentUser?.userMetadata?["avatar_url"] = userCredentials[0]["profile_photo_url"];
  return userCredentials[0]["profile_photo_url"];
}
