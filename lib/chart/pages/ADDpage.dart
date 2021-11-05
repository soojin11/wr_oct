import 'package:flutter/material.dart';
import 'package:wr_ui/chart/main_chart.dart';

class ADDpage extends StatelessWidget {
  const ADDpage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.blueGrey,
      child: Column(
        children: [
          Text(
            'ADD페이지',
          ),
          ChartPage(),
        ],
      ),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.greenAccent),
          borderRadius: BorderRadius.circular(20)),
    );
  }
}
