import 'dart:convert';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:wr_ui/controller/viz_ctrl.dart';
import 'package:wr_ui/view/right_side_menu/save_ini.dart';

class VizChart extends GetView<VizCtrl> {
  VizChart({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(top: 20),
        child: GetBuilder<VizCtrl>(
          builder: (controller) => Obx(
            () => Container(
              padding: EdgeInsets.only(left: 20, right: 20, top: 10),
              child: LineChartForm(
                controller: controller,
                lineBarsData: [
                  if (VizCtrl.to.vizSeriesList[0] &&
                      VizCtrl.to.vizCheck1.value == true)
                    lineChartBarData(VizCtrl.to.vizPoints[0][0],
                        Get.find<iniController>().vizColor[0]),
                  if (VizCtrl.to.vizSeriesList[1] &&
                      VizCtrl.to.vizCheck1.value == true)
                    lineChartBarData(VizCtrl.to.vizPoints[0][1],
                        Get.find<iniController>().vizColor[1]),
                  if (VizCtrl.to.vizSeriesList[2] &&
                      VizCtrl.to.vizCheck1.value == true)
                    lineChartBarData(VizCtrl.to.vizPoints[0][2],
                        Get.find<iniController>().vizColor[2]),
                  if (VizCtrl.to.vizSeriesList[3] &&
                      VizCtrl.to.vizCheck1.value == true)
                    lineChartBarData(VizCtrl.to.vizPoints[0][3],
                        Get.find<iniController>().vizColor[3]),
                  if (VizCtrl.to.vizSeriesList[4] &&
                      VizCtrl.to.vizCheck1.value == true)
                    lineChartBarData(VizCtrl.to.vizPoints[0][4],
                        Get.find<iniController>().vizColor[4]),
                  if (VizCtrl.to.vizSeriesList[5] &&
                      VizCtrl.to.vizCheck1.value == true)
                    lineChartBarData(VizCtrl.to.vizPoints[0][5],
                        Get.find<iniController>().vizColor[5]),
                  if (VizCtrl.to.vizSeriesList[6] &&
                      VizCtrl.to.vizCheck1.value == true)
                    lineChartBarData(VizCtrl.to.vizPoints[0][6],
                        Get.find<iniController>().vizColor[6]),
                  //
                  if (VizCtrl.to.vizSeriesList[0] &&
                      VizCtrl.to.vizCheck2.value == true)
                    lineChartBarData(VizCtrl.to.vizPoints[1][0],
                        Get.find<iniController>().vizColor[0]),
                  if (VizCtrl.to.vizSeriesList[1] &&
                      VizCtrl.to.vizCheck2.value == true)
                    lineChartBarData(VizCtrl.to.vizPoints[1][1],
                        Get.find<iniController>().vizColor[1]),
                  if (VizCtrl.to.vizSeriesList[2] &&
                      VizCtrl.to.vizCheck2.value == true)
                    lineChartBarData(VizCtrl.to.vizPoints[1][2],
                        Get.find<iniController>().vizColor[2]),
                  if (VizCtrl.to.vizSeriesList[3] &&
                      VizCtrl.to.vizCheck2.value == true)
                    lineChartBarData(VizCtrl.to.vizPoints[1][3],
                        Get.find<iniController>().vizColor[3]),
                  if (VizCtrl.to.vizSeriesList[4] &&
                      VizCtrl.to.vizCheck2.value == true)
                    lineChartBarData(VizCtrl.to.vizPoints[1][4],
                        Get.find<iniController>().vizColor[4]),
                  if (VizCtrl.to.vizSeriesList[5] &&
                      VizCtrl.to.vizCheck2.value == true)
                    lineChartBarData(VizCtrl.to.vizPoints[1][5],
                        Get.find<iniController>().vizColor[5]),
                  if (VizCtrl.to.vizSeriesList[6] &&
                      VizCtrl.to.vizCheck2.value == true)
                    lineChartBarData(VizCtrl.to.vizPoints[1][6],
                        Get.find<iniController>().vizColor[6]),
                  //
                  if (VizCtrl.to.vizSeriesList[0] &&
                      VizCtrl.to.vizCheck3.value == true)
                    lineChartBarData(VizCtrl.to.vizPoints[2][0],
                        Get.find<iniController>().vizColor[0]),
                  if (VizCtrl.to.vizSeriesList[1] &&
                      VizCtrl.to.vizCheck3.value == true)
                    lineChartBarData(VizCtrl.to.vizPoints[2][1],
                        Get.find<iniController>().vizColor[1]),
                  if (VizCtrl.to.vizSeriesList[2] &&
                      VizCtrl.to.vizCheck3.value == true)
                    lineChartBarData(VizCtrl.to.vizPoints[2][2],
                        Get.find<iniController>().vizColor[2]),
                  if (VizCtrl.to.vizSeriesList[3] &&
                      VizCtrl.to.vizCheck3.value == true)
                    lineChartBarData(VizCtrl.to.vizPoints[2][3],
                        Get.find<iniController>().vizColor[3]),
                  if (VizCtrl.to.vizSeriesList[4] &&
                      VizCtrl.to.vizCheck3.value == true)
                    lineChartBarData(VizCtrl.to.vizPoints[2][4],
                        Get.find<iniController>().vizColor[4]),
                  if (VizCtrl.to.vizSeriesList[5] &&
                      VizCtrl.to.vizCheck3.value == true)
                    lineChartBarData(VizCtrl.to.vizPoints[2][5],
                        Get.find<iniController>().vizColor[5]),
                  if (VizCtrl.to.vizSeriesList[6] &&
                      VizCtrl.to.vizCheck3.value == true)
                    lineChartBarData(VizCtrl.to.vizPoints[2][6],
                        Get.find<iniController>().vizColor[6]),
                  //
                  if (VizCtrl.to.vizSeriesList[0] &&
                      VizCtrl.to.vizCheck4.value == true)
                    lineChartBarData(VizCtrl.to.vizPoints[3][0],
                        Get.find<iniController>().vizColor[0]),
                  if (VizCtrl.to.vizSeriesList[1] &&
                      VizCtrl.to.vizCheck4.value == true)
                    lineChartBarData(VizCtrl.to.vizPoints[3][1],
                        Get.find<iniController>().vizColor[1]),
                  if (VizCtrl.to.vizSeriesList[2] &&
                      VizCtrl.to.vizCheck4.value == true)
                    lineChartBarData(VizCtrl.to.vizPoints[3][2],
                        Get.find<iniController>().vizColor[2]),
                  if (VizCtrl.to.vizSeriesList[3] &&
                      VizCtrl.to.vizCheck4.value == true)
                    lineChartBarData(VizCtrl.to.vizPoints[3][3],
                        Get.find<iniController>().vizColor[3]),
                  if (VizCtrl.to.vizSeriesList[4] &&
                      VizCtrl.to.vizCheck4.value == true)
                    lineChartBarData(VizCtrl.to.vizPoints[3][4],
                        Get.find<iniController>().vizColor[4]),
                  if (VizCtrl.to.vizSeriesList[5] &&
                      VizCtrl.to.vizCheck4.value == true)
                    lineChartBarData(VizCtrl.to.vizPoints[3][5],
                        Get.find<iniController>().vizColor[5]),
                  if (VizCtrl.to.vizSeriesList[6] &&
                      VizCtrl.to.vizCheck4.value == true)
                    lineChartBarData(VizCtrl.to.vizPoints[3][6],
                        Get.find<iniController>().vizColor[6]),
                  //
                  if (VizCtrl.to.vizSeriesList[0] &&
                      VizCtrl.to.vizCheck5.value == true)
                    lineChartBarData(VizCtrl.to.vizPoints[4][0],
                        Get.find<iniController>().vizColor[0]),
                  if (VizCtrl.to.vizSeriesList[1] &&
                      VizCtrl.to.vizCheck5.value == true)
                    lineChartBarData(VizCtrl.to.vizPoints[4][1],
                        Get.find<iniController>().vizColor[1]),
                  if (VizCtrl.to.vizSeriesList[2] &&
                      VizCtrl.to.vizCheck5.value == true)
                    lineChartBarData(VizCtrl.to.vizPoints[4][2],
                        Get.find<iniController>().vizColor[2]),
                  if (VizCtrl.to.vizSeriesList[3] &&
                      VizCtrl.to.vizCheck5.value == true)
                    lineChartBarData(VizCtrl.to.vizPoints[4][3],
                        Get.find<iniController>().vizColor[3]),
                  if (VizCtrl.to.vizSeriesList[4] &&
                      VizCtrl.to.vizCheck5.value == true)
                    lineChartBarData(VizCtrl.to.vizPoints[4][4],
                        Get.find<iniController>().vizColor[4]),
                  if (VizCtrl.to.vizSeriesList[5] &&
                      VizCtrl.to.vizCheck5.value == true)
                    lineChartBarData(VizCtrl.to.vizPoints[4][5],
                        Get.find<iniController>().vizColor[5]),
                  if (VizCtrl.to.vizSeriesList[6] &&
                      VizCtrl.to.vizCheck5.value == true)
                    lineChartBarData(VizCtrl.to.vizPoints[4][6],
                        Get.find<iniController>().vizColor[6]),
                ],
                bottomTitles: SideTitles(
                  interval: 100,
                  showTitles: true,
                  getTitles: (value) {
                    return '${value.round()}';
                  },
                ),
                leftTitles: SideTitles(
                  showTitles: true, reservedSize: 40, margin: 10,

                  // getTitles: (value) {
                  //   String yVal = '';
                  //   switch (value.toInt()) {
                  //   }
                  // }
                ),
              ),
            ),
          ),
        ));
  }

