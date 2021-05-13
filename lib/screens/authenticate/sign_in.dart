import 'package:flutter/material.dart';
import '../../services/auth.dart';
import '../../shared/loading.dart';
import '../../widget/text_field_container.dart';

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
            body: Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
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
                    SizedBox(
                      height: 20.0,
                    ),
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
                    SizedBox(
                      height: 20.0,
                    ),

                    SizedBox(
                      width: double.infinity,
                      child: TextButton(
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            setState(() => isLoading = true);
                            print("Email: $email\n Password: $password");
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
                        style: TextButton.styleFrom(shape: StadiumBorder()),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Login"),
                        ),
                      ),
                    ),
                    SizedBox(height: 12.0),
                    Text(
                      error,
                      style: TextStyle(color: Colors.red, fontSize: 14.0),
                    ),
                    Text(
                      "Don't have an account?",
                      style: TextStyle(color: Colors.grey[500]),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextButton(
                      onPressed: () {
                        widget.toggleView();
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                      ),
                      child: Text(
                        "SIGN UP NOW",
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
