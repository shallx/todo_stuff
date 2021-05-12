import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:todo_stuffasia/models/user.dart';
import 'package:todo_stuffasia/screens/authenticate/authenticate.dart';
import 'package:todo_stuffasia/screens/home/stupid_page.dart';
import 'package:todo_stuffasia/screens/home/todo_screen.dart';
import 'package:todo_stuffasia/screens/wrapper.dart';
import 'package:todo_stuffasia/shared/routeTransition.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    routeToNextPage();
    super.initState();
  }

  void routeToNextPage() async {
    // final user = Provider.of<AuthUser>(context);
    await Future.delayed(Duration(seconds: 1));
    // Navigator.push(context, SlideLeftRoute(page: Wrapper()));
    Get.off(() => Wrapper());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(
                bottom: 30,
              ),
              height: 70,
              width: MediaQuery.of(context).size.width / 2,
              child:
                  Hero(tag: "logo", child: Image.asset("assets/img/logo.png")),
            ),
            SpinKitChasingDots(
              color: Colors.green.shade300,
              size: 50.0,
            )
          ],
        ),
      ),
    );
  }
}
