import 'package:flutter/material.dart';
import 'package:wr_ui/chart/main_chart.dart';

class OESpage extends StatelessWidget {
  const OESpage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.blueGrey,
      child: Column(
        children: [
          Text(
            'OES페이지',
          ),
          ChartPage(),
        ],
      ),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.pinkAccent),
          borderRadius: BorderRadius.circular(20)),
    );
  }
}
