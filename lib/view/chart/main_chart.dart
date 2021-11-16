import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

//GetX 사용
class ChartController extends GetxController {
  RxList<SpecData> chartData = RxList.empty();
  RxBool igButton = false.obs;
  late ChartSeriesController chartSeriesController;
  late ZoomPanBehavior zoomPanBehavior;
  late Timer timer;

  @override
  void onInit() {
    chartData;
    //timer = Timer.periodic(Duration(milliseconds: 1000), updateDataSource);
    zoomPanBehavior = ZoomPanBehavior(
        enableSelectionZooming: true,
        selectionRectBorderColor: Colors.red,
        selectionRectBorderWidth: 1,
        selectionRectColor: Colors.green,
        enableDoubleTapZooming: true,
        enableMouseWheelZooming: true,
        enablePinching: true,
        enablePanning: true);
    super.onInit();
  }

  @override
  void onClose() {
    timer.cancel();
    super.onClose();
  }

  int time = 0;
  void updateDataSource(Timer timer) async {
    chartData.add(SpecData(time: time++));
    chartSeriesController.updateDataSource(
        addedDataIndex: chartData.length - 1);
  }
}

class SpecData {
  final int time;
  final int num = math.Random().nextInt(50);
  SpecData({required this.time});
  factory SpecData.init() {
    return SpecData(time: 0);
  }
}

class MainChart extends GetView<ChartController> {
  MainChart({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      legend: Legend(
          isVisible: true,
          toggleSeriesVisibility: true,
          position: LegendPosition.top),
      zoomPanBehavior: controller.zoomPanBehavior,
      enableAxisAnimation: true,
      primaryXAxis: NumericAxis(autoScrollingMode: AutoScrollingMode.start),
      //primaryYAxis: NumericAxis(minimum: 0, maximum: 60),
      title: ChartTitle(text: 'Main'),
      series: <ChartSeries<SpecData, int>>[
        SplineSeries(
          name: 'OES1',
          enableTooltip: true,
          onRendererCreated: (ChartSeriesController ctrl) {
            controller.chartSeriesController = ctrl;
          },
          dataSource: controller.chartData,
          xValueMapper: (SpecData spec, _) => spec.time,
          yValueMapper: (SpecData spec, _) => spec.num,
        ),
      ],
    );
  }
}
