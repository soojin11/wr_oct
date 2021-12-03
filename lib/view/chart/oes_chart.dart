import 'dart:async';
import 'dart:math' as math;
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wr_ui/view/right_side_menu/csv_creator.dart';


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
  @override
  void onInit() {
    super.onInit();
  }

  double setRandom(){
  double yValue = math.Random().nextInt(50).toDouble();
  return yValue;
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
      //await Get.find<CsvController>().SecondcsvSave();
    update();
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
            child: LineChartForm(controller: controller, lineBarsData: [
              if (controller.checkVal1.value)
                lineChartBarData(controller.oneData, Colors.red[400]),
              if (controller.checkVal2.value)
                lineChartBarData(controller.twoData, Colors.orange),
              if (controller.checkVal3.value)
                lineChartBarData(controller.threeData, Colors.amber),
              if (controller.checkVal4.value)
                lineChartBarData(controller.fourData, Colors.green[300]),
              if (controller.checkVal5.value)
                lineChartBarData(controller.fiveData, Colors.blue[300]),
              if (controller.checkVal6.value)
                lineChartBarData(controller.sixData, Colors.blue[700]),
              if (controller.checkVal7.value)
                lineChartBarData(controller.sevenData, Colors.purple[300]),
              if (controller.checkVal8.value)
                lineChartBarData(controller.eightData, Colors.pink[100]),
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
                    case 10:
                      return '10k';
                    case 30:
                      return '30k';
                    case 50:
                      return '50k';
                  }
                  return '';
                },
                reservedSize: 35,
                margin: 12,
              ),),
          ),
        ),
      ),
    );
  }

  LineChart LineChartForm(
      {required OesController controller,
      required List<LineChartBarData> lineBarsData,
      SideTitles? leftTitles, SideTitles? bottomTitles}) {
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

            )
            
          ),
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
        barWidth: 1
        );
  }
}
