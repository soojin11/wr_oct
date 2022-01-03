import 'dart:async';
import 'dart:math' as math;
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wr_ui/main.dart';
import 'package:wr_ui/view/right_side_menu/csv_creator.dart';
import 'package:wr_ui/view/right_side_menu/log_save.dart';
import 'package:wr_ui/view/right_side_menu/log_screen.dart';
import 'package:wr_ui/view/right_side_menu/save_ini.dart';
import 'package:wr_ui/view/right_side_menu/start_stop.dart';

final channelNuminINI = Get.find<iniController>().channelFlow.value;

class OesController extends GetxController {
  RxList<List<FlSpot>> oesData = RxList.empty();
  RxBool inactiveBtn = false.obs;
  //microsecond
  RxInt channelMovingTime = 270.obs;

  // RxInt plusTime = 30.obs;
  //여유시간
  RxDouble addYvalue = 0.0.obs;
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
  //RxBool bRunning = false.obs;
  //zoom  controller
  late RxDouble minX;
  late RxDouble maxX;
  RxDouble yValue = 0.0.obs;
  RxDouble yMax = 0.0.obs;
  RxBool autoSave = false.obs;

  @override
  void onInit() {
    minX = 0.0.obs;
    maxX = 2048.0.obs;
    super.onInit();
  }

  double setRandom() {
    yValue.value =
        1800 + math.Random().nextInt(100).toDouble() + addYvalue.value;
    return yValue.value;
  }

  Future<bool> waitSwitching() async {
    var isSwitchingCorectionTime =
        Get.find<iniController>().waitSwitchingTime.value;
    await Future.delayed(
      Duration(milliseconds: isSwitchingCorectionTime),
    );
    return true;
  }

  Future<void> updateDataSource(Timer timer) async {
    //var stopwatch = Stopwatch()..start();
    var nCurrentChannel = int.parse(channelNuminINI[nChannelIdx++]) - 1;
    saveLog();
    Get.find<LogController>().loglist.add(
        '${logfileTime()} current channel start ${nCurrentChannel}' + '\n');
    print('nCurrentChannel : $nCurrentChannel');
    print('nChannelIdx : $nChannelIdx');
    Get.find<LogController>()
        .loglist
        .add('${logfileTime()} Start SetChannel\n');
    if (Get.find<iniController>().sim == 0) {
      mpmSetChannel(nCurrentChannel);
    }

    Get.find<LogController>().loglist.add('${logfileTime()} End SetChannel\n');

    if (await waitSwitching() == true) {
    } else {
      print('Channel Switching fail');
    }
    Get.find<LogController>()
        .loglist
        .add('${logfileTime()} End waitSwitching\n');
    //21.12.29추가
    for (var i = 0; i < 8; i++) {
      if (listWavelength.isNotEmpty) {
        listWavelength.clear();
      }
    }

    if (Get.find<iniController>().sim == 1) {
      for (var i = 0; i < 2048; i++) {
        listWavelength.add(i.toDouble());
      }
    }
    List<double> fmtSpec = await readData(0);

    Get.find<LogController>().loglist.add('${logfileTime()} End readData\n');
    oesData[nCurrentChannel].clear();
    for (var x = 0; x < listWavelength.length; x++) {
      oesData[nCurrentChannel].add(FlSpot(listWavelength[x], fmtSpec[x]));
      // max값 찾기
      yMax.value =
          fmtSpec.reduce((value, element) => value > element ? value : element);
      // print(yMax.value);
    }

    Get.find<LogController>().loglist.add('${logfileTime()} End Draw Chart\n');
    //csv 저장
    if (Get.find<CsvController>().csvSaveData.value) {
      for (var i = 0; i < Get.find<iniController>().OES_Count.value; i++) {
        Get.find<CsvController>().csvSaveInit.value = false;
        Get.find<CsvController>()
            .csvForm(path: "_${nCurrentChannel + 1}.csv", data: fmtSpec);
      }
    }
    if (yMax.value >= Get.find<iniController>().oesAutoSave.value) {
      Get.find<CsvController>().csvSaveInit.value = true;
      autoSave.value = true;
    }

    if (Get.find<CsvController>().csvSaveInit.value) {
      for (var i = 0; i < Get.find<iniController>().OES_Count.value; i++) {
        Get.find<CsvController>().csvFormInit(
            path: "_${i + 1}.csv", channelNum: 'channelNum : ${i + 1}');
      }
      Get.find<CsvController>().csvSaveData.value = true;
    }

    if (yMax.value < Get.find<iniController>().oesAutoSave.value &&
        autoSave.value) {
      Get.find<CsvController>().csvSaveInit.value = false;
      Get.find<CsvController>().csvSaveData.value = false;
      // Get.find<CsvController>().fileSave.value = false;
      autoSave.value = false;
    }
    // if (Get.find<CsvController>().csvSaveData.value) {
    //   Get.find<CsvController>().csvSaveInit.value = false;
    //   for (var i = 0; i < Get.find<iniController>().OES_Count.value; i++) {
    //     Get.find<CsvController>()
    //         .csvForm(path: "_${nCurrentChannel + 1}.csv", data: fmtSpec);
    //   }
    // }
    Get.find<LogController>().loglist.add('${logfileTime()} End csv save\n');
    if (nChannelIdx > channelNuminINI.length - 1) {
      nChannelIdx = 0;
    }
    var nNextChannel = int.parse(channelNuminINI[nChannelIdx]) - 1;
    print('nNextChannel : $nNextChannel');

    Get.find<LogController>().loglist.add(
        '${logfileTime()} current channel finish ${nCurrentChannel}' + '\n');
    update();
  }

