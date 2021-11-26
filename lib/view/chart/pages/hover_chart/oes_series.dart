import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../oes_chart.dart';

class oneHoverChart extends GetView<OesController> {
  @override
  Widget build(BuildContext context) {
    return OesChartHover(
        name: 'OES_1',
        dataSource: controller.oneData,
        onRendererCreated: (ChartSeriesController ctrl) {
          controller.oneCtrl = ctrl;
        });
  }
}
class twoHoverChart extends GetView<OesController>{
@override
  Widget build(BuildContext context) {
    return OesChartHover(
        name: 'OES_2',
        dataSource: controller.twoData,
        onRendererCreated: (ChartSeriesController ctrl) {
          controller.twoCtrl = ctrl;
        });
  }
}

class threeHoverChart extends GetView<OesController>{
@override
  Widget build(BuildContext context) {
    return OesChartHover(
        name: 'OES_3',
        dataSource: controller.threeData,
        onRendererCreated: (ChartSeriesController ctrl) {
          controller.threeCtrl = ctrl;
        });
  }
}

class fourHoverChart extends GetView<OesController>{
@override
  Widget build(BuildContext context) {
    return OesChartHover(
        name: 'OES_4',
        dataSource: controller.fourData,
        onRendererCreated: (ChartSeriesController ctrl) {
          controller.fourCtrl = ctrl;
        });
  }
}
class fiveHoverChart extends GetView<OesController>{
@override
  Widget build(BuildContext context) {
    return OesChartHover(
        name: 'OES_5',
        dataSource: controller.fiveData,
        onRendererCreated: (ChartSeriesController ctrl) {
          controller.fiveCtrl = ctrl;
        });
  }
}
class sixHoverChart extends GetView<OesController>{
@override
  Widget build(BuildContext context) {
    return OesChartHover(
        name: 'OES_6',
        dataSource: controller.sixData,
        onRendererCreated: (ChartSeriesController ctrl) {
          controller.sixCtrl = ctrl;
        });
  }
}
class sevenHoverChart extends GetView<OesController>{
@override
  Widget build(BuildContext context) {
    return OesChartHover(
        name: 'OES_7',
        dataSource: controller.sevenData,
        onRendererCreated: (ChartSeriesController ctrl) {
          controller.sevenCtrl = ctrl;
        });
  }
}
class eightHoverChart extends GetView<OesController>{
@override
  Widget build(BuildContext context) {
    return OesChartHover(
        name: 'OES_8',
        dataSource: controller.eightData,
        onRendererCreated: (ChartSeriesController ctrl) {
          controller.eightCtrl = ctrl;
        });
  }
}

OesChartHover({
  required String name,
  required SeriesRendererCreatedCallback onRendererCreated,
  required List<OESData> dataSource,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: Container(
      child: GetBuilder<OesController>(
        builder: (controller) => SfCartesianChart(
          legend: Legend(
              iconHeight: 0,
              iconWidth: 30,
              isVisible: true,
              toggleSeriesVisibility: true,
              position: LegendPosition.top),
          primaryXAxis:
              NumericAxis(minimum: 190, maximum: 760, labelFormat: '{value}nm'),
          primaryYAxis: NumericAxis(minimum: 0, maximum: 60),
          series: <ChartSeries<OESData, int>>[
            SplineSeries(
              animationDuration: 0,
              width: 1,
              name: name,
              enableTooltip: true,
              onRendererCreated: onRendererCreated,
              dataSource: dataSource,
              xValueMapper: (OESData spec, _) => spec.range,
              yValueMapper: (OESData spec, _) => spec.num,
            ),
          ],
        ),
      ),
    ),
  );
}
