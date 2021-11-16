import 'package:flutter/material.dart';
import 'package:wr_ui/view/chart/chart_tabbar.dart';
import 'package:wr_ui/view/chart/viz_chart.dart';
import 'package:wr_ui/view/chart/pages/navigator_page/ALLpage.dart';
import 'package:wr_ui/view/chart/pages/navigator_page/CUSTOMpage.dart';
import 'package:wr_ui/view/chart/pages/navigator_page/OESpage.dart';
import 'package:wr_ui/view/chart/pages/navigator_page/VIpage.dart';

class ADDpage extends StatelessWidget {
  ADDpage({Key? key}) : super(key: key);
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
              'ADD페이지',
            ),
            chartTabBar(),
            SizedBox(
              height: 20,
            ),
            ///////////여기에 Add차트

            ///////////여기에 Add차트
          ],
        ),
      ),
    );
  }
}
