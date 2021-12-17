import 'dart:async';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wr_ui/view/chart/oes_chart.dart';

class VizController extends GetxController {
  RxList<FlSpot> vizData = RxList.empty();

  Future<void> updateViz(Timer timer) async {}
}

class VizChart extends StatelessWidget {
  const VizChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20),
      child: GetBuilder<OesController>(
        builder: (controller) => InteractiveViewer(
          child: Container(
            padding: EdgeInsets.only(left: 20, right: 20, top: 10),
            child: OesChart().LineChartForm(
              controller: controller,
              lineBarsData: [],
              bottomTitles: SideTitles(
                showTitles: true,
                reservedSize: 20, //글씨 밑에 margin 주기
                getTextStyles: (BuildContext, double) => const TextStyle(
                  color: Color(0xff68737d),
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
                getTitles: (value) {
                  return '${value.round()}';
                },
                margin: 8, //스캐일에 쓴 글씨와 그래프의 margin
              ),
              leftTitles: SideTitles(
                showTitles: true,
                getTextStyles: (BuildContext, double) => const TextStyle(
                  color: Color(0xff67727d),
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
                getTitles: (value) {
                  switch (value.toInt()) {
                    case 0:
                      return '10k';
                    case 250:
                      return '30k';
                    case 500:
                      return '50k';
                  }
                  return '';
                },
                reservedSize: 10,
                margin: 12,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
