import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'models.dart';

class UserListPage extends StatefulWidget {
  const UserListPage({super.key});

  @override
  State<UserListPage> createState() => _UserListPage();
}

class _UserListPage extends State<UserListPage> {
  List<User> users = [];

  @override
  void initState() {
    rootBundle.loadString("assets/userList.json").then((data) {
      var userObjsJson = jsonDecode(data)['users'] as List;
      List<User> userObjs =
          userObjsJson.map((tagJson) => User.fromJson(tagJson)).toList();
      users = userObjs;
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return EasyRefresh(
      onRefresh: () async {
        // Handle refresh logic
        await Future.delayed(const Duration(seconds: 2));
      },
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) => ListTile(title: Text('Item $index')),
        itemCount: 30,
      ),
    );
  }

/*
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        onRefresh: _handleRefresh,
        child: ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            User user = users[index];
            return ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.network(
                  user.profile.avatar,
                  fit: BoxFit.cover,
                ),
              ),
              title: Text(user.profile.nick),
              contentPadding: const EdgeInsets.all(2),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SecondRoute()),
                );
              },
            );
          },
        ));
  }
  */
}



