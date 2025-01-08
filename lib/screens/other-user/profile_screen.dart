import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ProfileScreen extends StatelessWidget {
  final String name;
  final String username;
  final String profilePhotoUrl;

  const ProfileScreen({
    super.key,
    required this.name,
    required this.username,
    required this.profilePhotoUrl,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: AppBar(
          automaticallyImplyLeading: true,
          backgroundColor: Theme.of(context).colorScheme.surface,
          leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              }),
          title: Text('Profile',
              style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  fontFamily: 'Ubuntu',
                  fontWeight: FontWeight.bold)),
        ),
        body: Column(children: [
          const SizedBox(height: 30),
          Center(
              child: CircleAvatar(
            radius: 50,
            backgroundImage: CachedNetworkImageProvider(profilePhotoUrl),
          )),
          const SizedBox(height: 15),
          Text(name,
              style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  fontSize: 30,
                  fontFamily: 'Inria',
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 5),
          Text(username,
              style: TextStyle(
                  color: Theme.of(context).colorScheme.tertiary,
                  fontSize: 17,
                  fontFamily: 'Inria',
                  fontWeight: FontWeight.w600)),
        ]));
  }
}
