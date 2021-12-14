import 'dart:async';
import 'dart:ffi';
import 'package:ffi/ffi.dart';
import 'dart:math' as math;
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wr_ui/main.dart';
import 'package:wr_ui/view/appbar/leading/run_error_status_mark.dart';
import 'package:wr_ui/view/right_side_menu/csv_creator.dart';
import 'package:wr_ui/view/right_side_menu/ini_creator.dart';
import 'package:wr_ui/view/right_side_menu/log_save.dart';
import 'package:wr_ui/view/right_side_menu/log_screen.dart';
import 'package:wr_ui/view/right_side_menu/save_ini.dart';
import 'package:wr_ui/view/right_side_menu/start_stop.dart';

final channelNuminINI = Get.find<iniControllerWithReactive>().channelFlow.value;

/////////////밑에 랜덤데이터 있음
class OesController extends GetxController {
  RxList<List<FlSpot>> oesData = RxList.empty();
  // RxList<FlSpot> oneData = RxList.empty();
  // RxList<FlSpot> twoData = RxList.empty();
  // RxList<FlSpot> threeData = RxList.empty();
  // RxList<FlSpot> fourData = RxList.empty();
  // RxList<FlSpot> fiveData = RxList.empty();
  // RxList<FlSpot> sixData = RxList.empty();
  // RxList<FlSpot> sevenData = RxList.empty();
  // RxList<FlSpot> eightData = RxList.empty();
  RxBool inactiveBtn = false.obs;
  RxInt channelMovingTime = 270.obs;
  // RxInt plusTime = 30.obs;
  //여유시간

  RxBool checkVal1 = true.obs;
  RxBool checkVal2 = true.obs;
  RxBool checkVal3 = true.obs;
  RxBool checkVal4 = true.obs;
  RxBool checkVal5 = true.obs;
  RxBool checkVal6 = true.obs;
  RxBool checkVal7 = true.obs;
  RxBool checkVal8 = true.obs;
  RxString updateStart = ''.obs;
  RxString updateend = ''.obs;
  Timer? timer;
  Timer? simTimer;
  //RxBool bRunning = false.obs;
  @override
  void onInit() {
    super.onInit();
  }

  double setRandom() {
    double yValue = 1800 + math.Random().nextInt(500).toDouble();
    return yValue;
  }

  // Future<void> updateSimulation(Timer timer) async {
  //   if (oneData.isNotEmpty) {
  //     oneData.clear();
  //     twoData.clear();
  //     threeData.clear();
  //     fourData.clear();
  //     fiveData.clear();
  //     sixData.clear();
  //     sevenData.clear();
  //     eightData.clear();
  //   }
  //   for (double i = 190; i < 760; i++) {
  //     oneData.add(FlSpot(i, setRandom()));
  //     twoData.add(FlSpot(i, setRandom()));
  //     threeData.add(FlSpot(i, setRandom()));
  //     fourData.add(FlSpot(i, setRandom()));
  //     fiveData.add(FlSpot(i, setRandom()));
  //     sixData.add(FlSpot(i, setRandom()));
  //     sevenData.add(FlSpot(i, setRandom()));
  //     eightData.add(FlSpot(i, setRandom()));
  //   }
  //   if (Get.find<CsvController>().fileSave.value)
  //     await Get.find<CsvController>().csvSave();
  //   if (Get.find<CsvController>().fileSave2.value)
  //     await Get.find<CsvController>().SecondcsvSave();
  //   if (Get.find<CsvController>().fileSave3.value)
  //     await Get.find<CsvController>().ThirdcsvSave();
  //   if (Get.find<CsvController>().fileSave4.value)
  //     await Get.find<CsvController>().FourthcsvSave();
  //   if (Get.find<CsvController>().fileSave5.value)
  //     await Get.find<CsvController>().FifthcsvSave();
  //   if (Get.find<CsvController>().fileSave6.value)
  //     await Get.find<CsvController>().SixthcsvSave();
  //   if (Get.find<CsvController>().fileSave7.value)
  //     await Get.find<CsvController>().SeventhcsvSave();
  //   if (Get.find<CsvController>().fileSave8.value)
  //     await Get.find<CsvController>().EightcsvSave();
  //   update();
  // }

