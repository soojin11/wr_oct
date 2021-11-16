import 'package:flutter/material.dart';
import 'package:wr_ui/view/chart/chart_tabbar.dart';
import 'package:wr_ui/view/chart/main_chart.dart';
import 'package:wr_ui/view/chart/pages/ADDpage.dart';
import 'package:wr_ui/view/chart/pages/ALLpage.dart';
import 'package:wr_ui/view/chart/pages/CUSTOMpage.dart';
import 'package:wr_ui/view/chart/pages/VIpage.dart';

class OESpage extends StatelessWidget {
  const OESpage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // color: Colors.blueGrey,
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'OES페이지',
            ),
            chartTabBar(),
            SizedBox(
              height: 20,
            ),
            ///////////여기에 oes차트
            MainChart()
///////////여기에 oes차트
          ],
        ),
      ),
    );
  }
}
