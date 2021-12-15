import 'dart:async';
import 'dart:math' as math;
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wr_ui/view/right_side_menu/csv_creator.dart';
import 'package:wr_ui/view/right_side_menu/save_ini.dart';

class OesController extends GetxController {
  RxList<List<FlSpot>> chartData = RxList.empty();

  // RxList<FlSpot> oneData = RxList.empty();
  // RxList<FlSpot> twoData = RxList.empty();
  // RxList<FlSpot> threeData = RxList.empty();
  // RxList<FlSpot> fourData = RxList.empty();
  // RxList<FlSpot> fiveData = RxList.empty();
  // RxList<FlSpot> sixData = RxList.empty();
  // RxList<FlSpot> sevenData = RxList.empty();
  // RxList<FlSpot> eightData = RxList.empty();
  RxBool inactiveBtn = false.obs;

  RxBool checkVal1 = true.obs;
  RxBool checkVal2 = true.obs;
  RxBool checkVal3 = true.obs;
  RxBool checkVal4 = true.obs;
  RxBool checkVal5 = true.obs;
  RxBool checkVal6 = true.obs;
  RxBool checkVal7 = true.obs;
  RxBool checkVal8 = true.obs;
  late Timer timer;
  RxBool bRunning = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  double setRandom() {
    double yValue = math.Random().nextInt(50).toDouble();
    //여기
    return yValue;
  }

  Future<void> updateDataSource(Timer timer) async {
    for (var i = 0; i < Get.find<iniController>().OES_Count.value; i++) {
      if (chartData.isNotEmpty) chartData[i].clear();
    }

    List<double> xValues = [];
    for (double i = 0; i < 2048; i++) {
      xValues.add(i);
    }

    List<List<double>> formatedSpec = [];
    for (var z = 0; z < Get.find<iniController>().OES_Count.value; z++) {
      formatedSpec.add([]);
      for (var i = 0; i < 2048; i++) {
        formatedSpec[z].add(setRandom());
      }
    }

    for (var i = 0; i < Get.find<iniController>().OES_Count.value; i++) {
      for (int x = 0; x < 2048; x++) {
        chartData[i].add(FlSpot(xValues[x], formatedSpec[i][x]));
      }
    }
    if (Get.find<CsvController>().fileSave.value) {
      for (var i = 0; i < Get.find<iniController>().OES_Count.value; i++) {
         Get.find<CsvController>().csvForm(
            path: "_${i + 1}.csv", data: formatedSpec[i]);
      }
    }

    update();
  }
}

class OesChart extends GetView<OesController> {
  OesChart({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20),
      child: GetBuilder<OesController>(
        builder: (controller) => InteractiveViewer(
          child: Container(
            padding: EdgeInsets.only(left: 20, right: 20, top: 10),
            child: LineChartForm(
              controller: controller,
              lineBarsData:
                  //0일때 시뮬레이션 1일 때 찐 데이터
                  [
                lineChartBarData(controller.chartData[0],
                    Get.find<iniController>().Series_Color_001.value),
                lineChartBarData(controller.chartData[1],
                    Get.find<iniController>().Series_Color_002.value),
                lineChartBarData(controller.chartData[2],
                    Get.find<iniController>().Series_Color_003.value),
                lineChartBarData(controller.chartData[3],
                    Get.find<iniController>().Series_Color_004.value),
                lineChartBarData(controller.chartData[4],
                    Get.find<iniController>().Series_Color_005.value),
                lineChartBarData(controller.chartData[5],
                    Get.find<iniController>().Series_Color_006.value),
                lineChartBarData(controller.chartData[6],
                    Get.find<iniController>().Series_Color_007.value),
                lineChartBarData(controller.chartData[7],
                    Get.find<iniController>().Series_Color_008.value),
              ],
              bottomTitles: SideTitles(
                showTitles: true,
                reservedSize: 20, //글씨 밑에 margin 주기
                getTextStyles: (BuildContext, double) => const TextStyle(
                  color: Color(0xff68737d),
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
                getTitles: (value) {
                  return '${value.round()}';
                },
                margin: 8, //스캐일에 쓴 글씨와 그래프의 margin
              ),
              leftTitles: SideTitles(
                showTitles: true,
                getTextStyles: (BuildContext, double) => const TextStyle(
                  color: Color(0xff67727d),
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
                getTitles: (value) {
                  switch (value.toInt()) {
                    case 0:
                      return '10k';
                    case 30:
                      return '30k';
                    case 50:
                      return '50k';
                  }
                  return '';
                },
                reservedSize: 30,
                margin: 12,
              ),
            ),
          ),
        ),
      ),
    );
  }

  LineChart LineChartForm(
      {required OesController controller,
      required List<LineChartBarData> lineBarsData,
      SideTitles? leftTitles,
      SideTitles? bottomTitles}) {
    return LineChart(
      LineChartData(
          minX: 190,
          maxX: 760,
          minY: 0,
          maxY: 50, //데이터를 몇개 넣을 것인지~~
          lineTouchData: LineTouchData(
              touchTooltipData: LineTouchTooltipData(
            fitInsideHorizontally: true,
            fitInsideVertically: true,
          )),
          clipData: FlClipData.all(),
          titlesData: FlTitlesData(
              show: true,
              bottomTitles: bottomTitles,
              leftTitles: leftTitles,
              topTitles: SideTitles(showTitles: false),
              rightTitles: SideTitles(showTitles: false)),
          borderData: FlBorderData(
            show: true,
            border: Border.all(
                color: const Color(0xff37434d), width: 1), //border만들어서 값 넣기
          ),
          lineBarsData: lineBarsData),
      swapAnimationDuration: Duration.zero,
    );
  }

  LineChartBarData lineChartBarData(List<FlSpot> points, color) {
    return LineChartBarData(
        spots: points,
        dotData: FlDotData(
          show: false,
        ),
        colors: [color],
        barWidth: 1);
  }
}