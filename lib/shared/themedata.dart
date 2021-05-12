import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

enum ThemeProfile { light, dark }

ThemeData customTheme(ThemeProfile prof) {
  if (prof == ThemeProfile.light) {
    // Color _primaryColr = Colors.orange[400];
    Color _backgroundColor = Colors.white;
    Color _defaultTextColor = Colors.black;
    Color _defaultIconColor = Colors.black;

    ThemeData lightTheme = ThemeData.light();
    ThemeData darkTheme = ThemeData.dark();

    return ThemeData(
      scaffoldBackgroundColor: _backgroundColor,
      backgroundColor: _backgroundColor,
      appBarTheme: AppBarTheme(
        color: _backgroundColor,
        textTheme: TextTheme(
          headline6: TextStyle(
            color: _defaultTextColor,
            fontSize: 22,
          ),
        ),
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        actionsIconTheme: IconThemeData(color: _defaultIconColor),
        elevation: 1,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: Colors.white,
        foregroundColor: Colors.blue,
      ),
      iconTheme: IconThemeData(color: _defaultIconColor = Colors.black),
      primaryIconTheme:
          IconThemeData(color: _defaultIconColor = Colors.grey.shade700),
      accentIconTheme: IconThemeData(color: _defaultIconColor = Colors.black),
      canvasColor: _backgroundColor,
    );
  }
  return ThemeData.dark();
}

class StyleSheet {
  StyleSheet();

  Margin margin([double margin = 15]) {
    return Margin(margin);
  }

  TextStyle get greyTextStyle =>
      TextStyle(fontSize: 13, color: Colors.grey.shade600);
}

class Margin {
  Margin([this._marginUnit = 15]);

  double _marginUnit = 15;
  double get marginUnit => _marginUnit;
  EdgeInsets get leftMargin => EdgeInsets.only(left: _marginUnit);
  EdgeInsets get bottomtMargin => EdgeInsets.only(bottom: _marginUnit);
  EdgeInsets get topMargin => EdgeInsets.only(top: _marginUnit);
  EdgeInsets get topLeftMargin =>
      EdgeInsets.only(top: _marginUnit, left: _marginUnit);
  EdgeInsets get verticalMargin => EdgeInsets.symmetric(vertical: _marginUnit);
  EdgeInsets get horizontalMargin =>
      EdgeInsets.symmetric(horizontal: _marginUnit);
  EdgeInsets get allMargin => EdgeInsets.all(_marginUnit);
}
