import 'package:flutter/material.dart';

class MyStyle {
  Color darkColor = Color.fromRGBO(0, 0, 0, 1);
  Color primaryColor = Color.fromARGB(255, 248, 176, 121);
  Color lightColor = Colors.white;
  Color secondColor = Color.fromARGB(255, 250, 218, 189);

  TextStyle darkStyle() => TextStyle(color: darkColor);
  TextStyle whiteStyle() => TextStyle(color: Colors.white);
  TextStyle redStyle() => TextStyle(
      color: const Color.fromARGB(255, 243, 21, 6),
      fontWeight: FontWeight.bold,
      fontSize: 16);

  SafeArea buildBackground(double screenWidth, double screenHeight) {
    return SafeArea(
        child: Container(
      width: screenWidth,
      height: screenHeight,
      child: Stack(
        children: [
          Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                width: screenWidth,
                height: screenHeight * 1.0,
                color: MyStyle().primaryColor,
              )
              // Image(image: AssetImage('images/bg.png'))
              ),
        ],
      ),
    ));
  }

  SafeArea buildLogo(double screenWidth, double screenHeight) {
    return SafeArea(
        child: Container(
      width: 80,
      height: 80,
      child: Stack(
        children: [
          Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Image(image: AssetImage('images/logo2.png'))),
        ],
      ),
    ));
  }

  MyStyle();
}
