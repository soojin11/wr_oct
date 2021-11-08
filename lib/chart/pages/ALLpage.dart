import 'package:flutter/material.dart';
import 'package:wr_ui/chart/main_chart.dart';

class ALLpage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return Expanded(
    //   child: ChartPage(),
    // );
    return Container(
      // color: Colors.blueGrey,
      child: Column(
        children: [
          Text(
            'ALL페이지',
          ),
          ChartPage(),
        ],
      ),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.deepPurple),
          borderRadius: BorderRadius.circular(20)),
    );
  }
}
