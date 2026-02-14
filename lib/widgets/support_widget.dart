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

  static Widget nonSelected(String size) {
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromARGB(88, 0, 0, 0)),
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Center(child: Text(size, style: AppWidget.boldTextstyle(18))),
    );
  }

  static Widget selectedone(String size) {
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        color: Color(0xff6e5038),
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Center(child: Text(size, style: AppWidget.whiteTextstyle(18.0))),
    );
  }
}
