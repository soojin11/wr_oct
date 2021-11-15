import 'package:flutter/material.dart';
import 'package:wr_ui/new/btn.dart';

class HoverPage extends StatefulWidget {
  const HoverPage({Key? key}) : super(key: key);

  @override
  _HoverPageState createState() => _HoverPageState();
}

class _HoverPageState extends State<HoverPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Center(
        child: Container(
          child: btnUI(),
        ),
      ),
    );
  }

  btnUI() {
    return Row(
      children: List.generate((8), (int i) {
        return BtnHover(index: i, title: 'Hover!');
      }),
    );
  }
}
