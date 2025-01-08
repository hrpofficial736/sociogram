import 'package:supabase_flutter/supabase_flutter.dart';

String checkForAuthProvider() {
  final authProvider = Supabase
      .instance.client.auth.currentSession?.user.appMetadata["provider"];
  if (authProvider == 'google') {
    print('User signed in with Google');
    return "google";
  } else if (authProvider == 'email') {
    print('User signed in with Email');
    return "email";
  } else {
    return "";
  }
}
