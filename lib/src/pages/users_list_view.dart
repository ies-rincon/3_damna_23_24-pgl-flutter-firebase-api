import 'package:firebase_api/src/services/user_service.dart';
import 'package:flutter/material.dart';
import 'users_details_view.dart';
import '../models/user_model.dart';

class UsersListView extends StatefulWidget {
  const UsersListView({super.key});
  @override
  State<UsersListView> createState() => _UsersListViewState();
}

class _UsersListViewState extends State<UsersListView> {
  bool isLoading = true;
  List<User> users = [];
  final UserService userService = UserService();

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  Future<void> fetchUsers() async {
    final fetchedUsers = await userService.fetchUsers();
    setState(() {
      isLoading = false;
      users = fetchedUsers;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Usuarios'),
      ),
      body: isLoading
          ? const Center(
              child:
                  CircularProgressIndicator(), // Muestra el loader mientras se carga
            )
          : ListView.builder(
              restorationId: 'userItemListView',
              itemCount: users.length,
              itemBuilder: (BuildContext context, int index) {
                final user = users[index];
                return ListTile(
                  title: Text(user.name),
                  subtitle: Text(user.email),
                  leading: CircleAvatar(
                    foregroundImage: NetworkImage(user.img),
                  ),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => UserDetailsView(user: user),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
