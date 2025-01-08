import 'package:supabase_flutter/supabase_flutter.dart';

void logOut() async {
  await Supabase.instance.client.auth.signOut();
}
