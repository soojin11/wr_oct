import 'dart:async';
import 'dart:math' as math;

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:wr_ui/ui/widgets/drop_down_chart.dart';
import 'package:wr_ui/ui/widgets/log_screen.dart';
import 'package:wr_ui/ui/widgets/save_file.dart';
//디바이스개수,주기만 일단

// class ChartPage extends StatefulWidget {
//   const ChartPage();

//   @override
//   _ChartPageState createState() => _ChartPageState();
// }

// class _ChartPageState extends State<ChartPage> {
//   late Timer _timer;

//   final List<_ChartData> _chartData = <_ChartData>[
//     _ChartData(DateTime.now(), 5),
//   ];

//   @override
//   void initState() {
//     _timer = Timer.periodic(const Duration(seconds: 1), _getChartData);
//     super.initState();
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     _timer.cancel();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         //all oes vi +선택하는 드롭다운
//         Expanded(child: CahrtDropDown()),
//         //all oes vi +선택하는 드롭다운
//         SfCartesianChart(
//           enableAxisAnimation: true,
//           primaryXAxis:
//               DateTimeAxis(intervalType: DateTimeIntervalType.seconds),
//           series: <LineSeries<_ChartData, DateTime>>[
//             LineSeries(
//               color: Colors.blue,
//               dataSource: _chartData,
//               xValueMapper: (_ChartData sales, _) => sales.x,
//               yValueMapper: (_ChartData sales, _) => sales.y,
//             )
//           ],
//         ),
//       ],
//     );
//   }

//   void _getChartData(Timer timer) {
//     _ChartData date = _chartData[_chartData.length - 1];
//     _chartData.add(_ChartData(
//         DateTime(date.x.year, date.x.month, date.x.day, date.x.hour,
//             date.x.minute, date.x.second + 1),
//         _getRandomInt(10, 30)));
//     setState(() {});
//   }

//   int _getRandomInt(int min, int max) {
//     final Random random = Random();
//     return min + random.nextInt(max - min);
//   }
// }

// class _ChartData {
//   _ChartData(this.x, this.y);
//   final DateTime x;
//   final int y;
// }

//GetX 사용
class ChartController extends GetxController {
  RxList<SpecData> chartData = RxList.empty();
  //RxList<Rx<Range>> forSaving = RxList.empty();
  late ChartSeriesController chartSeriesController;
  late ZoomPanBehavior zoomPanBehavior;
  late Timer timer;

  @override
  void onInit() {
    chartData;
    //timer = Timer.periodic(Duration(milliseconds: 1000), updateDataSource);
    zoomPanBehavior = ZoomPanBehavior(
        enableSelectionZooming: true,
        //selectionRectBorderColor: Colors.red,
        selectionRectBorderWidth: 1,
        //selectionRectColor: Colors.green,
        enableDoubleTapZooming: true,
        enableMouseWheelZooming: true,
        enablePinching: true,
        enablePanning: true);
    super.onInit();
  }

  // @override
  // void onClose() {
  //   timer.cancel();
  //   super.onClose();
  // }

  int time = 0;
  void updateDataSource(Timer timer) async {
    chartData.add(SpecData(time: time++));
    chartSeriesController.updateDataSource(
        addedDataIndex: chartData.length - 1);
        if(Get.find<CsvController>().fileSave.value)
        await Get.find<CsvController>().csvSave();
  }
}
// class Range{
//   Range({required this.cStart, required this.cEnd, required this.tableX, required this.rv,required this.value});
//   int cStart;
//   int cEnd;
//   List<int> tableX;
//   RangeValues rv;
//   double value;


//   factory Range.init(){
//     return Range(cEnd: 0, cStart: 0, tableX: [], rv: RangeValues(0, 0), value: 0.0);
//   }
// }

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
