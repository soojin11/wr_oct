import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:wr_ui/controller/viz_ctrl.dart';
import '../../viz_chart.dart';

class HoverChart extends GetView<VizCtrl> {
  HoverChart({Key? key, required this.chart}) : super(key: key);
  List<LineChartBarData> chart;
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(20),
        child: GetBuilder<VizCtrl>(
            builder: (controller) => Obx(() => VizChart().LineChartForm(
                controller: controller,
                lineBarsData: chart,
                leftTitles: SideTitles(showTitles: false),
                bottomTitles: SideTitles(showTitles: false)))));
  }
}
