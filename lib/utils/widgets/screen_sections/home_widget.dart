import 'package:flutter/material.dart';
import 'package:sociogram/services/check_for_provider_auth.dart';
import 'package:sociogram/services/get_email_user_credentials.dart';
import '../reusable/slider_menu.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../services/get_user_credentials.dart';
import '../../../screens/add-post/add_post.dart';
import '../../../services/post_crud.dart';
import '../../../models/post_model.dart';
import './post_on_home.dart';
import '../reusable/post.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});
  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  Future<List<PostModel>>? posts;
  @override
  void initState() {
    super.initState();
    fetchUserProfilePhoto();
    posts = PostCrud()
        .getPosts(getUserCredentials()["username"]!)
        .then((value) => value);
  }

  Future<bool> fetchUserProfilePhoto() async {
    if (checkForAuthProvider() != "google") {
      final response =
          await getEmailUserProfilePhoto(getUserCredentials()["userEmail"]!);
      print("Response is $response");
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
        future: fetchUserProfilePhoto(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return Scaffold(
                backgroundColor: Theme.of(context).colorScheme.surface,
                appBar: AppBar(
                    backgroundColor: Theme.of(context).colorScheme.surface,
                    shadowColor: Colors.black,
                    elevation: 1,
                    leadingWidth: 170,
                    leading: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(width: 20),
                          Icon(Icons.connect_without_contact,
                              size: 25,
                              color: Theme.of(context).colorScheme.primary),
                          SizedBox(width: 10),
                          Text('SocioGram',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Poppins')),
                        ]),
                    actions: [
                      Builder(
                          builder: (context) => IconButton(
                              icon: CircleAvatar(
                                backgroundColor: Colors.transparent,
                                backgroundImage: CachedNetworkImageProvider(
                                    getUserCredentials()["image"]!),
                                radius: 15,
                              ),
                              onPressed: () {
                                Scaffold.of(context).openEndDrawer();
                              }))
                    ]),
                endDrawer: SliderMenu(),
                body: FutureBuilder<List<PostModel>>(
                    future: posts,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                            child: CircularProgressIndicator(
                                color: Theme.of(context).colorScheme.primary));
                      } else if (snapshot.hasError) {
                        return const Center(child: Text('Error loading posts'));
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return Center(
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                              SizedBox(
                                  width: 190,
                                  height: 50,
                                  child: ElevatedButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const AddPost()));
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                      ),
                                      child: Row(children: [
                                        Icon(Icons.add, color: Colors.white),
                                        SizedBox(width: 15),
                                        Text("Create a Post",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontFamily: 'Poppins',
                                                color: Colors.white))
                                      ]))),
                              const SizedBox(height: 10),
                              const Text('Add a post to get Started.',
                                  style: TextStyle(
                                      fontFamily: 'Inria', fontSize: 16)),
                            ]));
                      } else {
                        return CustomScrollView(
                          slivers: [
                            const SliverToBoxAdapter(
                                child: SizedBox(height: 20)),
                            const SliverToBoxAdapter(child: PostOnHome()),
                            const SliverToBoxAdapter(
                                child: SizedBox(height: 30)),
                            SliverList(
                              delegate: SliverChildBuilderDelegate(
                                (context, index) {
                                  final post = snapshot.data?[index];
                                  return Post(post: post!);
                                },
                                childCount: snapshot.data?.length,
                              ),
                            ),
                          ],
                        );
                      }
                    }));
          }
        
  }
    );
}
}
