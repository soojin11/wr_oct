import 'package:flutter/material.dart';
import 'package:wr_ui/model/const/style/pallette.dart';
import 'package:wr_ui/view/chart/chart_tabbar.dart';
import 'package:wr_ui/view/chart/oes_chart.dart';
import 'package:wr_ui/view/chart/viz_chart.dart';
import 'package:wr_ui/view/chart/pages/ADDpage.dart';
import 'package:wr_ui/view/chart/pages/CUSTOMpage.dart';
import 'package:wr_ui/view/chart/pages/OESpage.dart';
import 'package:wr_ui/view/chart/pages/VIpage.dart';

class ALLpage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // color: Colors.blueGrey,
      body: Container(
        decoration: BoxDecoration(
          color: wrColors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'ALL페이지',
            ),
            chartTabBar(),
            SizedBox(
              height: 20,
            ),
            VizChart(),
            OesChart()
            ///////////여기에 ALL차트
            MainChart()
            ///////////여기에 ALL차트
          ],
        ),
      ),
    );
  }
}
