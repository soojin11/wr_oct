import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wr_ui/model/const/style/pallette.dart';
import 'package:wr_ui/view/chart/chart_tabbar.dart';
import 'package:wr_ui/view/chart/oes_chart.dart';
import 'package:wr_ui/view/chart/viz_chart.dart';

class ALLpage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // color: Theme.of(context).appBarTheme.foregroundColor,
        decoration: BoxDecoration(
          color: Get.isDarkMode ? wrColors.wrDarkAppBar : Colors.white
          // Theme.of(context).appBarTheme.foregroundColor
          ,
          boxShadow: [
            BoxShadow(
              color: Get.isDarkMode
                  ? Colors.black26
                  : Colors.grey.withOpacity(0.2), //그림자 색
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 2), // 그림자위치 바꾸는거
            ),
          ],
          borderRadius: BorderRadius.circular(10),
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text(
            //   'ALL페이지',
            // ),
            chartTabBar(),
            // Expanded(
            //   flex: 1,
            //   child: VizChart(),
            // ),
            Expanded(
              flex: 1,
              child: OesChart(),
            ),
            ///////////여기에 ALL차트

            ///////////여기에 ALL차트
          ],
        ),
      ),
    );
  }
}
