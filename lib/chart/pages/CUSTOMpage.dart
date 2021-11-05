import 'package:flutter/material.dart';
import 'package:wr_ui/chart/main_chart.dart';

class CUSTOMpage extends StatelessWidget {
  const CUSTOMpage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.blueGrey,
      child: Column(
        children: [
          Text(
            'CUSTOM페이지',
          ),
          ChartPage(),
        ],
      ),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.blueAccent),
          borderRadius: BorderRadius.circular(20)),
    );
  }
}
