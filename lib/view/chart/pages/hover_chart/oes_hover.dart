import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../oes_chart.dart';



class OesHoverChart extends GetView<OesController> {
  OesHoverChart({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    //final controller = Get.put(OesController());
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        child: GetBuilder<OesController>(
          builder: (controller) => SfCartesianChart(
            //plotAreaBackgroundColor: Colors.red,
            legend: Legend(
              iconHeight: 0,
              iconWidth: 30,
                isVisible: true,
                toggleSeriesVisibility: true,
                position: LegendPosition.top),
            zoomPanBehavior: controller.zoomPanBehavior,
            trackballBehavior: controller.trackballBehavior,
            primaryXAxis:
                NumericAxis(minimum: 190, maximum: 760, labelFormat: '{value}nm'),
            primaryYAxis: NumericAxis(minimum: 0, maximum: 60),
            //title: ChartTitle(text: 'OES'),
            series: <ChartSeries<OESData, int>>[
              SplineSeries(
                animationDuration: 0,
                width: 1,
                name: 'OES_1',
                enableTooltip: true,
                onRendererCreated: (ChartSeriesController ctrl) {
                  controller.oneCtrl = ctrl;
                },
                dataSource: controller.oneData,
                xValueMapper: (OESData spec, _) => spec.range,
                yValueMapper: (OESData spec, _) => spec.num,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