  Future<bool> waitSwitching() async {
    //타임 시작
    var stopwatch = Stopwatch()..start();
    while (mpmIsSwitching() == 1) {
      Future.delayed(
        Duration(milliseconds: 1),
      );
      //1초 초과 체크 , 넘으면 브레이크(나가게), return false
      if (stopwatch.elapsedMilliseconds > 200) {
        // print(' stopwatch1 ');
        return false;
      }
    }
    Future.delayed(Duration(milliseconds: 50)); //스위치타임 보정-ini

    // Get.find<LogListController>().logData.add(
    //     '${logfileTime()} updateStart ${Get.find<OesController>().updateStart.value}');
    // Get.find<LogListController>().logData.add(
    //     '${logfileTime()} swap ${stopwatch.elapsedMilliseconds} $nChannelIdx \n');
    // print('stopwatch  ${stopwatch.elapsedMilliseconds}');
    return true;
  }

  Future<void> updateDataSource(Timer timer) async {
    final channelNuminINI = Get.find<iniControllerWithReactive>()
        .channelFlow
        .value; //ini에 있는 채널 변경 순서

    for (var nChCnt = 0; nChCnt < channelNuminINI.length; nChCnt++) {
      // 채널 바뀔 때마다 데이터 넣음.
      print('nChCnt??  $nChCnt');

      print('${screenTime()}');
      int nChannel = int.parse(channelNuminINI[nChCnt]) - 1;
      mpmSetChannel(nChannel); //채널 바뀌는 함수

      if (await waitSwitching() == true) {
        //채널바뀔 때 기다림
        print('stopwatch success');
      } else {
        print('stopwatch fail');
      }
      List<double> fmtSpec = await readData(0);
      // double dTemp = 0.0;
      if (nChannel == true) {
        for (var i = 0; i < Get.find<iniController>().OES_Count.value; i++) {
          for (var x = 0; x < listWavelength.length; x++) {
            oesData[i].add(FlSpot(listWavelength[x], fmtSpec[x]));
          }
        }
      }
      // switch (nChannel) {
      //   case 0:
      //     oesData[0].clear();

      //     for (var i = 0; i < listWavelength.length; i++) {
      //       dTemp = fmtSpec[i].toDouble();
      //       oesData[0].add(FlSpot(listWavelength[i], fmtSpec[i]));
      //     }

      //     break;
      //   case 1:
      //     oesData[1].clear();
      //     for (var i = 0; i < listWavelength.length; i++) {
      //       dTemp = fmtSpec[i].toDouble();
      //       oesData[1].add(FlSpot(listWavelength[i], fmtSpec[i]));
      //     }

      //     break;
      //   case 2:
      //     oesData[2].clear();
      //     for (var i = 0; i < listWavelength.length; i++) {
      //       dTemp = fmtSpec[i].toDouble();
      //       oesData[2].add(FlSpot(listWavelength[i], fmtSpec[i]));
      //     }

      //     break;
      //   case 3:
      //     oesData[3].clear();
      //     for (var i = 0; i < listWavelength.length; i++) {
      //       dTemp = fmtSpec[i].toDouble();
      //       oesData[3].add(FlSpot(listWavelength[i], fmtSpec[i]));
      //     }

      //     break;
      //   case 4:
      //     oesData[4].clear();
      //     for (var i = 0; i < listWavelength.length; i++) {
      //       dTemp = fmtSpec[i].toDouble();
      //       oesData[4].add(FlSpot(listWavelength[i], fmtSpec[i]));
      //     }

      //     break;
      //   case 5:
      //     oesData[5].clear();
      //     for (var i = 0; i < listWavelength.length; i++) {
      //       dTemp = fmtSpec[i].toDouble();
      //       oesData[5].add(FlSpot(listWavelength[i], fmtSpec[i]));
      //     }

      //     break;

      //   case 6:
      //     oesData[6].clear();
      //     for (var i = 0; i < listWavelength.length; i++) {
      //       dTemp = fmtSpec[i].toDouble();
      //       oesData[6].add(FlSpot(listWavelength[i], fmtSpec[i]));
      //     }

      //     break;
      //   case 7:
      //     oesData[7].clear();
      //     for (var i = 0; i < listWavelength.length; i++) {
      //       dTemp = fmtSpec[i].toDouble();
      //       oesData[7].add(FlSpot(listWavelength[i], fmtSpec[i]));
      //     }

      //     break;
      // }
    }
    update();
  }

