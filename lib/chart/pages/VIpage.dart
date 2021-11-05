import 'package:flutter/material.dart';
import 'package:wr_ui/chart/main_chart.dart';

class VIpage extends StatefulWidget {
  const VIpage({Key? key}) : super(key: key);

  @override
  State<VIpage> createState() => _VIpageState();
}

class _VIpageState extends State<VIpage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.blueGrey,
      child: Column(
        children: [
          Text(
            'VI페이지',
          ),
          ChartPage(),
        ],
      ),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.amber),
          borderRadius: BorderRadius.circular(20)),
    );
  }
}
