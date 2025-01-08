import 'package:flutter/material.dart';
import '../../services/search_users.dart';
import '../../utils/widgets/screen_sections/users_list.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchTextChanged);
  }

  void _onSearchTextChanged() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        title: const Text(
          "Search",
          style: TextStyle(
            fontFamily: "Inria",
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SizedBox(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              TextField(
                onChanged: (String text) {
                  searchUsers(text);
                },
                style: const TextStyle(
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.bold,
                ),
                controller: _searchController,
                cursorColor: Theme.of(context).colorScheme.secondary,
                decoration: InputDecoration(
                  hintText: "Search for users...",
                  hintStyle: TextStyle(
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w100,
                  ),
                  prefixIcon: Icon(Icons.search),
                  prefixIconColor: Theme.of(context).colorScheme.secondary,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Theme.of(context).colorScheme.secondary, width: 0),
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Theme.of(context).colorScheme.secondary, width: 1),
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Theme.of(context).colorScheme.secondary, width: 2),
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                ),
              ),
              _searchController.text.isNotEmpty
                  ? UsersList(searchText: _searchController.text)
                  : Expanded(
                      child: Center(
                        child: Text(
                          "No users found",
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
