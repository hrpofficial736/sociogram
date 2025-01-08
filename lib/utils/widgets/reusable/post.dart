import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../models/post_model.dart';
import '../../../services/like_post.dart';
import '../../../services/get_user_credentials.dart';
import '../screen_sections/comments_widget.dart';

class Post extends StatefulWidget {
  final PostModel post;
  const Post({super.key, required this.post});
  @override
  State<Post> createState() => _PostState();
}

class _PostState extends State<Post> {
  int _likeCount = 0;
  bool _isCurrentLiked = false;
  @override
  void initState() {
    super.initState();
    _isCurrentLiked =
        widget.post.usersWhoLiked?.contains(getUserCredentials()["username"]) ?? false;
    _likeCount = widget.post.usersWhoLiked?.length ?? 0;
    
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: SizedBox(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [
        const SizedBox(width: 15),
        CircleAvatar(
            backgroundImage:
                CachedNetworkImageProvider(widget.post.userProfilePic!),
            radius: 14),
        const SizedBox(width: 20),
        Text(widget.post.user!,
            style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
                fontSize: 15,
                fontFamily: "Inria",
                fontWeight: FontWeight.w600)),
      ]),
      const SizedBox(height: 30),
      Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Text(widget.post.description!,
              style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  fontSize: 15,
                  fontFamily: 'Ubuntu',
                  fontStyle: FontStyle.italic))),
      const SizedBox(height: 20),
      SizedBox(
          child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              child: CachedNetworkImage(
                  imageUrl: widget.post.image!,
                  placeholder: (context, url) => Container(
                      width: 380,
                      height: 200,
                      decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.tertiary,
                          borderRadius: BorderRadius.circular(10)))))),
      const SizedBox(height: 10),
      Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Container(
            height: 25,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Theme.of(context).colorScheme.surface,
              border:
                  Border.all(color: Theme.of(context).colorScheme.secondary),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 5.0),
                  child: Icon(
                    Icons.thumb_up_off_alt,
                    size: 15,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: Text(
                      "$_likeCount",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    )),
                
              ],
            ),
          )),
      const SizedBox(height: 10),
      Padding(
          padding: const EdgeInsets.only(bottom: 50),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            SizedBox(
                height: 50,
                child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        if (_isCurrentLiked) {
                          _likeCount--;
                          _isCurrentLiked = !_isCurrentLiked;
                          dislikePost(widget.post.id!);
                        } else {
                          _likeCount++;
                          _isCurrentLiked = !_isCurrentLiked;
                          likePost(widget.post.id!);
                        }
                      });
                    },
                    style: ElevatedButton.styleFrom(
                        elevation: 2,
                        backgroundColor: Theme.of(context).colorScheme.surface,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(20),
                                topLeft: Radius.circular(20)))),
                    child: Row(children: [
                      Icon(
                          _isCurrentLiked
                              ? Icons.thumb_up
                              : Icons.thumb_up_off_alt,
                          color: _isCurrentLiked
                              ? Theme.of(context).colorScheme.primary
                              : Theme.of(context).colorScheme.secondary,
                          size: 20),
                      const SizedBox(width: 10),
                      Text(_isCurrentLiked ? "Liked" : "Like",
                          style: TextStyle(
                              color: _isCurrentLiked
                                  ? Theme.of(context).colorScheme.primary
                                  : Theme.of(context).colorScheme.secondary,
                              fontFamily: "Inria",
                              fontSize: 12))
                    ]))),
            SizedBox(
                height: 50,
                child: ElevatedButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) => Dialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: CommentsWidget(
                                  postId: widget.post.id!,
                                  
                                ),
                              ));
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.surface,
                        elevation: 2,
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(0)))),
                    child: Row(mainAxisSize: MainAxisSize.min, children: [
                      Icon(Icons.comment,
                          color: Theme.of(context).colorScheme.secondary,
                          size: 20),
                      SizedBox(width: 10),
                      Text("Comment",
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary,
                              fontFamily: "Inria",
                              fontSize: 12))
                    ]))),
            SizedBox(
                height: 50,
                child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        elevation: 2,
                        backgroundColor: Theme.of(context).colorScheme.surface,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(20),
                                topRight: Radius.circular(20)))),
                    child: Row(children: [
                      Icon(Icons.share,
                          color: Theme.of(context).colorScheme.secondary,
                          size: 20),
                      SizedBox(width: 10),
                      Text("Share",
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary,
                              fontFamily: "Inria",
                              fontSize: 12))
                    ]))),
          ]))
    ])));
  }
}
