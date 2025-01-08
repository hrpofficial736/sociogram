import 'package:flutter/material.dart';
import './screens/auth/login/login_screen.dart';
import './screens/home/home_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Supabase.instance.client.auth.onAuthStateChange,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator(color: Colors.red));
          }
          final session = snapshot.hasData ? snapshot.data?.session : null;
          if (session != null) {
            return const HomeScreen();
          }
          return const LoginScreen();
        });
  }
}
