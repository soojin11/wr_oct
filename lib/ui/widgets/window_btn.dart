import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';

class WindowButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        MinimizeWindowButton(colors: windowBtnColors),
        CloseWindowButton(colors: closeBtnColors),
      ],
    );
  }

  final windowBtnColors = WindowButtonColors(
      iconNormal: Color(0xff0d47a1),
      mouseOver: Color(0xFFA2B4CE),
      mouseDown: Color(0xff0d47a1),
      iconMouseOver: Color(0xff0d47a1),
      iconMouseDown: Colors.white);

  final closeBtnColors = WindowButtonColors(
      iconNormal: Color(0xff0d47a1),
      mouseOver: Color(0xFFA2B4CE),
      mouseDown: Color(0xff0d47a1),
      iconMouseOver: Colors.white);
}
