import '../supabase_client.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../secrets.dart';
import './users_crud.dart';
import './get_user_credentials.dart';
import 'package:google_sign_in/google_sign_in.dart';

Future<bool> signInWithGoogle() async {
  try {
    final service = SupabaseAuth();
    final GoogleSignIn googleSignIn = GoogleSignIn(
        serverClientId: Secrets.clientId, scopes: ['email', 'profile']);
    final googleUser = await googleSignIn.signIn();
    final googleAuth = await googleUser!.authentication;
    final accessToken = googleAuth.accessToken;
    final idToken = googleAuth.idToken;
    if (accessToken == null) {
      throw 'No Access Token found.';
    }
    if (idToken == null) {
      throw 'No ID Token found.';
    }
    await service.client.auth.signInWithIdToken(
        provider: OAuthProvider.google,
        idToken: idToken,
        accessToken: accessToken);
    await UsersCrud().createGoogleUser(
        getUserCredentials()["name"]!,
        getUserCredentials()["username"]!,
        getUserCredentials()["userEmail"]!,
        getUserCredentials()["image"]!);
    return true;
  } catch (e) {
    return false;
  }
}
