import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CommentTile extends StatelessWidget {
  late Map<String, dynamic> commentInfo;
  CommentTile({super.key, required this.commentInfo});
  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: CircleAvatar(
            backgroundImage: CachedNetworkImageProvider(
                commentInfo["users"]["profile_photo_url"]!)),
        title: Text(commentInfo["users"]["name"]!,
            style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontFamily: "Poppins",
                fontWeight: FontWeight.w700)),
        subtitle: Container(
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(10)),
            child: Padding(
                padding: EdgeInsets.all(5),
                child: Text(commentInfo["commentText"]!,
                    style: TextStyle(fontFamily: "Ubuntu", fontSize: 15)))));
  }
}