  Future<void> updateDataSource2(Timer timer) async {
    var stopwatch = Stopwatch()..start();

    //nChannelIdx;
    //chartData.add(item)
    //nChannelIdx = 0
    var nCurrentChannel = int.parse(channelNuminINI[nChannelIdx++]) - 1;
    print('nCurrentChannel : $nCurrentChannel');
    print('nChannelIdx : $nChannelIdx');
    mpmSetChannel(nCurrentChannel); //채널바꿈

    if (await waitSwitching() == true) {
      //채널바뀔 때 기다림
      //print('stopwatch success');
    } else {
      print('Channel Switching fail');
    }
    List<double> fmtSpec = await readData(0);
    chartData.clear();
    for (var x = 0; x < listWavelength.length; x++) {
      chartData.add(FlSpot(listWavelength[x], fmtSpec[x]));
    }

    //csv 저장하는거 넣어야 함////////
    // switch (nCurrentChannel) {
    //   case 0:
    //     if (Get.find<CsvController>().fileSave.value)
    //       await Get.find<CsvController>().csvSave();
    //     break;
    //   case 1:
    //     if (Get.find<CsvController>().fileSave2.value)
    //       await Get.find<CsvController>().SecondcsvSave();
    //     break;
    //   case 2:
    //     if (Get.find<CsvController>().fileSave3.value)
    //       await Get.find<CsvController>().ThirdcsvSave();
    //     break;
    //   case 3:
    //     if (Get.find<CsvController>().fileSave4.value)
    //       await Get.find<CsvController>().FourthcsvSave();
    //     break;
    //   case 4:
    //     if (Get.find<CsvController>().fileSave5.value)
    //       await Get.find<CsvController>().FifthcsvSave();
    //     break;
    //   case 5:
    //     if (Get.find<CsvController>().fileSave6.value)
    //       await Get.find<CsvController>().SixthcsvSave();
    //     break;
    //   case 6:
    //     if (Get.find<CsvController>().fileSave7.value)
    //       await Get.find<CsvController>().SeventhcsvSave();
    //     break;
    //   case 7:
    //     if (Get.find<CsvController>().fileSave8.value)
    //       await Get.find<CsvController>().EightcsvSave();
    //     break;
    // }

    if (nChannelIdx > channelNuminINI.length - 1) {
      nChannelIdx = 0;
    }
    var nNextChannel = int.parse(channelNuminINI[nChannelIdx]) - 1;
    switch (nNextChannel) {
      case 0:
        chartData = oesData[0];
        break;
      case 1:
        chartData = oesData[1];

        break;
      case 2:
        chartData = oesData[2];

        break;
      case 3:
        chartData = oesData[3];

        break;
      case 4:
        chartData = oesData[4];

        break;
      case 5:
        chartData = oesData[5];

        break;
      case 6:
        chartData = oesData[6];

        break;
      case 7:
        chartData = oesData[7];

        break;
    }
    update();

    // Get.find<LogListController>().logData.add(
    //     '${logfileTime()} 함수시작-끝 ${stopwatch.elapsedMilliseconds} $nCurrentChannel\n');
    // Get.find<LogController>().loglist.add(
    //     '${logfileTime()} 함수시작-끝 ${stopwatch.elapsedMilliseconds} $nCurrentChannel\n');
  }
}

////////////////////
Future<bool> func(Timer arg) async {
  print("in compute");
  return true;
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
              lineBarsData: [
                if (controller.checkVal1.value)
                  lineChartBarData(controller.oesData[0],
                      Get.find<iniController>().Series_Color_001.value),
                if (controller.checkVal2.value)
                  lineChartBarData(controller.oesData[1],
                      Get.find<iniController>().Series_Color_002.value),
                if (controller.checkVal3.value)
                  lineChartBarData(controller.oesData[2],
                      Get.find<iniController>().Series_Color_003.value),
                if (controller.checkVal4.value)
                  lineChartBarData(controller.oesData[3],
                      Get.find<iniController>().Series_Color_004.value),
                if (controller.checkVal5.value)
                  lineChartBarData(controller.oesData[4],
                      Get.find<iniController>().Series_Color_005.value),
                if (controller.checkVal6.value)
                  lineChartBarData(controller.oesData[5],
                      Get.find<iniController>().Series_Color_006.value),
                if (controller.checkVal7.value)
                  lineChartBarData(controller.oesData[6],
                      Get.find<iniController>().Series_Color_007.value),
                if (controller.checkVal8.value)
                  lineChartBarData(controller.oesData[7],
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
                    case 250:
                      return '30k';
                    case 500:
                      return '50k';
                  }
                  return '';
                },
                reservedSize: 10,
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
          minX: 180,

          //listWavelength[0],
          maxX: 800,
          //listWavelength[2047],
          // minY: 1800,
          // maxY: 3000, //데이터를 몇개 넣을 것인지~~
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
