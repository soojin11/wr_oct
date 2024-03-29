import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wr_ui/controller/oes_ctrl.dart';
import 'package:wr_ui/view/right_side_menu/save_ini.dart';

final channelNuminINI = Get.find<iniController>().channelFlow.value;

class OesChart extends GetView<OesController> {
  OesChart({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(top: 20),
        child: GetBuilder<OesController>(
            builder: (controller) => Obx(
                  () => controller.scrollEvent(
                    child: Container(
                      padding: EdgeInsets.only(left: 20, right: 20, top: 10),
                      child: LineChartForm(
                        controller: controller,
                        lineBarsData: oesChartValue(),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            interval: 100,
                            showTitles: true,
                            reservedSize: 50,
                            // margin: 8,
                          ),
                        ),
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            //y값애서
                            // interval: 100,
                            reservedSize: 50,
                            // margin: 10,
                          ),
                        ),
                      ),
                    ),
                  ),
                )));
  }

  LineChart LineChartForm(
      {required OesController controller,
      required List<LineChartBarData> lineBarsData,
      AxisTitles? leftTitles,
      AxisTitles? bottomTitles}) {
    return LineChart(
      LineChartData(
          minX: controller.minX.value,
          maxX: controller.maxX.value,
          lineTouchData: LineTouchData(
            // touchSpotThreshold: 60,

            touchTooltipData: LineTouchTooltipData(
              tooltipBgColor: Colors.black.withOpacity(0.4),
              getTooltipItems: (touchedSpots) {
                return touchedSpots.map((LineBarSpot touchedSpot) {
                  final textStyle = TextStyle(
                    color: touchedSpot.bar.color,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  );

                  return LineTooltipItem(
                      touchedSpot.y.toStringAsFixed(0), textStyle);
                }).toList();
              },
              fitInsideHorizontally: true,
              fitInsideVertically: true,
              showOnTopOfTheChartBoxArea: true,
            ),
          ),
          clipData: FlClipData.all(),
          titlesData: FlTitlesData(
            show: true,
            bottomTitles: bottomTitles,
            leftTitles: leftTitles,
            // topTitles: AxisTitles(showTitles: false),
            // rightTitles: SideTitles(showTitles: false),
          ),
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
        color: color,
        barWidth: 1);
  }

  List<LineChartBarData> oesChartValue() {
    List<LineChartBarData> rt = [];
    rt.add(lineChartBarData([], Colors.black));
    for (var i = 0; i < 8; i++) {
      if (controller.oesData[i].oesToggle.value)
        rt.add(lineChartBarData(
            controller.oesChartData[i], iniController.to.oesColor[i]));
    }
    return rt;
  }
}
