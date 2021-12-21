import 'package:flutter/material.dart';

Color white = Colors.white;
Color black = Colors.black;
Color grey = Colors.grey;
Color red = Colors.red;
//methods
void changeScreen(BuildContext context, Widget widget) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
}

void changeScreenReplacement(BuildContext context, Widget widget) {
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => widget));
}
