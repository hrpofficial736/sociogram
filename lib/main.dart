import 'package:flutter/material.dart';
import 'package:sociogram/themes/dark_mode.dart';
import 'package:sociogram/themes/light_mode.dart';
import './screens/auth/login/login_screen.dart';
import './screens/auth/register/register_screen.dart';
import './screens/home/home_screen.dart';
import './screens/profile/profile_screen.dart';
import './screens/add-post/add_post.dart';
import './app.dart';
import './secrets.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:provider/provider.dart';
import './themes/theme_notifier.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(url: Secrets.url, anonKey: Secrets.anonKey);
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeNotifier(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return MaterialApp(
        initialRoute: '/',
        routes: {
          '/login': (context) => const LoginScreen(),
          '/register': (context) => const RegisterScreen(),
          '/home': (context) => const HomeScreen(),
          '/my-profile': (context) => ProfileScreen(),
          '/add-a-post': (context) => const AddPost()
        },
        theme: lightMode,
        darkTheme: darkMode,
        themeMode: themeNotifier.themeMode,
        debugShowCheckedModeBanner: false,
        home: const App());
  }
}
