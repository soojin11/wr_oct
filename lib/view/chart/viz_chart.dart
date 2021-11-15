import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:wr_ui/view/right_side_menu/csv_creator.dart';
import 'package:wr_ui/view/right_side_menu/log_screen.dart';

class VizController extends GetxController {
  RxList<SpecData> chartData = RxList.empty();
  RxList<SpecData> firstData = RxList.empty();

  RxBool inactiveBtn = false.obs;
  RxList<Rx<ChartSetting>> chartSet = RxList.empty();

  //RxBool cStart = false.obs;

  // RxBool boolStart = false.obs;
  //RxList<Rx<SpecData>> chartData = RxList.empty();
  // RxInt time = 0.obs;
  // RxInt num = 0.obs;

  late ChartSeriesController chartSeriesController, firstChartCtrl;
  late ZoomPanBehavior zoomPanBehavior;
  late TrackballBehavior trackballBehavior;
  late Timer timer;
  @override
  void onInit() {
    chartData;
    firstData;
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
    trackballBehavior = TrackballBehavior(
        enable: true,
        activationMode: ActivationMode.singleTap,
        lineType: TrackballLineType.vertical,
        tooltipSettings: const InteractiveTooltip(format: 'point.x : point.y'));

    super.onInit();
  }

  @override
  void onClose() {
    timer.cancel();
    super.onClose();
  }
  

  int time = 0;
  void updateDataSource(Timer timer) async {
    chartData.add(SpecData(time: time, num: setRandomData()));
    chartSeriesController.updateDataSource(
        addedDataIndex: chartData.length - 1);
        firstData.add(SpecData(time: time++, num: setRandomData()));
        firstChartCtrl.updateDataSource(addedDataIndex: firstData.length -1);
    if (Get.find<CsvController>().fileSave.value)
      await Get.find<CsvController>().csvSave();
    
  }
  
   double setRandomData(){
     Get.find<CsvController>().yVal.value = double.parse(math.Random().nextInt(50).toDouble().toStringAsFixed(2));
    return Get.find<CsvController>().yVal.value;
   } 
  

  
}
class SpecData {
  int time;
  double num;
  int tStart = 0;
  int tEnd = 0;
  SpecData({required this.time, required this.num});

  // factory SpecData.init() {
  //   return SpecData(time: 0);
  // }
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
    return Expanded(
        child: SfCartesianChart(
          
          //plotAreaBackgroundColor: Colors.red,
      legend: Legend(
          isVisible: true,
          toggleSeriesVisibility: true,
          position: LegendPosition.top),
      zoomPanBehavior: controller.zoomPanBehavior,
      trackballBehavior: controller.trackballBehavior,
      primaryXAxis:NumericAxis(autoScrollingDelta: 300, isVisible: false),
      primaryYAxis: NumericAxis(minimum: 0, maximum: 60, labelFormat: '{value}k',),
      title: ChartTitle(text: 'VIZ'),
      series: <ChartSeries<SpecData, int>>[
        SplineSeries(
          animationDuration: 0,
          width: 1,
          name: 'VIZ_1',
          enableTooltip: true,
          onRendererCreated: (ChartSeriesController ctrl) {
            controller.chartSeriesController = ctrl;
          },
          dataSource: controller.chartData,
          xValueMapper: (SpecData spec, _) => spec.time,
          yValueMapper: (SpecData spec, _) => spec.num,
        ),
        SplineSeries(
          animationDuration: 0,
          width: 1,
          name: 'VIZ_2',
          enableTooltip: true,
          onRendererCreated: (ChartSeriesController ctrl) {
            controller.firstChartCtrl = ctrl;
          },
          dataSource: controller.firstData,
          xValueMapper: (SpecData spec, _) => spec.time,
          yValueMapper: (SpecData spec, _) => spec.num,
        ),
      ],
    ));
  }
}
