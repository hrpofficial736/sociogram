import 'package:flutter/material.dart';
import '../../../models/post_model.dart';
import '../reusable/post.dart';

class PostsOnProfile extends StatelessWidget {
  final Future<List<PostModel>> posts;
  const PostsOnProfile({super.key, required this.posts});
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const SizedBox(height: 50),
      Padding(
          padding: EdgeInsets.only(left: 10),
          child: Text("My Posts",
              style: TextStyle(
                  fontFamily: "Inria",
                  fontSize: 23,
                  color: Theme.of(context).colorScheme.secondary,
                  fontWeight: FontWeight.w800))),
      Divider(
          color: Theme.of(context).colorScheme.tertiary, thickness: 1, indent: 10, endIndent: 10),
      const SizedBox(height: 30),
      FutureBuilder<List<PostModel>>(
          future: posts,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                  child: CircularProgressIndicator(color: Theme.of(context).colorScheme.primary));
            } else if (snapshot.hasError) {
              return const Center(child: Text('Error loading posts'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text("No posts found!"));
            } else {
              return ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final post = snapshot.data![index];
                    return Post(post: post);
                  });
            }
          })
    ]));
  }
}
