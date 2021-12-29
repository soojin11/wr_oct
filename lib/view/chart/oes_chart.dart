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
    if (Get.find<iniController>().sim == 1) {
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

    if (Get.find<iniController>().sim == 0) {
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
      print(yMax.value);
    }

    Get.find<LogController>().loglist.add('${logfileTime()} End Draw Chart\n');
    //csv 저장
    if (yMax.value >= Get.find<iniController>().oesMaxValue.value) {
      Get.find<CsvController>().fileSave.value = true;
      autoSave.value = true;
    }

    if (yMax.value < Get.find<iniController>().oesMaxValue.value &&
        autoSave.value) {
      Get.find<CsvController>().fileSave.value = false;
      autoSave.value = false;
    }
    if (Get.find<CsvController>().fileSave.value) {
      Get.find<CsvController>()
          .csvForm(path: "_${nCurrentChannel + 1}.csv", data: fmtSpec);
    }
    Get.find<LogController>().loglist.add('${logfileTime()} End csv save\n');
    if (nChannelIdx > channelNuminINI.length - 1) {
      nChannelIdx = 0;
    }
    var nNextChannel = int.parse(channelNuminINI[nChannelIdx]) - 1;
    print('nNextChannel : $nNextChannel');

    Get.find<LogController>().loglist.add(
        '${logfileTime()} current channel finish ${nCurrentChannel}' + '\n');
    update();
    return;
    // if (Get.find<iniController>().sim.value == 0) {
    //   for (var i = 0; i < Get.find<iniController>().OES_Count.value; i++) {
    //     if (oesData.isNotEmpty) oesData[i].clear();
    //   }

    //   List<double> xValues = [];
    //   for (double i = 0; i < 2048; i++) {
    //     xValues.add(i);
    //   }

    //   List<List<double>> formatedSpec = [];
    //   for (var z = 0; z < Get.find<iniController>().OES_Count.value; z++) {
    //     formatedSpec.add([]);
    //     for (var i = 0; i < 2048; i++) {
    //       formatedSpec[z].add(setRandom());
    //     }
    //   }

    //   for (var i = 0; i < Get.find<iniController>().OES_Count.value; i++) {
    //     for (int x = 0; x < 2048; x++) {
    //       oesData[i].add(FlSpot(xValues[x], formatedSpec[i][x]));
    //     }
    //     // max값 찾기
    //     yMax.value = formatedSpec[i]
    //         .reduce((value, element) => value > element ? value : element);
    //     // print(yMax.value);
    //   }
    //   if (yMax.value >= Get.find<iniController>().oesMaxValue.value) {
    //     Get.find<CsvController>().fileSave.value = true;
    //     autoSave.value = true;
    //     print(autoSave.value);
    //   }

    //   if (yMax.value < Get.find<iniController>().oesMaxValue.value &&
    //       autoSave.value) {
    //     Get.find<CsvController>().fileSave.value = false;
    //     autoSave.value = false;
    //     print(autoSave.value);
    //   }

    //   if (Get.find<CsvController>().fileSave.value) {
    //     for (var i = 0; i < Get.find<iniController>().OES_Count.value; i++) {
    //       Get.find<CsvController>()
    //           .csvForm(path: "_${i + 1}.csv", data: formatedSpec[i]);
    //     }
    //   }

    //   update();
    // }
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

              // Get.find<LogListController>().logData.add('zoom in');
            } else {
              if (maxX.value - maxX * 0.1 <= 2048 && minX - maxX * 0.1 >= 0) {
                minX.value -= maxX * 0.1;
                maxX.value += maxX * 0.1;
              } else {
                minX.value = 0;
                maxX.value = 2048;
              }
            }

            // Get.find<LogListController>().logData.add(
            //     'x ${minX.value.round().toString()}  ${maxX.value.round().toString()}');
          }
        },
        child: GestureDetector(
          onDoubleTap: () {
            minX.value = 0;
            maxX.value = oesData.length.toDouble();
          },
          onHorizontalDragUpdate: (dragUpdate) {
            double primeDelta = dragUpdate.primaryDelta ?? 0.0;
            if (primeDelta != 0) {
              if (primeDelta.isNegative) {
                minX.value += maxX * 0.005;
                maxX.value += maxX * 0.005;
              } else {
                // minX -= maxX * 0.005;
                maxX.value -= maxX * 0.005;
              }
            }
            update();
          },
          child: child,
        ));
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
                          reservedSize: 20, //글씨 밑에 margin 주기
                          // getTextStyles: (BuildContext, double) => const TextStyle(
                          //   color: Color(0xff68737d),
                          //   fontWeight: FontWeight.bold,
                          //   fontSize: 13,
                          // ),
                          // getTitles: (value) {
                          //   return '${value.round()}';
                          // },
                          margin: 8, //스캐일에 쓴 글씨와 그래프의 margin
                        ),
                        leftTitles: SideTitles(
                          showTitles: true,
                          interval: 100,
                          // getTitles: (value) {
                          //   switch (value.toInt()) {
                          //     case 0:
                          //       return '10k';
                          //     case 250:
                          //       return '30k';
                          //     case 500:
                          //       return '50k';
                          //   }
                          //   return '';
                          // },
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
