import 'package:flutter/material.dart';
import 'hover_func.dart';

class ArrangeHover extends StatelessWidget {
  const ArrangeHover({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal, child: hoverCard());
  }
  hoverCard() {//ddd
    return Row(
      children: [
        FirstHover(),
        SecondHover(),
        ThirdHover(),
        FourthHover(),
        FifthHover(),
        SixthHover(),
        SeventhHover(),
        EightHover()
      ],
    );
  }
}