  LineChart LineChartForm(
      {required VizCtrl controller,
      required List<LineChartBarData> lineBarsData,
      SideTitles? leftTitles,
      SideTitles? bottomTitles}) {
    return LineChart(
      LineChartData(
          maxX: VizCtrl.to.chartMaxX.value,
          minX: VizCtrl.to.chartMinX.value,
          // maxY: 1000,

          lineTouchData: LineTouchData(
              touchTooltipData: LineTouchTooltipData(
            fitInsideHorizontally: true,
            fitInsideVertically: true,
            // getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
            //   List<LineTooltipItem?> aa = [];
            //   for (var i = 0; i < touchedBarSpots.length; i++) {
            //     final textstyle = TextStyle(
            //       color: touchedBarSpots[i].bar.colors[0],
            //       fontWeight: FontWeight.bold,
            //       fontSize: 14,
            //     );
            //     String str = '';
            //     String y;
            //     if (touchedBarSpots[i].barIndex == 0)
            //       y = ('Freq : ${(touchedBarSpots[i].y * 100000).toStringAsFixed(2)}');
            //     else if (touchedBarSpots[i].barIndex == 1)
            //       y = ('P dlv : ${(touchedBarSpots[i].y / 2).toStringAsFixed(2)}');
            //     else if (touchedBarSpots[i].barIndex == 2)
            //       y = ('Vrms : ${(touchedBarSpots[i].y / 10).toStringAsFixed(2)}');
            //     else if (touchedBarSpots[i].barIndex == 3)
            //       y = ('Irms : ${(touchedBarSpots[i].y / 10).toStringAsFixed(2)}');
            //     else if (touchedBarSpots[i].barIndex == 4)
            //       y = ('R : ${(touchedBarSpots[i].y / 10).toStringAsFixed(2)}');
            //     else if (touchedBarSpots[i].barIndex == 5)
            //       y = ('X : ${(touchedBarSpots[i].y / 10).toStringAsFixed(2)}');
            //     else
            //       y = ('Phase : ${(touchedBarSpots[i].y * 360 / 1000).toStringAsFixed(2)}');
            //     str = y;

            //     // if (i == 0)
            //     //   str =
            //     //       '${touchedBarSpots[i].x.toStringAsFixed(1)}s \n $y';
            //     // else
            //     //   str = y;

            //     aa.add(LineTooltipItem(str, textstyle));
            //   }
            //   return aa;
            // }
          )),
          clipData: FlClipData.all(),
          titlesData: FlTitlesData(
              show: true,
              bottomTitles: bottomTitles,
              leftTitles: leftTitles,
              topTitles: SideTitles(showTitles: false),
              rightTitles: SideTitles(showTitles: false)),
          borderData: FlBorderData(
            show: true,
            border: Border.all(color: const Color(0xff37434d), width: 1),
          ),
          lineBarsData: lineBarsData),
      swapAnimationDuration: Duration.zero,
    );
  }

