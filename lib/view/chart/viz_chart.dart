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
                lineBarsData: vizChartValue(),
                bottomTitles: SideTitles(
                  interval: 100,
                  reservedSize: 50,
                  margin: 8,
                  showTitles: true,
                  getTitles: (value) {
                    String rt;
                    rt =
                        '${((value / 1000) * iniController.to.viz_Interval.value).round()}s';
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
          clipData: FlClipData.all(),
          lineTouchData: LineTouchData(
            enabled: false,
          ),
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

  List<LineChartBarData> vizChartValue() {
    List<LineChartBarData> rt = [];

    rt.add(lineChartBarData([], Colors.black));

    for (var i = 0; i < 5; i++) {
      for (var ii = 0; ii < 7; ii++) {
        if (VizCtrl.to.vizSeries[ii].toggle.value &&
            VizCtrl.to.vizChannel[i].toggle.value) {
          rt.add(lineChartBarData(
              VizCtrl.to.vizPoints[i][ii], iniController.to.vizColor[ii]));
        }
      }
    }
    return rt;
  }
}
