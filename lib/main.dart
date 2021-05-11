import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:todo_stuffasia/screens/splashScreen/splashScreen.dart';
import 'package:todo_stuffasia/screens/wrapper.dart';
import 'package:todo_stuffasia/services/auth.dart';
import 'package:get_storage/get_storage.dart';

import 'models/user.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamProvider<AuthUser>.value(
      value: AuthService().user,
      initialData: AuthUser(),
      child: Listener(
        onPointerDown: (_) {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus &&
              currentFocus.focusedChild != null) {
            currentFocus.focusedChild.unfocus();
          }
        },
        child: GetMaterialApp(
          title: 'Flultter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColor: Colors.teal[400],
            scaffoldBackgroundColor: Colors.grey[50],
            appBarTheme: AppBarTheme(
              backgroundColor: Colors.teal[400],
              elevation: 0.0,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary: Colors.white,
                backgroundColor: Colors.teal[400],
                onSurface: Colors.green,
                elevation: 2,
              ),
            ),
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: SplashScreen()// Wrapper(),
        ),
      ),
    );
  }
}