  LineChartBarData lineChartBarData(List<FlSpot> points, color) {
    return LineChartBarData(
        spots: points,
        dotData: FlDotData(
          show: false,
        ),
        colors: [color],
        barWidth: 1);
  }
}

// class VizModel {
//   bool seriesVisibles; // 보이는거
//   List<List<FlSpot>> vizVal; //series 여러개
//   Color color;
//   String port;
//   VizModel({
//     required this.seriesVisibles,
//     required this.vizVal,
//     required this.color,
//     required this.port,
//   });
// }

// class LineDataWGS extends StatelessWidget {
//   LineDataWGS({Key? key, required this.viz}) : super(key: key);
//   List<VizModel> viz;
//   LineChartBarData lineChartBarData(List<FlSpot> points, color) {
//     return LineChartBarData(
//         spots: points,
//         dotData: FlDotData(
//           show: false,
//         ),
//         colors: [color],
//         barWidth: 1);
//   }

//   @override
//   Widget build(BuildContext context) {
//     List<LineChartBarData> rt = [];
//     for (var i = 0; i < viz.length; i++) {
//       if (viz[i].seriesVisibles) {
//         for (var ii = 0; ii < viz[i].vizVal.length; ii++) {
//           rt.add(lineChartBarData(
//               viz[i].vizVal[ii], //VizCtrl.to.vizVal5[6],
//               viz[i].color));
//         }
//       }
//     }

//     return rt;
//   }
// }
