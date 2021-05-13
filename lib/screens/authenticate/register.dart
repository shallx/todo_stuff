import 'package:flutter/material.dart';
import 'package:todo_stuffasia/services/auth.dart';
import 'package:todo_stuffasia/shared/loading.dart';
import 'package:todo_stuffasia/widget/text_field_container.dart';

import '../../shared/constant.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  bool isLoading = false;
  String error = "";
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Loading()
        : Scaffold(
            body: Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        bottom: 30,
                      ),
                      height: 70,
                      width: MediaQuery.of(context).size.width / 3,
                      child: Hero(
                        tag: "logo",
                        child: Image.asset("assets/img/logo.png"),
                      ),
                    ),
                    TextFieldContainer(
                      isPassword: false,
                      onChanged: (val) {
                        setState(() {
                          email = val;
                        });
                      },
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
                    ),
                    SizedBox(height: 20.0),
                    TextFieldContainer(
                      isPassword: true,
                      onChanged: (val) {
                        setState(() {
                          password = val;
                        });
                      },
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value.length < 6) {
                          return "Password must be 6+ characters";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20.0),
                    SizedBox(
                      width: double.infinity,
                      child: TextButton(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Register',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        style: TextButton.styleFrom(shape: StadiumBorder()),
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            setState(() => isLoading = true);
                            dynamic result =
                                await _auth.register(email, password);
                            if (result == null) {
                              setState(() {
                                isLoading = false;
                                error = "Validation failed!";
                              });
                            }
                          }
                        },
                      ),
                    ),
                    SizedBox(height: 12.0),
                    Text(
                      error,
                      style: TextStyle(color: Colors.red, fontSize: 14.0),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Have an account? ",
                          style: TextStyle(color: Colors.grey[500]),
                        ),
                        GestureDetector(
                          onTap: (){
                            widget.toggleView();
                          },
                          child: Text(
                            "click here",
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                        Text(
                          " to login.",
                          style: TextStyle(color: Colors.grey[500]),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
  }
}
