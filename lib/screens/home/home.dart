import 'package:flutter/material.dart';
import 'package:todo_stuffasia/services/auth.dart';

class Home extends StatelessWidget {
  Home({Key key}) : super(key: key);

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo Page"),
        actions: [
          TextButton.icon(
            onPressed: () async {
              await _auth.signOut();
            },
            icon: Icon(Icons.person),
            label: Text("logout"),
          ),
        ],
      ),
      body: Text('Home'),
    );
  }
}
