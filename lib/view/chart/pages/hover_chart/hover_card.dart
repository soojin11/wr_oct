import 'package:flutter/material.dart';
import 'package:wr_ui/view/chart/pages/hover_chart/hover_mode.dart';

class HoverCard extends StatefulWidget {
  const HoverCard({Key? key}) : super(key: key);

  @override
  _HoverCardState createState() => _HoverCardState();
}

class _HoverCardState extends State<HoverCard> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal, child: hoverCard());
  }

  hoverCard() {//ddd
    return Row(
      children: List.generate(8, (int i) {
        return BtnHover(index: i, title: 'Hover!');
      }),
    );
  }
}
