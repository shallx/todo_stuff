import 'package:flutter/material.dart';
import 'package:todo_stuffasia/services/auth.dart';
import 'package:todo_stuffasia/shared/loading.dart';

import '../../shared/constant.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  String email = "";
  String password = "";
  String error = "";

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              title: Text("Sign in Page"),
              actions: [
                TextButton.icon(
                  onPressed: () {
                    widget.toggleView();
                  },
                  icon: Icon(Icons.logout),
                  label: Text("Register"),
                ),
              ],
            ),
            body: Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // SizedBox(
                    //   height: 100.0,
                    // ),

                    Container(
                      margin: EdgeInsets.only(
                        bottom: 30,
                      ),
                      height: 70,
                      width: MediaQuery.of(context).size.width / 3,
                      child: Hero(
                          tag: "logo",
                          child: Image.asset("assets/img/logo.png")),
                    ),

                    fieldContainer(
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Email field can't be empty";
                          }
                          const pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
                          final regExp = RegExp(pattern);

                          if (!regExp.hasMatch(value)) {
                            return "not a valid email";
                          }
                          return null;
                        },
                        decoration:
                            textInputDecoration.copyWith(hintText: 'email'),
                        onChanged: (val) {
                          setState(() {
                            email = val;
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    fieldContainer(
                      TextFormField(
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              value.length < 6) {
                            return "Password must be 6+ characters";
                          }
                          return null;
                        },
                        onChanged: (val) {
                          setState(() {
                            password = val;
                          });
                        },
                        decoration:
                            textInputDecoration.copyWith(hintText: 'password'),
                        obscureText: true,
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextButton(
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              setState(() => isLoading = true);
                              dynamic result =
                                  await _auth.signIn(email, password);
                              if (result == null) {
                                setState(() {
                                  isLoading = false;
                                  error =
                                      "Please enter correct email or password!";
                                });
                              }
                            }
                          },
                          child: Text("Login"),
                        ),
                        TextButton(
                          onPressed: () async {},
                          child: Text("Register"),
                        ),
                      ],
                    ),
                    SizedBox(height: 12.0),
                    Text(
                      error,
                      style: TextStyle(color: Colors.red, fontSize: 14.0),
                    )
                  ],
                ),
              ),
            ),
          );
  }

  Widget fieldContainer(child) {
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            color: Colors.grey[300],
            blurRadius: 10,
            spreadRadius: 3,
            offset: Offset(5, 6)),
        BoxShadow(
            color: Colors.grey[100],
            blurRadius: 10,
            spreadRadius: 3,
            offset: Offset(-3, 3))
      ]),
      child: child,
    );
  }
}
