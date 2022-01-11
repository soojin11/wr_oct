import 'package:fl_chart/fl_chart.dart';
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
                  if (VizCtrl.to.vizSeries[0].toggle.value &&
                      VizCtrl.to.vizChannel[0].toggle.value)
                    lineChartBarData(VizCtrl.to.vizPoints[0][0],
                        Get.find<iniController>().vizColor[0]),
                  if (VizCtrl.to.vizSeries[1].toggle.value &&
                      VizCtrl.to.vizChannel[0].toggle.value)
                    lineChartBarData(VizCtrl.to.vizPoints[0][1],
                        Get.find<iniController>().vizColor[1]),
                  if (VizCtrl.to.vizSeries[2].toggle.value &&
                      VizCtrl.to.vizChannel[0].toggle.value)
                    lineChartBarData(VizCtrl.to.vizPoints[0][2],
                        Get.find<iniController>().vizColor[2]),
                  if (VizCtrl.to.vizSeries[3].toggle.value &&
                      VizCtrl.to.vizChannel[0].toggle.value)
                    lineChartBarData(VizCtrl.to.vizPoints[0][3],
                        Get.find<iniController>().vizColor[3]),
                  if (VizCtrl.to.vizSeries[4].toggle.value &&
                      VizCtrl.to.vizChannel[0].toggle.value)
                    lineChartBarData(VizCtrl.to.vizPoints[0][4],
                        Get.find<iniController>().vizColor[4]),
                  if (VizCtrl.to.vizSeries[5].toggle.value &&
                      VizCtrl.to.vizChannel[0].toggle.value)
                    lineChartBarData(VizCtrl.to.vizPoints[0][5],
                        Get.find<iniController>().vizColor[5]),
                  if (VizCtrl.to.vizSeries[6].toggle.value &&
                      VizCtrl.to.vizChannel[0].toggle.value)
                    lineChartBarData(VizCtrl.to.vizPoints[0][6],
                        Get.find<iniController>().vizColor[6]),
                  if (VizCtrl.to.vizSeries[0].toggle.value &&
                      VizCtrl.to.vizChannel[1].toggle.value)
                    lineChartBarData(VizCtrl.to.vizPoints[1][0],
                        Get.find<iniController>().vizColor[0]),
                  if (VizCtrl.to.vizSeries[1].toggle.value &&
                      VizCtrl.to.vizChannel[1].toggle.value)
                    lineChartBarData(VizCtrl.to.vizPoints[1][1],
                        Get.find<iniController>().vizColor[1]),
                  if (VizCtrl.to.vizSeries[2].toggle.value &&
                      VizCtrl.to.vizChannel[1].toggle.value)
                    lineChartBarData(VizCtrl.to.vizPoints[1][2],
                        Get.find<iniController>().vizColor[2]),
                  if (VizCtrl.to.vizSeries[3].toggle.value &&
                      VizCtrl.to.vizChannel[1].toggle.value)
                    lineChartBarData(VizCtrl.to.vizPoints[1][3],
                        Get.find<iniController>().vizColor[3]),
                  if (VizCtrl.to.vizSeries[4].toggle.value &&
                      VizCtrl.to.vizChannel[1].toggle.value)
                    lineChartBarData(VizCtrl.to.vizPoints[1][4],
                        Get.find<iniController>().vizColor[4]),
                  if (VizCtrl.to.vizSeries[5].toggle.value &&
                      VizCtrl.to.vizChannel[1].toggle.value)
                    lineChartBarData(VizCtrl.to.vizPoints[1][5],
                        Get.find<iniController>().vizColor[5]),
                  if (VizCtrl.to.vizSeries[6].toggle.value &&
                      VizCtrl.to.vizChannel[1].toggle.value)
                    lineChartBarData(VizCtrl.to.vizPoints[1][6],
                        Get.find<iniController>().vizColor[6]),
                  //
                  if (VizCtrl.to.vizSeries[0].toggle.value &&
                      VizCtrl.to.vizChannel[2].toggle.value)
                    lineChartBarData(VizCtrl.to.vizPoints[2][0],
                        Get.find<iniController>().vizColor[0]),
                  if (VizCtrl.to.vizSeries[1].toggle.value &&
                      VizCtrl.to.vizChannel[2].toggle.value)
                    lineChartBarData(VizCtrl.to.vizPoints[2][1],
                        Get.find<iniController>().vizColor[1]),
                  if (VizCtrl.to.vizSeries[2].toggle.value &&
                      VizCtrl.to.vizChannel[2].toggle.value)
                    lineChartBarData(VizCtrl.to.vizPoints[2][2],
                        Get.find<iniController>().vizColor[2]),
                  if (VizCtrl.to.vizSeries[3].toggle.value &&
                      VizCtrl.to.vizChannel[2].toggle.value)
                    lineChartBarData(VizCtrl.to.vizPoints[2][3],
                        Get.find<iniController>().vizColor[3]),
                  if (VizCtrl.to.vizSeries[4].toggle.value &&
                      VizCtrl.to.vizChannel[2].toggle.value)
                    lineChartBarData(VizCtrl.to.vizPoints[2][4],
                        Get.find<iniController>().vizColor[4]),
                  if (VizCtrl.to.vizSeries[5].toggle.value &&
                      VizCtrl.to.vizChannel[2].toggle.value)
                    lineChartBarData(VizCtrl.to.vizPoints[2][5],
                        Get.find<iniController>().vizColor[5]),
                  if (VizCtrl.to.vizSeries[6].toggle.value &&
                      VizCtrl.to.vizChannel[2].toggle.value)
                    lineChartBarData(VizCtrl.to.vizPoints[2][6],
                        Get.find<iniController>().vizColor[6]),
                  //
                  if (VizCtrl.to.vizSeries[0].toggle.value &&
                      VizCtrl.to.vizChannel[3].toggle.value)
                    lineChartBarData(VizCtrl.to.vizPoints[3][0],
                        Get.find<iniController>().vizColor[0]),
                  if (VizCtrl.to.vizSeries[1].toggle.value &&
                      VizCtrl.to.vizChannel[3].toggle.value)
                    lineChartBarData(VizCtrl.to.vizPoints[3][1],
                        Get.find<iniController>().vizColor[1]),
                  if (VizCtrl.to.vizSeries[2].toggle.value &&
                      VizCtrl.to.vizChannel[3].toggle.value)
                    lineChartBarData(VizCtrl.to.vizPoints[3][2],
                        Get.find<iniController>().vizColor[2]),
                  if (VizCtrl.to.vizSeries[3].toggle.value &&
                      VizCtrl.to.vizChannel[3].toggle.value)
                    lineChartBarData(VizCtrl.to.vizPoints[3][3],
                        Get.find<iniController>().vizColor[3]),
                  if (VizCtrl.to.vizSeries[4].toggle.value &&
                      VizCtrl.to.vizChannel[3].toggle.value)
                    lineChartBarData(VizCtrl.to.vizPoints[3][4],
                        Get.find<iniController>().vizColor[4]),
                  if (VizCtrl.to.vizSeries[5].toggle.value &&
                      VizCtrl.to.vizChannel[3].toggle.value)
                    lineChartBarData(VizCtrl.to.vizPoints[3][5],
                        Get.find<iniController>().vizColor[5]),
                  if (VizCtrl.to.vizSeries[6].toggle.value &&
                      VizCtrl.to.vizChannel[3].toggle.value)
                    lineChartBarData(VizCtrl.to.vizPoints[3][6],
                        Get.find<iniController>().vizColor[6]),
                  //
                  if (VizCtrl.to.vizSeries[0].toggle.value &&
                      VizCtrl.to.vizChannel[4].toggle.value)
                    lineChartBarData(VizCtrl.to.vizPoints[4][0],
                        Get.find<iniController>().vizColor[0]),
                  if (VizCtrl.to.vizSeries[1].toggle.value &&
                      VizCtrl.to.vizChannel[4].toggle.value)
                    lineChartBarData(VizCtrl.to.vizPoints[4][1],
                        Get.find<iniController>().vizColor[1]),
                  if (VizCtrl.to.vizSeries[2].toggle.value &&
                      VizCtrl.to.vizChannel[4].toggle.value)
                    lineChartBarData(VizCtrl.to.vizPoints[4][2],
                        Get.find<iniController>().vizColor[2]),
                  if (VizCtrl.to.vizSeries[3].toggle.value &&
                      VizCtrl.to.vizChannel[4].toggle.value)
                    lineChartBarData(VizCtrl.to.vizPoints[4][3],
                        Get.find<iniController>().vizColor[3]),
                  if (VizCtrl.to.vizSeries[4].toggle.value &&
                      VizCtrl.to.vizChannel[4].toggle.value)
                    lineChartBarData(VizCtrl.to.vizPoints[4][4],
                        Get.find<iniController>().vizColor[4]),
                  if (VizCtrl.to.vizSeries[5].toggle.value &&
                      VizCtrl.to.vizChannel[4].toggle.value)
                    lineChartBarData(VizCtrl.to.vizPoints[4][5],
                        Get.find<iniController>().vizColor[5]),
                  if (VizCtrl.to.vizSeries[6].toggle.value &&
                      VizCtrl.to.vizChannel[4].toggle.value)
                    lineChartBarData(VizCtrl.to.vizPoints[4][6],
                        Get.find<iniController>().vizColor[6]),
                ],
                bottomTitles: SideTitles(
                  interval: 100,
                  reservedSize: 50,
                  margin: 8,
                  showTitles: true,
                  getTitles: (value) {
                    String rt;

                    rt =
                        '${(value.round() / 1000) * iniController.to.viz_Interval.value}s';
                    return rt;
                  },
                ),
                leftTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 40,
                  margin: 10,
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
              enabled: false,
              touchTooltipData: LineTouchTooltipData(
                  fitInsideHorizontally: true,
                  fitInsideVertically: true,
                  getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
                    List<LineTooltipItem?> aa = [];
                    for (var i = 0; i < touchedBarSpots.length; i++) {
                      final textstyle = TextStyle(
                        color: touchedBarSpots[i].bar.colors[0],
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      );
                      String str = '';
                      String y;
                      if (touchedBarSpots[i].barIndex == 0)
                        y = ('Freq : ${(touchedBarSpots[i].y * 1000000).toStringAsFixed(3)}');
                      else if (touchedBarSpots[i].barIndex == 1)
                        y = ('P dlv : ${(touchedBarSpots[i].y / 2).toStringAsFixed(3)}');
                      else if (touchedBarSpots[i].barIndex == 2)
                        y = ('Vrms : ${(touchedBarSpots[i].y / 10).toStringAsFixed(3)}');
                      else if (touchedBarSpots[i].barIndex == 3)
                        y = ('Irms : ${(touchedBarSpots[i].y / 10).toStringAsFixed(3)}');
                      else if (touchedBarSpots[i].barIndex == 4)
                        y = ('R : ${(touchedBarSpots[i].y / 10).toStringAsFixed(3)}');
                      else if (touchedBarSpots[i].barIndex == 5)
                        y = ('X : ${(touchedBarSpots[i].y / 10).toStringAsFixed(3)}');
                      else
                        y = ('Phase : ${(touchedBarSpots[i].y * 360 / 1000).toStringAsFixed(3)}');
                      str = y;
                      aa.add(LineTooltipItem(str, textstyle));
                    }
                    return aa;
                  })),
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
