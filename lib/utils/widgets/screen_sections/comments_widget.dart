import 'package:flutter/material.dart';
import '../../../services/comment_post.dart';
import '../reusable/comment_tile.dart';
import '../../../services/get_user_credentials.dart';

class CommentsWidget extends StatefulWidget {
  final int postId;
  const CommentsWidget({super.key, required this.postId});
  @override
  State<CommentsWidget> createState() => _CommentsWidgetState();
}

class _CommentsWidgetState extends State<CommentsWidget> {
  final TextEditingController _commentTextController = TextEditingController();
  late Future<List<Map<String, dynamic>>> comments;

  @override
  void initState() {
    super.initState();
    _refreshComments();
  }

  void _refreshComments() {
    setState(() {
      comments = CommentsCrud().getComments(widget.postId);
    });
  }

  Future<void> _handlePostComment() async {
    final commentText = _commentTextController.text.trim();
    if (commentText.isEmpty) return;

    try {
      await CommentsCrud().postAComment(
        widget.postId,
        getUserCredentials()["username"]!,
        commentText,
      );
      _commentTextController.clear();
      _refreshComments();
      
      
    } catch (e) {
      // Handle error if needed
      debugPrint('Error posting comment: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Column(
          children: [
            AppBar(
              backgroundColor: Theme.of(context).colorScheme.surface,
              automaticallyImplyLeading: false,
              title: const Text(
                "Comments",
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: "Inria",
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Column(
              children: [
                SizedBox(
                  height: 365,
                  child: FutureBuilder<List<Map<String, dynamic>>>(
                    future: comments,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(color: Theme.of(context).colorScheme.primary),
                        );
                      } else if (snapshot.hasError) {
                        return const Center(
                          child: Text('Error loading posts'),
                        );
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(
                          child: Text(
                            "Be the first one to comment",
                            style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 16,
                            ),
                          ),
                        );
                      }

                      return ListView.builder(
                        itemCount: snapshot.data?.length,
                        itemBuilder: (context, index) {
                          final comment = snapshot.data![index];
                          return CommentTile(commentInfo: comment);
                        },
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 240,
                        child: TextField(
                          style: const TextStyle(
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.bold,
                          ),
                          controller: _commentTextController,
                          cursorColor: Theme.of(context).colorScheme.secondary,
                          decoration: InputDecoration(
                            hintText: "Comment...",
                            hintStyle: TextStyle(
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w100,
                            ),
                            border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Theme.of(context).colorScheme.secondary, width: 0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Theme.of(context).colorScheme.secondary, width: 1),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Theme.of(context).colorScheme.secondary, width: 2),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30)),
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: _handlePostComment,
                        icon: Icon(Icons.send, color: Theme.of(context).colorScheme.primary),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _commentTextController.dispose();
    super.dispose();
  }
}
