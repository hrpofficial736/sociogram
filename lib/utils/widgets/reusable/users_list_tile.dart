import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../screens/other-user/profile_screen.dart';

class UsersListTile extends StatelessWidget {
  final Map<String, dynamic> user;
  const UsersListTile({super.key, required this.user});
  @override
  Widget build(BuildContext context) {
    return ListTile(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ProfileScreen(
                      name: user["name"],
                      username: user["username"],
                      profilePhotoUrl: user["profile_photo_url"])));
        },
        leading: CircleAvatar(
            backgroundImage:
                CachedNetworkImageProvider(user["profile_photo_url"]!)),
        title: Text(user["name"]!,
            style: TextStyle(
                fontFamily: "Poppins",
                color: Colors.red,
                fontWeight: FontWeight.w800)),
        subtitle:
            Text(user["username"]!, style: TextStyle(fontFamily: "Inria")));
  }
}
