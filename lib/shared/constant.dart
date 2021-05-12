import 'package:flutter/material.dart';

const textInputDecoration = InputDecoration(
  fillColor: Colors.white,
  filled: true,
  contentPadding: EdgeInsets.all(12.0),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white, width: 2.0),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.teal, width: 2.0),
  ),
);

// const BoxDecoration fieldBoxDeco = BoxDecoration(boxShadow: [
//   BoxShadow(
//       color: Colors.grey[300],
//       blurRadius: 10,
//       spreadRadius: 3,
//       offset: Offset(5, 6)),
//   BoxShadow(
//       color: Colors.grey[100],
//       blurRadius: 10,
//       spreadRadius: 3,
//       offset: Offset(-3, 3))
// ]);
