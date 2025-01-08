import 'package:flutter/material.dart';
import '../../services/get_user_credentials.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../screens/profile/profile_screen.dart';
import '../../utils/widgets/screen_sections/account_settings.dart';
import '../../services/log_out.dart';
import '../auth/login/login_screen.dart';
import 'package:provider/provider.dart';
import '../../themes/theme_notifier.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});
  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: AppBar(
          leading: IconButton(onPressed: () {Navigator.pop(context);}, icon: Icon(Icons.arrow_back, color: Theme.of(context).colorScheme.secondary)),
            backgroundColor: Theme.of(context).colorScheme.surface,
            title: Text("Settings",
                style: TextStyle(color: Theme.of(context).colorScheme.secondary,
                    fontFamily: "Inria", fontWeight: FontWeight.w800))),
        body: SingleChildScrollView(
            child: Column(children: [
          const SizedBox(height: 30),
          Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProfileScreen()));
                  },
                  leading: CircleAvatar(
                      backgroundImage: CachedNetworkImageProvider(
                          getUserCredentials()["image"]!)),
                  trailing: IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProfileScreen()));
                      },
                      icon: Icon(Icons.arrow_forward_ios, color: Theme.of(context).colorScheme.primary)),
                  title: Text(getUserCredentials()["name"]!,
                      style: TextStyle(
                          fontFamily: "Poppins",
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.w800)),
                  subtitle: Text(getUserCredentials()["username"]!,
                      style: TextStyle(fontFamily: "Inria", color: Theme.of(context).colorScheme.secondary)))),
          Divider(color: Theme.of(context).colorScheme.tertiary, thickness: 0.5),
          const SizedBox(height: 20),
          Padding(
              padding: EdgeInsets.only(left: 30, right: 10),
              child: Row(spacing: 15, children: [
                Icon(Icons.dark_mode, color: Theme.of(context).colorScheme.secondary),
                Text("Dark Mode",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: 17,
                        fontFamily: "Inria",
                        fontWeight: FontWeight.w800)),
                const SizedBox(width: 100),
                Switch(
                  value: themeNotifier.themeMode == ThemeMode.dark,
                  onChanged: (value) {
                    themeNotifier.toggleTheme(value);
                  },
                  activeColor: Theme.of(context).colorScheme.primary,
                  inactiveThumbColor: Theme.of(context).colorScheme.secondary,
                  inactiveTrackColor: Theme.of(context).colorScheme.tertiary,
                )
              ])),
          const SizedBox(height: 20),
          Divider(color: Theme.of(context).colorScheme.tertiary, thickness: 0.5),
          const AccountSettings(),
          Divider(color: Theme.of(context).colorScheme.tertiary, thickness: 0.5),
          const SizedBox(height: 30),
          ElevatedButton(
              onPressed: () {
                logOut();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen()));
              },
              style: ElevatedButton.styleFrom(backgroundColor: Theme.of(context).colorScheme.surface),
              child: Text("Log Out",
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontFamily: "Inria",
                      fontWeight: FontWeight.w700))),
        ])));
  }
}
