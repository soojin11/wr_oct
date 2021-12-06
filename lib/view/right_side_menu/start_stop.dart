import 'dart:async';
import 'dart:ffi';
import 'package:ffi/ffi.dart';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wr_ui/ing/data%20monitor.dart';
import 'package:wr_ui/main.dart';
import 'package:wr_ui/view/appbar/actions/setting/setting_menu_final.dart';
import 'package:wr_ui/view/appbar/leading/run_error_status_mark.dart';
import 'package:wr_ui/view/chart/oes_chart.dart';
import 'package:wr_ui/view/right_side_menu/ini_creator.dart';

import 'csv_creator.dart';
import 'log_screen.dart';

class StartStopController extends GetxController {
  update111() {
    mpmSetChannel(0);
    Pointer<Double> ggggggggg = calloc<Double>(2048);
    ggggggggg = getformatSpec(0);
    List<double> xsTemp = [];
    for (var i = 0; i < 2048; i++) {
      xsTemp.add(ggggggggg[i]);
      print('ddddddddddd?? ${xsTemp[i]}');
    }
    double ddd = ggggggggg[2047];
    print('ddd$ddd');
    Get.find<OesController>().oneData.clear();
    List<double> xsTemp2 = [];
    Pointer<Double> bb = getWavelength(0);
    for (var i = 0; i < 2048; i++) {
      xsTemp2.add(bb[i]);
      print('ddddddddddd?? ${xsTemp2[i]}');
    }
    //Get.find<OesController>().timer.cancel();
    for (var i = 0; i < 2048; i++) {
      Get.find<OesController>()
          .oneData
          .add(FlSpot(bb[i], ggggggggg[i].toDouble()));
      // print('bb?? ${bb[i]}');
      if (ggggggggg[i] < 1) print('aa?? ${ggggggggg[i]}');
    }
    //calloc.free(aa);
  }
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
                //Get.find<VizController>().inactiveBtn.value = true;
                Get.find<OesController>().bRunning.value = true;
                print('start bRunning?? ' +
                    ' ${Get.find<OesController>().bRunning.value}');
                // Get.find<DataMonitorCtrl>().bRunningFunc();
                Get.find<OesController>().inactiveBtn.value = true;
                // Get.find<OesController>().timer = Timer.periodic(
                //     Duration(milliseconds: 100),
                //     Get.find<OesController>().updateDataSource
                //     );
                // Get.find<StartStopController>().update111();

                try {
                  Get.find<OesController>().timer = Timer.periodic(
                      Duration(
                          milliseconds: int.parse(Get.find<SettingController>()
                              .exposureTime
                              .value)),
                      // Get.find<OesController>().updateDataSource
                      Get.find<StartStopController>().update111());
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
              },
            ),
          ),
        ),
      ],
    );
  }
}
