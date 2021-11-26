import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:wr_ui/model/const/style/pallette.dart';

class WindowButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 48,
          child: MinimizeWindowButton(colors: windowBtnColors),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Container(
          height: 48,
          child: CloseWindowButton(colors: closeBtnColors),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
          ),
        ),
        SizedBox(
          width: 10,
        ),
      ],
    );
  }

  final windowBtnColors = WindowButtonColors(
      iconNormal: wrColors.white,
      mouseOver: Color(0xFFA2B4CE),
      // mouseDown: Color(0xff0d47a1),
      iconMouseOver: wrColors.white,
      iconMouseDown: wrColors.white);

  final closeBtnColors = WindowButtonColors(
      iconNormal: wrColors.white,
      mouseOver: Colors.redAccent,
      mouseDown: Color(0xff0d47a1),
      iconMouseOver: wrColors.white);
}
