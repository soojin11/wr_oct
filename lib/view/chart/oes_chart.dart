import 'dart:async';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wr_ui/main.dart';
import 'package:wr_ui/model/oes/oes_data.dart';
import 'package:wr_ui/view/right_side_menu/csv_creator.dart';
import 'package:wr_ui/view/right_side_menu/log_save.dart';
import 'package:wr_ui/view/right_side_menu/log_screen.dart';
import 'package:wr_ui/view/right_side_menu/save_ini.dart';
import 'package:wr_ui/view/right_side_menu/start_stop.dart';

final channelNuminINI = Get.find<iniController>().channelFlow.value;

class OesController extends GetxController {
  static OesController get to => Get.find();
  RxList<List<FlSpot>> oesChartData = RxList.empty();
  RxBool inactiveBtn = false.obs;
  RxInt channelMovingTime = 270.obs;
  RxList<OesData> oesData = RxList.empty();
  RxList<bool> saveNum = //AutoSave.autoSave
      [false, false, false, false, false, false, false, false].obs;
  RxString updateStart = ''.obs;
  RxString updateend = ''.obs;
  Timer? timer;
  //zoom  controller
  RxDouble minX = 0.0.obs;
  RxDouble maxX = 0.0.obs;
  RxDouble minY = 0.0.obs;
  RxDouble maxY = 0.0.obs;
  RxDouble yValue = 0.0.obs;
  RxDouble yMax = 0.0.obs;
  RxBool autoSaveBuffer = false.obs;
  RxBool startBtn = true.obs;

