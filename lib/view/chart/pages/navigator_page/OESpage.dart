import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wr_ui/model/const/style/pallette.dart';
import 'package:wr_ui/view/chart/chart_tabbar.dart';
import 'package:wr_ui/view/chart/oes_chart.dart';

class OESpage extends StatelessWidget {
  const OESpage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // color: Colors.blueGrey,
      body: Container(
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
            //   'OES페이지',
            // ),
            chartTabBar(),
            SizedBox(
              height: 20,
            ),
            OesChart()
          ],
        ),
      ),
    );
  }
}