import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'package:ffi/ffi.dart';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wr_ui/ing/data%20monitor.dart';
import 'package:wr_ui/main.dart';
import 'package:wr_ui/view/appbar/actions/setting/setting_menu_final.dart';
import 'package:wr_ui/view/appbar/leading/run_error_status_mark.dart';
import 'package:wr_ui/view/chart/device_oes_chart.dart';
import 'package:wr_ui/view/chart/oes_chart.dart';
import 'package:wr_ui/view/right_side_menu/ini_creator.dart';

import 'csv_creator.dart';
import 'log_screen.dart';

class StartStopController extends GetxController {
  // update111() {
  //   mpmSetChannel(0);
  //   Pointer<Double> getfmtSpec = calloc<Double>(2048);
  //   getfmtSpec = getformatSpec(0);
  //   List<double> xsTemp1 = [];
  //   for (var i = 0; i < 2048; i++) {
  //     xsTemp1.add(getfmtSpec[i]);
  //     print('xsTemp1?? ${xsTemp1[i]}');
  //   }
  //   double ddd = getfmtSpec[2047];
  //   print('ddd$ddd');
  //   Get.find<OesController>().oneData.clear();
  //   Get.find<OesController>().twoData.clear();
  //   Get.find<OesController>().threeData.clear();
  //   Get.find<OesController>().fourData.clear();
  //   Get.find<OesController>().fiveData.clear();
  //   Get.find<OesController>().sixData.clear();
  //   Get.find<OesController>().sevenData.clear();
  //   Get.find<OesController>().eightData.clear();

  //   List<double> xsTemp2 = [];
  //   Pointer<Double> getwveLength = getWavelength(0);
  //   // for (var i = 0; i < 2048; i++) {
  //   //   xsTemp2.add(getwveLength[i]);
  //   //   print('xsTemp2?? ${xsTemp2[i]}');
  //   // }
  //   //Get.find<OesController>().timer.cancel();
  //   // for (var i = 0; i < 2048; i++) {
  //   //   Get.find<OesController>()
  //   //       .oneData
  //   //       .add(FlSpot(getwveLength[i], getfmtSpec[i]));
  //   //   Get.find<OesController>()
  //   //       .twoData
  //   //       .add(FlSpot(getwveLength[i], getfmtSpec[i]));
  //   //   Get.find<OesController>()
  //   //       .threeData
  //   //       .add(FlSpot(getwveLength[i], getfmtSpec[i]));

  //   //   Get.find<OesController>()
  //   //       .fourData
  //   //       .add(FlSpot(getwveLength[i], getfmtSpec[i]));
  //   //   Get.find<OesController>()
  //   //       .fiveData
  //   //       .add(FlSpot(getwveLength[i], getfmtSpec[i]));
  //   //   Get.find<OesController>()
  //   //       .sixData
  //   //       .add(FlSpot(getwveLength[i], getfmtSpec[i]));
  //   //   Get.find<OesController>()
  //   //       .sevenData
  //   //       .add(FlSpot(getwveLength[i], getfmtSpec[i]));
  //   //   Get.find<OesController>()
  //   //       .eightData
  //   //       .add(FlSpot(getwveLength[i], getfmtSpec[i]));
  //   //   if (getfmtSpec[i] < 1) print('aa?? ${getfmtSpec[i]}');
  //   // }
  //   //calloc.free(aa);
  // }

}

class StartStop extends GetView<StartStopController> {
  const StartStop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(height: 30),
        Obx(
          () => IgnorePointer(
            ignoring: Get.find<OesController>().inactiveBtn.value,
            child: ElevatedButton(
              child: Container(
                width: 200,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text('Start'),
                    Icon(
                      Icons.play_arrow,
                      size: 16,
                    )
                  ],
                ),
              ),
              style: ElevatedButton.styleFrom(
                primary: Get.find<OesController>().inactiveBtn.value
                    ? Colors.grey
                    : Colors.greenAccent[700],
                textStyle: TextStyle(fontSize: 16),
              ),
              onPressed: () async {
                // Get.find<oes>()
                //Get.find<VizController>().inactiveBtn.value = true;
                Get.find<OesController>().bRunning.value = true;
                print('start bRunning?? ' +
                    ' ${Get.find<OesController>().bRunning.value}');
                // Get.find<DataMonitorCtrl>().bRunningFunc();
                Get.find<OesController>().inactiveBtn.value = true;

                // Get.find<OesController>().timer = Timer.periodic(
                //     Duration(milliseconds: 10000), (timer) async {
                //   await compute(getOesData, timer);
                // });
                // Get.find<OesController>().timer = Timer.periodic(
                //     Duration(milliseconds: 1000),
                //     (timer) async => await compute( timerFunc,));
//주현님이 알려준 compute-->클래스밖에 있어야 적용됨
//                 Get.find<OesController>().timer = Timer.periodic(
//                     Duration(milliseconds: 10000),
//                     (timer) async => await compute(func, timer));

//주현님이 알려준 compute-->클래스밖에 있어야 적용됨
                // Get.find<OesController>().timer = Timer.periodic(
                //     Duration(milliseconds: 10000), (timer) async {
                //   print("in timer");
                //   await compute(
                //       Get.find<OesController>().updateDataSource, timer);
                // });
                // Get.find<StartStopController>().update111();
                try {
                  Get.find<OesController>().timer = Timer.periodic(
                      Duration(milliseconds: 5000),
                      //2200정도....?
                      Get.find<OesController>().updateDataSource);
                } on FormatException {
                  print('format error');
                }
                Get.find<OesController>().oneData;
                Get.find<runErrorStatusController>().connect.value = true;
                Get.find<runErrorStatusController>().textmsg.value =
                    'SIMULATION';
                // Get.find<iniControllerWithReactive>()
                //     .measureStartAtProgStart
                //     .value = '0';
                Get.find<LogListController>().clickedStart();
              },
            ),
          ),
        ),
        SizedBox(height: 30),
        Obx(
          () => IgnorePointer(
            ignoring: !Get.find<OesController>().inactiveBtn.value,
            child: ElevatedButton(
              child: Container(
                width: 200,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text('Stop'),
                    Icon(
                      Icons.pause,
                      size: 16,
                    )
                  ],
                ),
              ),
              style: ElevatedButton.styleFrom(
                  primary: Get.find<OesController>().inactiveBtn.value
                      ? Colors.red
                      : Colors.grey,
                  textStyle: TextStyle(fontSize: 16)),
              onPressed: () {
                if (Get.find<OesController>().bRunning.value) {
                  Get.find<OesController>().bRunning.value = false;
                  print('stop bRunning?? ' +
                      ' ${Get.find<OesController>().bRunning.value}');
                  Get.find<OesController>().inactiveBtn.value = false;
                  Get.find<CsvController>().inactiveBtn.value = false;
                  // Get.find<VizController>().inactiveBtn.value = false;
                  // Get.find<VizController>().timer.cancel();

                  Get.find<OesController>().timer.cancel();
                  Get.find<LogListController>().clickedStop();
                  Get.find<CsvController>().fileSave.value = false;
                  Get.find<runErrorStatusController>().connect.value = false;
                  Get.find<runErrorStatusController>().textmsg.value = 'STOP';
                  // Get.find<iniControllerWithReactive>()
                  //     .measureStartAtProgStart
                  //     .value = '';
                  // Get.find<iniControllerWithReactive>().writeIni();
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}
