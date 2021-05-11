import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todo_stuffasia/models/user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  AuthUser _minifiedUser(User user) {
    // TODO : Change Null concept
    return user != null ? AuthUser(uid: user.uid) : null;
  }

  // Auth changes
  Stream<AuthUser> get user {
    return _auth.authStateChanges().map(_minifiedUser);
  }

  // Annonymous Sign In
  Future signInAnony() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User user = result.user;
      return _minifiedUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signIn(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      return _minifiedUser(user);
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  Future register(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      return _minifiedUser(user);
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
