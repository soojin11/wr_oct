import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:wr_ui/view/right_side_menu/log_screen.dart';

class OesController extends GetxController {
  RxList<OESData> oesData = RxList.empty();
  RxBool inactiveBtn = false.obs;

  late ChartSeriesController chartSeriesController;
  late ZoomPanBehavior zoomPanBehavior;
  late TrackballBehavior trackballBehavior;
  late Timer timer;
  @override
  void onInit() {
    //wonhee
    // timer;
    // chartSeriesController;

    //wonhee
    oesData;
    zoomPanBehavior = ZoomPanBehavior(
        enableSelectionZooming: true,
        selectionRectBorderColor: Colors.red,
        selectionRectBorderWidth: 1,
        selectionRectColor: Colors.green,
        enableDoubleTapZooming: true,
        enableMouseWheelZooming: true,
        enablePinching: true,
        enablePanning: true);
    trackballBehavior = TrackballBehavior(
        enable: true,
        activationMode: ActivationMode.singleTap,
        lineType: TrackballLineType.vertical,
        tooltipSettings: const InteractiveTooltip(format: 'point.x : point.y'));
    super.onInit();
  }

  // @override
  // void dispose() {
  //   if (timer != null) {
  //     timer!.cancel();
  //     timer = null;
  //   }
  //   super.dispose();
  // }

  // @override
  // void onClose() {
  //   timer.cancel();
  //   super.onClose();
  // }
  //안돼서 잠깐 주석처리, 위에 dispose삭제하고 이 주석 해제하면 원상복귀됨

  void updateDataSource(Timer timer) async {
    if (oesData.isNotEmpty) {
      oesData.clear();
    }
    for (int i = 0; i < 150; i++)
      oesData.add(OESData(range: i++, num: math.Random().nextInt(50)));
    chartSeriesController.updateDataSource(addedDataIndex: oesData.length - 1);
    update();
  }
}

class OESData {
  int range;
  int num;
  OESData({required this.range, required this.num});
}

class OesChart extends GetView<OesController> {
  OesChart({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OesController());
    return Expanded(
        child: GetBuilder<OesController>(
      builder: (controller) => SfCartesianChart(
        //plotAreaBackgroundColor: Colors.red,
        legend: Legend(
            isVisible: true,
            toggleSeriesVisibility: true,
            position: LegendPosition.top),
        zoomPanBehavior: controller.zoomPanBehavior,
        trackballBehavior: controller.trackballBehavior,
        primaryXAxis:
            NumericAxis(minimum: 0, maximum: 150, labelFormat: '{value}nm'),
        primaryYAxis: NumericAxis(minimum: 0, maximum: 60),
        title: ChartTitle(text: 'OES'),
        series: <ChartSeries<OESData, int>>[
          SplineSeries(
            width: 1,
            color: Colors.green,
            name: 'OES_1',
            enableTooltip: true,
            onRendererCreated: (ChartSeriesController ctrl) {
              controller.chartSeriesController = ctrl;
            },
            dataSource: controller.oesData,
            xValueMapper: (OESData spec, _) => spec.range,
            yValueMapper: (OESData spec, _) => spec.num,
          ),
        ],
      ),
    ));
  }
}
