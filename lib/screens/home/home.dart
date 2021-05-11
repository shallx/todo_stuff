import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_stuffasia/services/auth.dart';
import 'package:todo_stuffasia/services/database.dart';

class Home extends StatelessWidget {
  Home({Key key}) : super(key: key);

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return StreamProvider.value(
      value: DatabaseService().brews,
      initialData: null,
      child: Scaffold(
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
        body: Center(
          child: TextButton(
            onPressed: () async {
              DocumentSnapshot result = await DatabaseService().instatBrews();
              print("Here lies data!!!!!!!!!!!!!!!!!!!!!!!!!!");
              print(result.data());
            },
            child: Text("Get data"),
          ),
        ),
      ),
    );
  }
}
