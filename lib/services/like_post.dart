import "get_user_credentials.dart";
import 'package:supabase_flutter/supabase_flutter.dart';

Future likePost(int id) async {
  try {
    final String? user = getUserCredentials()["username"];
    final Map map = await Supabase.instance.client
        .from("posts")
        .select("usersWhoLiked")
        .eq("id", id)
        .single();
    final List<dynamic>? usersWhoLiked = map["usersWhoLiked"];
    if (usersWhoLiked != null && usersWhoLiked.contains(user)) {
      return;
    }
    List<dynamic> newArray = usersWhoLiked ?? [];
    newArray.add(user);

    await Supabase.instance.client
        .from("posts")
        .update({"usersWhoLiked": newArray})
        .eq("id", id)
        .single();
  } catch (error) {
    return error;
  }
}

Future dislikePost(int id) async {
  try {
    final String? user = getUserCredentials()["username"];
    final Map map = await Supabase.instance.client
        .from("posts")
        .select("usersWhoLiked")
        .eq("id", id)
        .single();
    final List<dynamic>? usersWhoLiked = map["usersWhoLiked"];
    if (usersWhoLiked != null && !usersWhoLiked.contains(user)) {
      return;
    }
    List<dynamic> newArray = usersWhoLiked ?? [];
    newArray.remove(user);

    await Supabase.instance.client
        .from("posts")
        .update({"usersWhoLiked": newArray})
        .eq("id", id)
        .single();
  } catch (error) {
    return error;
  }
}
