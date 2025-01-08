import 'package:flutter/material.dart';
import '../reusable/users_list_tile.dart';
import '../../../services/search_users.dart';

class UsersList extends StatefulWidget {
  final String searchText;
  const UsersList({super.key, required this.searchText});
  @override
  State<UsersList> createState() => _UsersListState();
}

class _UsersListState extends State<UsersList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Container(
            decoration: BoxDecoration(color: Theme.of(context).colorScheme.surface),
            child: Padding(
                padding: EdgeInsets.all(10),
                child: FutureBuilder<List<dynamic>>(
                    future: searchUsers(widget.searchText),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                            child:
                                CircularProgressIndicator(color: Theme.of(context).colorScheme.primary));
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return Center(child: Text('No users found.'));
                      }
                      final users = snapshot.data;

                      return ListView.builder(
                          shrinkWrap: true,
                          itemCount: users?.length,
                          itemBuilder: (context, index) {
                            final user = users?[index];
                            return UsersListTile(user: user);
                          });
                    }))));
  }
}
