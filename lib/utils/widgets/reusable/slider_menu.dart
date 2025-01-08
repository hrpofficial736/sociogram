import 'package:flutter/material.dart';
import 'package:sociogram/services/get_email_user_credentials.dart';
import './list_menu.dart';
import '../../../services/get_user_credentials.dart';
import '../../../screens/profile/profile_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import "../../../screens/add-post/add_post.dart";
import '../../../screens/search/search_screen.dart';
import '../../../screens/settings/settings_screen.dart';
import '../../../services/log_out.dart';
import '../../../screens/auth/login/login_screen.dart';

class SliderMenu extends StatefulWidget {
  const SliderMenu({super.key});
  
  @override
  State<SliderMenu> createState() => _SliderMenuState();
}


class _SliderMenuState extends State<SliderMenu> {
  @override
  void initState () {
    super.initState();
    fetchUserProfilePhoto();  
  }

  void fetchUserProfilePhoto () async {
    await getEmailUserProfilePhoto(getUserCredentials()["userEmail"]!);
  }
  @override
  Widget build(BuildContext context) {
    return Drawer(
        backgroundColor: Theme.of(context).colorScheme.surface,
        child: SafeArea(
            child: Column(spacing: 10, children: [
          const SizedBox(height: 20),
          CircleAvatar(backgroundColor: Colors.transparent,
            backgroundImage:
                CachedNetworkImageProvider(getUserCredentials()["image"]!),
            radius: 30,
          ),
          Text(getUserCredentials()["name"]!,
              style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  fontSize: 25,
                  fontFamily: 'Inria',
                  fontWeight: FontWeight.bold)),
          Text(getUserCredentials()["username"]!,
              style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  fontSize: 17,
                  fontFamily: 'Inria',
                  fontWeight: FontWeight.w600)),
          Divider(
              color: Theme.of(context).colorScheme.tertiary, thickness: 0.4, endIndent: 15, indent: 15),
          ListMenu(
              icon: Icons.home,
              text: 'Home',
              onTap: () {
                Scaffold.of(context).closeEndDrawer();
              }),
          ListMenu(
              icon: Icons.search,
              text: 'Search',
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SearchScreen()));
              }),
          ListMenu(
              icon: Icons.add,
              text: 'Post',
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const AddPost()));
              }),
          ListMenu(
              icon: Icons.person,
              text: 'Profile',
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ProfileScreen()));
              }),
          ListMenu(
              icon: Icons.settings,
              text: 'Settings',
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SettingsScreen()));
              }),
          ListMenu(
              icon: Icons.logout,
              text: 'Log Out',
              onTap: () {
                logOut();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen()));
              })
        ])));
  }
}
