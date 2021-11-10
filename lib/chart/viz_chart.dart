import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:wr_ui/ui/widgets/log_save.dart';
import 'package:wr_ui/ui/widgets/log_screen.dart';
import 'package:wr_ui/ui/widgets/save_file.dart';

class VizController extends GetxController {
  RxList<SpecData> chartData = RxList.empty(); //이 안에 time, num 넣으려면 어떻게 해야하는지?
  RxList<Rx<ChartSetting>> chartSet = RxList.empty();
  //RxBool cStart = false.obs;

  // RxBool boolStart = false.obs;
  //RxList<Rx<SpecData>> chartData = RxList.empty();
  // RxInt time = 0.obs;
  // RxInt num = 0.obs;

  late ChartSeriesController chartSeriesController;
  late ZoomPanBehavior zoomPanBehavior;
  late Timer timer;
  @override
  void onInit() {
    chartData;
    //timer = Timer.periodic(Duration(milliseconds: 10), updateDataSource);
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
    //for (var i = 0; i < chartData.length; i++) {
    //chartData.add(SpecData(time: i++, num: math.Random().nextInt(50)));
    //chartData.add(Rx<SpecData>(SpecData(time: time++)));
    chartData.add(SpecData(time: time++));
    chartSeriesController.updateDataSource(
        addedDataIndex: chartData.length - 1);
    //}
  }
}

class SpecData {
  int time;
  int num = math.Random().nextInt(50);
  int tStart = 0;
  int tEnd = 0;
  SpecData({required this.time});

  factory SpecData.init() {
    return SpecData(time: 0);
  }
}

class ChartSetting {
  ChartSetting(
      {required this.tStart, required this.tEnd, required this.tableVal});
  int tStart;
  int tEnd;
  List<int> tableVal;

  factory ChartSetting.init() {
    return ChartSetting(tEnd: 0, tStart: 0, tableVal: []);
  }
}

class VizChart extends GetView<VizController> {
  VizChart({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // TextButton(
        //     onPressed: () {
        //       controller.timer = Timer.periodic(
        //           Duration(milliseconds: 100), controller.updateDataSource);
        //       Get.find<LogListController>().clickedStart();
        //       // Get.find<LogListController>().toLogFile.value =
        //       //     'Start button is clicked';
        //       // Get.find<ChartController>().boolStart.value = true;
        //       Get.find<LogController>()
        //           .loglist
        //           .add('${DateTime.now()} Start button is pressed' + '\n');
        //       Get.find<LogController>().logSaveInit();
        //       Get.find<LogController>().fileSave.value = true;

        //     },
        //     child: Text("Start")),
        // TextButton(
        //     onPressed: () {
        //       controller.timer.cancel();
        //       Get.find<LogListController>().clickedStop();
        //       // Get.find<LogListController>().toLogFile.value =
        //       //     'Stop button is clicked';
        //       Get.find<LogController>()
        //           .loglist
        //           .add('${DateTime.now()} Stop button is pressed' + '\n');
        //       Get.find<LogController>().logSaveInit();
        //       Get.find<LogController>().fileSave.value = true;
        //     },
        //     child: Text("Stop")),
        Expanded(
            child: SfCartesianChart(
              //plotAreaBackgroundColor: Colors.red,
          legend: Legend(
              isVisible: true,
              toggleSeriesVisibility: true,
              position: LegendPosition.top),
          zoomPanBehavior: controller.zoomPanBehavior,
          primaryXAxis: NumericAxis(autoScrollingMode: AutoScrollingMode.start),
          primaryYAxis: NumericAxis(minimum: 0, maximum: 60),
          title: ChartTitle(text: 'VIZ'),
          series: <ChartSeries<SpecData, int>>[
            SplineSeries(
              name: 'VIZ_1',
              enableTooltip: true,
              onRendererCreated: (ChartSeriesController ctrl) {
                controller.chartSeriesController = ctrl;
              },
              dataSource: controller.chartData,
              xValueMapper: (SpecData spec, _) => spec.time,
              yValueMapper: (SpecData spec, _) => spec.num,
            ),
          ],
        ))
      ],
    );
  }
}
