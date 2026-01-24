import 'package:flutter/material.dart';

class AppWidget {
  static TextStyle boldTextstyle(double size) {
    return TextStyle(
      color: Colors.black,
      fontSize: size,
      fontWeight: FontWeight.bold,
      fontFamily: "Roboto",
    );
  }

  static TextStyle whiteTextstyle(double size) {
    return TextStyle(
      color: Colors.white,
      fontSize: size,
      fontWeight: FontWeight.bold,
      fontFamily: "Roboto",
    );
  }
}
