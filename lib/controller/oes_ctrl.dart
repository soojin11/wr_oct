import 'dart:async';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wr_ui/model/oes/oes_data.dart';
import 'package:wr_ui/view/chart/oes_chart.dart';
import 'package:wr_ui/view/right_side_menu/csv_creator.dart';
import 'package:wr_ui/view/right_side_menu/log_save.dart';
import 'package:wr_ui/view/right_side_menu/log_screen.dart';
import 'package:wr_ui/view/right_side_menu/save_ini.dart';
import 'package:wr_ui/view/right_side_menu/start_stop.dart';

import '../main.dart';

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
  RxBool showAll = false.obs;
  RxString portSelect = '0'.obs;

  Future<void> init() async {
    oesData.clear();
    for (var i = 0; i < 8; i++) {
      oesData.add(OesData(
          oesToggle: true.obs,
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
    // if (Get.find<iniController>().sim == 0) {
    if (iniController.to.oes_comport.value != 0 &&
        iniController.to.oes_comport.value != -1) {
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
    // if (Get.find<iniController>().sim == 1) {
    // if (iniController.to.oesSim.value == true) {
    if (iniController.to.oes_comport.value == -1) {
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
    if (iniController.to.oes_comport.value == 0) {
      for (var i = 0; i < 2048; i++) {
        listWavelength;
      }
    }

    List<double> fmtSpec = await readData(ArgReadData(
        spectrometerIndex: 0, sim: iniController.to.oes_comport.value));

    Get.find<LogController>().loglist.add('${logfileTime()} End readData\n');
    oesChartData[nCurrentChannel].clear();

    ///////////////////////////////////////
    // if (startBtn == false) return;
    for (var x = 0; x < listWavelength.length; x++) {
      oesChartData[nCurrentChannel]
          .add(FlSpot(listWavelength[x], fmtSpec[x].roundToDouble()));
      // max값 찾기
      yMax.value =
          fmtSpec.reduce((value, element) => value > element ? value : element);
      // print(yMax.value);
    }

    Get.find<LogController>().loglist.add('${logfileTime()} End Draw Chart\n');
    //csv 저장

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
          // CsvController.to.vizSaveInit();
          Get.find<CsvController>().csvSaveData.value = true;
          break;
        }
        if (saveNum.length - 1 == i) {
          //autoSave.value = false;
          Get.find<CsvController>().csvSaveData.value = false;
          Get.find<CsvController>().csvSaveInit.value = false;
        }
      }

      if ((autoSaveBuffer.value == false) &&
          (Get.find<CsvController>().csvSaveData.value == true)) {
        DateTime current = DateTime.now();
        DateTime dt = DateTime.utc(current.year, current.month, current.day,
            current.hour, current.minute, current.second, current.millisecond);
        CsvController.to.fixedTime.value = dt;
        CsvController.to.saveFileName.value =
            DateFormat('yyyyMMdd-HHmmss').format(current);
        CsvController.to.startTime.value =
            DateFormat('HH:mm:ss.SSS').format(dt);
        for (var i = 0; i < Get.find<iniController>().OES_Count.value; i++) {
          await Get.find<CsvController>().csvFormInit(
              path: "_${i + 1}.csv", channelNum: 'channelNum : ${i + 1}');
        }
        CsvController.to.vizSaveInit();
        Get.find<CsvController>().csvSaveInit.value = true;
      }
    }

    if (Get.find<CsvController>().csvSaveData.value) {
      for (var i = 0; i < Get.find<iniController>().OES_Count.value; i++) {
        Get.find<CsvController>()
            .csvForm(path: "_${nCurrentChannel + 1}.csv", data: fmtSpec);
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
    if (startBtn == false) return;
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

                // debugPrint('확대minxxxxxxxxxx : $minX max: $maxX');
                // debugPrint('확대 min : $minY max: $yMax');
              }
            } else {
              if (maxX.value + 100 > minX.value &&
                  minX > 0 &&
                  maxX <= listWavelength.length) {
                minX.value -= 50;
                maxX.value += 50;

                // debugPrint('축소 minxxxxxxxx : $minX max: $maxX');
                // debugPrint('축소 min : $minY max: $yMax');
              }
            }
          }
        },
        child: child);
  }
}
