

import 'dart:async';
import 'dart:math' as math;
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wr_ui/view/right_side_menu/csv_creator.dart';
import 'package:wr_ui/view/right_side_menu/save_ini.dart';




class OesController extends GetxController {
  RxList<FlSpot> oneData = RxList.empty();
  RxList<FlSpot> twoData = RxList.empty();
  RxList<FlSpot> threeData = RxList.empty();
  RxList<FlSpot> fourData = RxList.empty();
  RxList<FlSpot> fiveData = RxList.empty();
  RxList<FlSpot> sixData = RxList.empty();
  RxList<FlSpot> sevenData = RxList.empty();
  RxList<FlSpot> eightData = RxList.empty();
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
    for (double i = 190; i < 760; i++) {
      oneData.add(FlSpot(i, setRandom()));
      twoData.add(FlSpot(i, setRandom()));
      threeData.add(FlSpot(i, setRandom()));
      fourData.add(FlSpot(i, setRandom()));
      fiveData.add(FlSpot(i, setRandom()));
      sixData.add(FlSpot(i, setRandom()));
      sevenData.add(FlSpot(i, setRandom()));
      eightData.add(FlSpot(i, setRandom()));
    }
    if (Get.find<CsvController>().fileSave.value)
      await Get.find<CsvController>().csvSave();
    if (Get.find<CsvController>().fileSave2.value)
      await Get.find<CsvController>().SecondcsvSave();
    if (Get.find<CsvController>().fileSave3.value)
      await Get.find<CsvController>().ThirdcsvSave();
    if (Get.find<CsvController>().fileSave4.value)
      await Get.find<CsvController>().FourthcsvSave();
    if (Get.find<CsvController>().fileSave5.value)
      await Get.find<CsvController>().FifthcsvSave();
    if (Get.find<CsvController>().fileSave6.value)
      await Get.find<CsvController>().SixthcsvSave();
    if (Get.find<CsvController>().fileSave7.value)
      await Get.find<CsvController>().SeventhcsvSave();
    if (Get.find<CsvController>().fileSave8.value)
      await Get.find<CsvController>().EightcsvSave();
    update();
  }

  List<FlSpot> doubleFunction(int value){
  for(var i =190; i< value; i++){
  oneData.add(FlSpot(i.toDouble() ,setRandom()));
  twoData.add(FlSpot(i.toDouble(), setRandom()));
  threeData.add(FlSpot(i.toDouble(), setRandom()));
  fourData.add(FlSpot(i.toDouble(), setRandom()));
  fiveData.add(FlSpot(i.toDouble(), setRandom()));
  sixData.add(FlSpot(i.toDouble(), setRandom()));
  sevenData.add(FlSpot(i.toDouble(), setRandom()));
  eightData.add(FlSpot(i.toDouble(), setRandom()));
  }
  return doubleFunction(760);
}

Future<List<FlSpot>> createDoubleFunction() async{
  int value = 760;
  List<FlSpot> val = await compute(doubleFunction, value);
  return val;
}
}






class OesChart extends GetView<OesController> {
  OesChart({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    //final controller = Get.put(OesController());
    return Container(
      padding: EdgeInsets.only(top: 20),
      child: GetBuilder<OesController>(
        builder: (controller) => InteractiveViewer(
          child: Container(
            padding: EdgeInsets.only(left: 20, right: 20, top: 10),
            child: LineChartForm(
              controller: controller,
              lineBarsData: [
                if (controller.checkVal1.value)
                  lineChartBarData(
                      controller.oneData,
                      Get.find<iniController>()
                          .Series_Color_001
                          .value),
                if (controller.checkVal2.value)
                  lineChartBarData(
                      controller.twoData,
                      Get.find<iniController>()
                          .Series_Color_002
                          .value),
                if (controller.checkVal3.value)
                  lineChartBarData(
                      controller.threeData,
                      Get.find<iniController>()
                          .Series_Color_003
                          .value),
                if (controller.checkVal4.value)
                  lineChartBarData(
                      controller.fourData,
                      Get.find<iniController>()
                          .Series_Color_004
                          .value),
                if (controller.checkVal5.value)
                  lineChartBarData(
                      controller.fiveData,
                      Get.find<iniController>()
                          .Series_Color_005
                          .value),
                if (controller.checkVal6.value)
                  lineChartBarData(
                      controller.sixData,
                      Get.find<iniController>()
                          .Series_Color_006
                          .value),
                if (controller.checkVal7.value)
                  lineChartBarData(
                      controller.sevenData,
                      Get.find<iniController>()
                          .Series_Color_007
                          .value),
                if (controller.checkVal8.value)
                  lineChartBarData(
                      controller.eightData,
                      Get.find<iniController>()
                          .Series_Color_008
                          .value),
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