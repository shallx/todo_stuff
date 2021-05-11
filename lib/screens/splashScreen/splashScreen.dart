import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_stuffasia/screens/wrapper.dart';
import 'package:todo_stuffasia/shared/routeTransition.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    routTowrapper();
    super.initState();
  }

  void routTowrapper() async {
    await Future.delayed(Duration(seconds: 3));
    Navigator.push( context, SlideLeftRoute(page: Wrapper()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          margin: EdgeInsets.only(
            bottom: 30,
          ),
          height: 70,
          width: MediaQuery.of(context).size.width / 2,
          child: Hero(tag: "logo", child: Image.asset("assets/img/logo.png")),
        ),
      ),
    );
  }
}
