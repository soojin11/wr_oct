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
                    lineChartBarData(VizCtrl.to.vizVal1[0],
                        Get.find<iniController>().Series_Color_001.value),
                  if (VizCtrl.to.vizSeriesList[1] &&
                      VizCtrl.to.vizCheck1.value == true)
                    lineChartBarData(VizCtrl.to.vizVal1[1],
                        Get.find<iniController>().Series_Color_002.value),
                  if (VizCtrl.to.vizSeriesList[2] &&
                      VizCtrl.to.vizCheck1.value == true)
                    lineChartBarData(VizCtrl.to.vizVal1[2],
                        Get.find<iniController>().Series_Color_007.value),
                  if (VizCtrl.to.vizSeriesList[3] &&
                      VizCtrl.to.vizCheck1.value == true)
                    lineChartBarData(VizCtrl.to.vizVal1[3],
                        Get.find<iniController>().Series_Color_004.value),
                  if (VizCtrl.to.vizSeriesList[4] &&
                      VizCtrl.to.vizCheck1.value == true)
                    lineChartBarData(VizCtrl.to.vizVal1[4],
                        Get.find<iniController>().Series_Color_005.value),
                  if (VizCtrl.to.vizSeriesList[5] &&
                      VizCtrl.to.vizCheck1.value == true)
                    lineChartBarData(VizCtrl.to.vizVal1[5],
                        Get.find<iniController>().Series_Color_006.value),
                  if (VizCtrl.to.vizSeriesList[6] &&
                      VizCtrl.to.vizCheck1.value == true)
                    lineChartBarData(VizCtrl.to.vizVal1[6],
                        Get.find<iniController>().Series_Color_008.value),
                  //2
                  if (VizCtrl.to.vizSeriesList[0] &&
                      VizCtrl.to.vizCheck2.value == true)
                    lineChartBarData(VizCtrl.to.vizVal2[0],
                        Get.find<iniController>().Series_Color_001.value),
                  if (VizCtrl.to.vizSeriesList[1] &&
                      VizCtrl.to.vizCheck2.value == true)
                    lineChartBarData(VizCtrl.to.vizVal2[1],
                        Get.find<iniController>().Series_Color_002.value),
                  if (VizCtrl.to.vizSeriesList[2] &&
                      VizCtrl.to.vizCheck2.value == true)
                    lineChartBarData(VizCtrl.to.vizVal2[2],
                        Get.find<iniController>().Series_Color_007.value),
                  if (VizCtrl.to.vizSeriesList[3] &&
                      VizCtrl.to.vizCheck2.value == true)
                    lineChartBarData(VizCtrl.to.vizVal2[3],
                        Get.find<iniController>().Series_Color_004.value),
                  if (VizCtrl.to.vizSeriesList[4] &&
                      VizCtrl.to.vizCheck2.value == true)
                    lineChartBarData(VizCtrl.to.vizVal2[4],
                        Get.find<iniController>().Series_Color_005.value),
                  if (VizCtrl.to.vizSeriesList[5] &&
                      VizCtrl.to.vizCheck2.value == true)
                    lineChartBarData(VizCtrl.to.vizVal2[5],
                        Get.find<iniController>().Series_Color_006.value),
                  if (VizCtrl.to.vizSeriesList[6] &&
                      VizCtrl.to.vizCheck2.value == true)
                    lineChartBarData(VizCtrl.to.vizVal2[6],
                        Get.find<iniController>().Series_Color_008.value),
                  //3
                  if (VizCtrl.to.vizSeriesList[0] &&
                      VizCtrl.to.vizCheck3.value == true)
                    lineChartBarData(VizCtrl.to.vizVal3[0],
                        Get.find<iniController>().Series_Color_001.value),
                  if (VizCtrl.to.vizSeriesList[1] &&
                      VizCtrl.to.vizCheck3.value == true)
                    lineChartBarData(VizCtrl.to.vizVal3[1],
                        Get.find<iniController>().Series_Color_002.value),
                  if (VizCtrl.to.vizSeriesList[2] &&
                      VizCtrl.to.vizCheck3.value == true)
                    lineChartBarData(VizCtrl.to.vizVal3[2],
                        Get.find<iniController>().Series_Color_007.value),
                  if (VizCtrl.to.vizSeriesList[3] &&
                      VizCtrl.to.vizCheck3.value == true)
                    lineChartBarData(VizCtrl.to.vizVal3[3],
                        Get.find<iniController>().Series_Color_004.value),
                  if (VizCtrl.to.vizSeriesList[4] &&
                      VizCtrl.to.vizCheck3.value == true)
                    lineChartBarData(VizCtrl.to.vizVal3[4],
                        Get.find<iniController>().Series_Color_005.value),
                  if (VizCtrl.to.vizSeriesList[5] &&
                      VizCtrl.to.vizCheck3.value == true)
                    lineChartBarData(VizCtrl.to.vizVal3[5],
                        Get.find<iniController>().Series_Color_006.value),
                  if (VizCtrl.to.vizSeriesList[6] &&
                      VizCtrl.to.vizCheck3.value == true)
                    lineChartBarData(VizCtrl.to.vizVal3[6],
                        Get.find<iniController>().Series_Color_008.value),
                  //4
                  if (VizCtrl.to.vizSeriesList[0] &&
                      VizCtrl.to.vizCheck4.value == true)
                    lineChartBarData(VizCtrl.to.vizVal4[0],
                        Get.find<iniController>().Series_Color_001.value),
                  if (VizCtrl.to.vizSeriesList[1] &&
                      VizCtrl.to.vizCheck4.value == true)
                    lineChartBarData(VizCtrl.to.vizVal4[1],
                        Get.find<iniController>().Series_Color_002.value),
                  if (VizCtrl.to.vizSeriesList[2] &&
                      VizCtrl.to.vizCheck4.value == true)
                    lineChartBarData(VizCtrl.to.vizVal4[2],
                        Get.find<iniController>().Series_Color_007.value),
                  if (VizCtrl.to.vizSeriesList[3] &&
                      VizCtrl.to.vizCheck4.value == true)
                    lineChartBarData(VizCtrl.to.vizVal4[3],
                        Get.find<iniController>().Series_Color_004.value),
                  if (VizCtrl.to.vizSeriesList[4] &&
                      VizCtrl.to.vizCheck4.value == true)
                    lineChartBarData(VizCtrl.to.vizVal4[4],
                        Get.find<iniController>().Series_Color_005.value),
                  if (VizCtrl.to.vizSeriesList[5] &&
                      VizCtrl.to.vizCheck4.value == true)
                    lineChartBarData(VizCtrl.to.vizVal4[5],
                        Get.find<iniController>().Series_Color_006.value),
                  if (VizCtrl.to.vizSeriesList[6] &&
                      VizCtrl.to.vizCheck4.value == true)
                    lineChartBarData(VizCtrl.to.vizVal4[6],
                        Get.find<iniController>().Series_Color_008.value),
                  //5
                  if (VizCtrl.to.vizSeriesList[0] &&
                      VizCtrl.to.vizCheck5.value == true)
                    lineChartBarData(VizCtrl.to.vizVal5[0],
                        Get.find<iniController>().Series_Color_001.value),
                  if (VizCtrl.to.vizSeriesList[1] &&
                      VizCtrl.to.vizCheck5.value == true)
                    lineChartBarData(VizCtrl.to.vizVal5[1],
                        Get.find<iniController>().Series_Color_002.value),
                  if (VizCtrl.to.vizSeriesList[2] &&
                      VizCtrl.to.vizCheck5.value == true)
                    lineChartBarData(VizCtrl.to.vizVal5[2],
                        Get.find<iniController>().Series_Color_007.value),
                  if (VizCtrl.to.vizSeriesList[3] &&
                      VizCtrl.to.vizCheck5.value == true)
                    lineChartBarData(VizCtrl.to.vizVal5[3],
                        Get.find<iniController>().Series_Color_004.value),
                  if (VizCtrl.to.vizSeriesList[4] &&
                      VizCtrl.to.vizCheck5.value == true)
                    lineChartBarData(VizCtrl.to.vizVal5[4],
                        Get.find<iniController>().Series_Color_005.value),
                  if (VizCtrl.to.vizSeriesList[5] &&
                      VizCtrl.to.vizCheck5.value == true)
                    lineChartBarData(VizCtrl.to.vizVal5[5],
                        Get.find<iniController>().Series_Color_006.value),
                  if (VizCtrl.to.vizSeriesList[6] &&
                      VizCtrl.to.vizCheck5.value == true)
                    lineChartBarData(VizCtrl.to.vizVal5[6],
                        Get.find<iniController>().Series_Color_008.value),
                ],
                bottomTitles: SideTitles(
                  interval: 100,
                  showTitles: true,
                  getTitles: (value) {
                    return '${value.round()}';
                  },
                ),
                leftTitles: SideTitles(
                  showTitles: true, reservedSize: 30, margin: 10,

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