  Future<void> init() async {
    oesData.clear();
    for (var i = 0; i < 8; i++) {
      oesData.add(OesData(
          oesToggle: true.obs,
          xVal: [],
          yVal: [],
          oesColor: Color(0xFFEF5350),
          fileName: '',
          autoSave: AutoSave(autoSave: true, AutoSaveValue: 0)));
    }
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
    if (Get.find<iniController>().sim == 1) {
      for (var i = 0; i < 8; i++) {
        if (listWavelength.isNotEmpty) {
          listWavelength.clear();
        }
      }
      for (var i = 0; i < 2048; i++) {
        listWavelength.add(i.toDouble());
        Get.find<OesController>().maxX.value = listWavelength.length.toDouble();
      }
    }

    List<double> fmtSpec = await readData(ArgReadData(
        spectrometerIndex: 0, sim: Get.find<iniController>().sim.value));

    Get.find<LogController>().loglist.add('${logfileTime()} End readData\n');
    oesChartData[nCurrentChannel].clear();

    ///////////////////////////////////////
    if (startBtn == false) return;
    for (var x = 0; x < listWavelength.length; x++) {
      oesChartData[nCurrentChannel].add(FlSpot(listWavelength[x], fmtSpec[x]));
      // max값 찾기
      yMax.value =
          fmtSpec.reduce((value, element) => value > element ? value : element);
      // print(yMax.value);
    }

    Get.find<LogController>().loglist.add('${logfileTime()} End Draw Chart\n');
    //csv 저장

    // if (iniController.to.autoSave == 1)

    if (iniController.to.checkAuto.value) {
      if (yMax.value >= Get.find<iniController>().oesAutoSaveVal.value) {
        saveNum[nCurrentChannel] = true;
      } else
        saveNum[nCurrentChannel] = false;
      for (var i = 0; i < saveNum.length; i++) {
        if (startBtn == false) {
          Get.find<CsvController>().csvSaveData.value = false;
          break;
        }
        if (saveNum[i] == true) {
          //autoSave.value = true;
          Get.find<CsvController>().csvSaveData.value = true;
          break;
        }
        if (saveNum.length - 1 == i) {
          //autoSave.value = false;
          Get.find<CsvController>().csvSaveData.value = false;
        }
      }

      if ((autoSaveBuffer.value == false) &&
          (Get.find<CsvController>().csvSaveData.value == true)) {
        DateTime current = DateTime.now();
        Get.find<CsvController>().saveFileName.value =
            DateFormat('yyyyMMdd-HHmmss').format(current);
        String ms = DateTime.now().millisecondsSinceEpoch.toString();
        int msLength = ms.length;
        int third = int.parse(ms.substring(msLength - 3, msLength));
        Get.find<CsvController>().startTime.value =
            '${DateFormat('HH:mm:ss').format(current)}.$third';
        for (var i = 0; i < Get.find<iniController>().OES_Count.value; i++) {
          await Get.find<CsvController>().csvFormInit(
              path: "_${i + 1}.csv", channelNum: 'channelNum : ${i + 1}');
          print("1번 왜 안돼 $i");
        }
      }
    }

    if (Get.find<CsvController>().csvSaveData.value) {
      for (var i = 0; i < Get.find<iniController>().OES_Count.value; i++) {
        Get.find<CsvController>()
            .csvForm(path: "_${nCurrentChannel + 1}.csv", data: fmtSpec);
        print("왜 안될까 $i");
      }
    }

    autoSaveBuffer.value = Get.find<CsvController>().csvSaveData.value;

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
            //확대
            if (signal.scrollDelta.dy.isNegative) {
              if (maxX.value - 100 > minX.value &&
                  yMax.value - 100 > minY.value) {
                minX.value += 50;
                maxX.value -= 50;

                print('확대minxxxxxxxxxx : $minX max: $maxX');
                print('확대 min : $minY max: $yMax');
              }
            } else {
              if (maxX.value + 100 > minX.value &&
                  yMax.value + 100 > minY.value &&
                  minY > 0 &&
                  minX > 0 &&
                  maxX <= listWavelength.length) {
                minX.value -= 50;
                maxX.value += 50;
                minY.value -= 50;
                yMax.value += 50;
                print('축소 minxxxxxxxx : $minX max: $maxX');
                print('축소 min : $minY max: $yMax');
              }
            }
          }
        },
        child: child);
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
                          // if (controller.checkVal1.value)
                          if (controller.oesData[0].oesToggle.value)
                            lineChartBarData(
                                controller.oesChartData[0],
                                Get.find<iniController>()
                                    .Series_Color_001
                                    .value),
                          // if (controller.checkVal2.value)
                          if (controller.oesData[1].oesToggle.value)
                            lineChartBarData(
                                controller.oesChartData[1],
                                Get.find<iniController>()
                                    .Series_Color_002
                                    .value),
                          // if (controller.checkVal3.value)
                          if (controller.oesData[2].oesToggle.value)
                            lineChartBarData(
                                controller.oesChartData[2],
                                Get.find<iniController>()
                                    .Series_Color_003
                                    .value),
                          // if (controller.checkVal4.value)
                          if (controller.oesData[3].oesToggle.value)
                            lineChartBarData(
                                controller.oesChartData[3],
                                Get.find<iniController>()
                                    .Series_Color_004
                                    .value),
                          // if (controller.checkVal5.value)
                          if (controller.oesData[4].oesToggle.value)
                            lineChartBarData(
                                controller.oesChartData[4],
                                Get.find<iniController>()
                                    .Series_Color_005
                                    .value),
                          // if (controller.checkVal6.value)
                          if (controller.oesData[5].oesToggle.value)
                            lineChartBarData(
                                controller.oesChartData[5],
                                Get.find<iniController>()
                                    .Series_Color_006
                                    .value),
                          // if (controller.checkVal7.value)
                          if (controller.oesData[6].oesToggle.value)
                            lineChartBarData(
                                controller.oesChartData[6],
                                Get.find<iniController>()
                                    .Series_Color_007
                                    .value),
                          // if (controller.checkVal8.value)
                          if (controller.oesData[7].oesToggle.value)
                            lineChartBarData(
                                controller.oesChartData[7],
                                Get.find<iniController>()
                                    .Series_Color_008
                                    .value),
                        ],
                        bottomTitles: SideTitles(
                          interval: 100,
                          showTitles: true,
                          reservedSize: 50,
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
