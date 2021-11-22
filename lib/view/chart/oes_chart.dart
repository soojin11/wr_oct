import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:wr_ui/view/right_side_menu/csv_creator.dart';
import 'package:wr_ui/view/right_side_menu/log_screen.dart';

class OesController extends GetxController {
  RxList<OESData> oneData = RxList.empty();
  RxList<OESData> twoData = RxList.empty();
  RxList<OESData> threeData = RxList.empty();
  RxList<OESData> fourData = RxList.empty();
  RxList<OESData> fiveData = RxList.empty();
  RxList<OESData> sixData = RxList.empty();
  RxList<OESData> sevenData = RxList.empty();
  RxList<OESData> eightData = RxList.empty();
  RxBool inactiveBtn = false.obs;

  late ChartSeriesController oneCtrl,
      twoCtrl,
      threeCtrl,
      fourCtrl,
      fiveCtrl,
      sixCtrl,
      sevenCtrl,
      eightCtrl;
  late ZoomPanBehavior zoomPanBehavior;
  late TrackballBehavior trackballBehavior;
  late Timer timer;
  @override
  void onInit() {
    //wonhee
    // timer;
    // chartSeriesController;

    //wonhee
    oneData;
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

  void updateDataSource(Timer timer) async {
    if (oneData.isNotEmpty) {
      oneData.clear();
      twoData.clear();
      threeData.clear();
      fourData.clear();
      fiveData.clear();
      sixData.clear();
      sevenData.clear();
      eightData.clear();
    }
    for (int i = 190; i < 760; i++){
      oneData.add(OESData(range: i));
      twoData.add(OESData(range: i));
      threeData.add(OESData(range: i));
      fourData.add(OESData(range: i));
      fiveData.add(OESData(range: i));
      sixData.add(OESData(range: i));
      sevenData.add(OESData(range: i));
      eightData.add(OESData(range: i++));
      }
      if (Get.find<CsvController>().fileSave.value)
      await Get.find<CsvController>().csvSave();
    update();
  }
}

class OESData {
  int range;
  int num = math.Random().nextInt(50);
  OESData({required this.range});
}

class OesChart extends GetView<OesController> {
  OesChart({Key? key}) : super(key: key);
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
              SplineSeries(
                animationDuration: 0,
                width: 1,
                name: 'OES_2',
                enableTooltip: true,
                onRendererCreated: (ChartSeriesController ctrl) {
                  controller.twoCtrl = ctrl;
                },
                dataSource: controller.twoData,
                xValueMapper: (OESData spec, _) => spec.range,
                yValueMapper: (OESData spec, _) => spec.num,
              ),
              SplineSeries(
                animationDuration: 0,
                width: 1,
                name: 'OES_3',
                enableTooltip: true,
                onRendererCreated: (ChartSeriesController ctrl) {
                  controller.threeCtrl = ctrl;
                },
                dataSource: controller.threeData,
                xValueMapper: (OESData spec, _) => spec.range,
                yValueMapper: (OESData spec, _) => spec.num,
              ),
              SplineSeries(
                animationDuration: 0,
                width: 1,
                name: 'OES_4',
                enableTooltip: true,
                onRendererCreated: (ChartSeriesController ctrl) {
                  controller.fourCtrl = ctrl;
                },
                dataSource: controller.fourData,
                xValueMapper: (OESData spec, _) => spec.range,
                yValueMapper: (OESData spec, _) => spec.num,
              ),
              SplineSeries(
                animationDuration: 0,
                width: 1,
                name: 'OES_5',
                enableTooltip: true,
                onRendererCreated: (ChartSeriesController ctrl) {
                  controller.fiveCtrl = ctrl;
                },
                dataSource: controller.fiveData,
                xValueMapper: (OESData spec, _) => spec.range,
                yValueMapper: (OESData spec, _) => spec.num,
              ),
              SplineSeries(
                animationDuration: 0,
                width: 1,
                name: 'OES_6',
                enableTooltip: true,
                onRendererCreated: (ChartSeriesController ctrl) {
                  controller.sixCtrl = ctrl;
                },
                dataSource: controller.sixData,
                xValueMapper: (OESData spec, _) => spec.range,
                yValueMapper: (OESData spec, _) => spec.num,
              ),
              SplineSeries(
                animationDuration: 0,
                width: 1,
                name: 'OES_7',
                enableTooltip: true,
                onRendererCreated: (ChartSeriesController ctrl) {
                  controller.sevenCtrl = ctrl;
                },
                dataSource: controller.sevenData,
                xValueMapper: (OESData spec, _) => spec.range,
                yValueMapper: (OESData spec, _) => spec.num,
              ),
              SplineSeries(
                animationDuration: 0,
                width: 1,
                name: 'OES_8',
                enableTooltip: true,
                onRendererCreated: (ChartSeriesController ctrl) {
                  controller.eightCtrl = ctrl;
                },
                dataSource: controller.eightData,
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
