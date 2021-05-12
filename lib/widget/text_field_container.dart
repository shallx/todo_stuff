import 'package:flutter/material.dart';
import 'package:todo_stuffasia/shared/constant.dart';

class TextFieldContainer extends StatelessWidget {
  final Function validator;
  final Function onChanged;
  final bool isPassword;

  const TextFieldContainer(
      {Key key, this.validator, this.onChanged, this.isPassword = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
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
      child: TextFormField(
        obscureText: isPassword,
        validator: validator,
        onChanged: onChanged,
        decoration: textInputDecoration.copyWith(
          hintText: isPassword ? 'password' : 'email',
        ),
      ),
    );
  }
}