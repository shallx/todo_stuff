import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_stuffasia/models/user.dart';
import 'package:todo_stuffasia/screens/authenticate/authenticate.dart';
import 'package:todo_stuffasia/screens/home/todo_screen.dart';
import '../screens/categories/categories_screen.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthUser>(context);

    // return either home or authenticate widget
    if (user == null) {
      return Authenticate();
    } else {
      return TodoScreen();
    }
  }
}