  scrollEvent({required Widget child}) {
    return Listener(
        onPointerSignal: (signal) {
          if (signal is PointerScrollEvent) {
            if (signal.scrollDelta.dy.isNegative) {
              if (maxX.value > minX.value + 50) {
                minX.value += 50;
                maxX.value -= 50;
              } else {
                minX.value = minX.value;
                maxX.value = maxX.value;
              }
            } else {
              if (maxX.value - maxX * 0.1 <= 2048 && minX - maxX * 0.1 >= 0) {
                minX.value -= maxX * 0.1;
                maxX.value += maxX * 0.1;
              } else {
                minX.value = 0;
                maxX.value = 2048;
              }
            }
          }
        },
        child: child
        // child: GestureDetector(
        //   onDoubleTap: () {
        //     minX.value = 0;
        //     maxX.value = oesData.length.toDouble();
        //   },
        //   onHorizontalDragUpdate: (dragUpdate) {
        //     double primeDelta = dragUpdate.primaryDelta ?? 0.0;
        //     if (primeDelta != 0) {
        //       if (primeDelta.isNegative) {
        //         minX.value += maxX * 0.005;
        //         maxX.value += maxX * 0.005;
        //       } else {
        //         // minX -= maxX * 0.005;
        //         maxX.value -= maxX * 0.005;
        //       }
        //     }
        //     update();
        //   },
        //   child: child,
        // )
        );
  }
}

class OesChart extends GetView<OesController> {
  OesChart({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(top: 20),
        child: GetBuilder<OesController>(
            builder: (controller) => Obx(
                  () => controller.scrollEvent(
                    child: Container(
                      padding: EdgeInsets.only(left: 20, right: 20, top: 10),
                      child: LineChartForm(
                        controller: controller,
                        lineBarsData: [
                          if (controller.checkVal1.value)
                            lineChartBarData(
                                controller.oesData[0],
                                Get.find<iniController>()
                                    .Series_Color_001
                                    .value),
                          if (controller.checkVal2.value)
                            lineChartBarData(
                                controller.oesData[1],
                                Get.find<iniController>()
                                    .Series_Color_002
                                    .value),
                          if (controller.checkVal3.value)
                            lineChartBarData(
                                controller.oesData[2],
                                Get.find<iniController>()
                                    .Series_Color_003
                                    .value),
                          if (controller.checkVal4.value)
                            lineChartBarData(
                                controller.oesData[3],
                                Get.find<iniController>()
                                    .Series_Color_004
                                    .value),
                          if (controller.checkVal5.value)
                            lineChartBarData(
                                controller.oesData[4],
                                Get.find<iniController>()
                                    .Series_Color_005
                                    .value),
                          if (controller.checkVal6.value)
                            lineChartBarData(
                                controller.oesData[5],
                                Get.find<iniController>()
                                    .Series_Color_006
                                    .value),
                          if (controller.checkVal7.value)
                            lineChartBarData(
                                controller.oesData[6],
                                Get.find<iniController>()
                                    .Series_Color_007
                                    .value),
                          if (controller.checkVal8.value)
                            lineChartBarData(
                                controller.oesData[7],
                                Get.find<iniController>()
                                    .Series_Color_008
                                    .value),
                        ],
                        bottomTitles: SideTitles(
                          interval: 100,
                          showTitles: true,
                          reservedSize: 20,
                          margin: 8,
                        ),
                        leftTitles: SideTitles(
                          showTitles: true,
                          interval: 100,
                          reservedSize: 30,
                          margin: 10,
                        ),
                      ),
                    ),
                  ),
                )));
  }

  LineChart LineChartForm(
      {required OesController controller,
      required List<LineChartBarData> lineBarsData,
      SideTitles? leftTitles,
      SideTitles? bottomTitles}) {
    return LineChart(
      LineChartData(
          minX: controller.minX.value,
          maxX: controller.maxX.value,
          minY: 1800,
          maxY: 2200,
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
            border: Border.all(color: const Color(0xff37434d), width: 1),
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
