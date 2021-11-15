import 'package:flutter/material.dart';
import 'package:wr_ui/view/chart/chart_tabbar.dart';
import 'package:wr_ui/view/chart/main_chart.dart';
import 'package:wr_ui/view/chart/pages/ADDpage.dart';
import 'package:wr_ui/view/chart/pages/ALLpage.dart';
import 'package:wr_ui/view/chart/pages/CUSTOMpage.dart';
import 'package:wr_ui/view/chart/pages/OESpage.dart';

class VIpage extends StatefulWidget {
  const VIpage({Key? key}) : super(key: key);

  @override
  State<VIpage> createState() => _VIpageState();
}

class _VIpageState extends State<VIpage> {
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
              'VI페이지',
            ),
            chartTabBar(),
            SizedBox(
              height: 20,
            ),
            ///////////여기에 vi차트

            ///////////여기에 vi차트
          ],
        ),
      ),
    );
  }
}
