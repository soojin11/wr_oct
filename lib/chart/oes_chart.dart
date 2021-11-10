import 'dart:async';
import 'dart:math' as math;

//import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:wr_ui/ui/widgets/drop_down_chart.dart';
//import 'package:wr_ui/ui/widgets/log_screen.dart';

//디바이스개수,주기만 일단

class OesController extends GetxController {
  RxList<OESData> oesData = RxList.empty();

  late ChartSeriesController chartSeriesController;
  late ZoomPanBehavior zoomPanBehavior;
  late Timer timer;
  @override
  void onInit() {
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
    super.onInit();
  }

  @override
  void onClose() {
    timer.cancel();
    super.onClose();
  }

  
  void updateDataSource(Timer timer) async {
    if(oesData.isNotEmpty){
      oesData.clear();
    }
   for(int i=0; i<150; i++)
    oesData.add(OESData(range: i++, num: math.Random().nextInt(50)));
    chartSeriesController.updateDataSource(
        addedDataIndex: oesData.length - 1);
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
    return Row(
      children: [
        TextButton(
            onPressed: () {
              final controller = Get.put(OesController());
              controller.timer = Timer.periodic(
                  Duration(milliseconds: 100), controller.updateDataSource);
                  controller.oesData;
              

            },
            child: Text("Start")),
        TextButton(
            onPressed: () {
              controller.timer.cancel();
            },
            child: Text("Stop")),
        Expanded(
            child: GetBuilder<OesController>(
              builder:(controller) => 
            SfCartesianChart(
              //plotAreaBackgroundColor: Colors.red,
          legend: Legend(
              isVisible: true,
              toggleSeriesVisibility: true,
              position: LegendPosition.top),
          zoomPanBehavior: controller.zoomPanBehavior,
          primaryXAxis: NumericAxis(minimum: 0, maximum: 150),
          primaryYAxis: NumericAxis(minimum: 0, maximum: 60),
          title: ChartTitle(text: 'OES'),
          series: <ChartSeries<OESData, int>>[
            SplineSeries(
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
        ),))
      ],
    );
  }
}

