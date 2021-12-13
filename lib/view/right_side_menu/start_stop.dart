import 'dart:async';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wr_ui/main.dart';
import 'package:wr_ui/view/appbar/leading/run_error_status_mark.dart';
import 'package:wr_ui/view/chart/oes_chart.dart';
import 'package:wr_ui/view/right_side_menu/log_save.dart';
import 'package:wr_ui/view/right_side_menu/save_ini.dart';

import 'csv_creator.dart';
import 'log_screen.dart';

int nChannelIdx = 0;
RxList<FlSpot> chartData = RxList.empty();

class StartStopController extends GetxController {}

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
                DataStartBtn();
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
                  mpmSetChannel(0);
                  Get.find<OesController>().inactiveBtn.value = false;
                  Get.find<CsvController>().inactiveBtn.value = false;
                  if (Get.find<iniController>().sim.value == 1) {
                    Get.find<OesController>().timer?.cancel();
                  } else if (Get.find<iniController>().sim.value == 0) {
                    Get.find<OesController>().simTimer?.cancel();
                  }
                  Get.find<LogListController>().clickedStop();
                  Get.find<CsvController>().fileSave.value = false;
                  Get.find<runErrorStatusController>().connect.value = false;
                  Get.find<runErrorStatusController>().textmsg.value =
                      'S T O P';
                  // Get.find<iniControllerWithReactive>()
                  //     .measureStartAtProgStart
                  //     .value = '';
                  // Get.find<iniControllerWithReactive>().writeIni();
                }),
          ),
        ),
      ],
    );
  }
}

DataStartBtn() {
  if (Get.find<iniController>().sim.value == 1) {
    Get.find<runErrorStatusController>().statusColor.value = Color(0xFF2CA732);
    print('bRunning호출');
    Get.find<OesController>().inactiveBtn.value = true;
    try {
      int time1 = Get.find<iniController>().channelMovingTime.value.toInt();
      double doubletime2 =
          Get.find<iniController>().integrationTime.value / 1000;
      int inttime2 = doubletime2.toInt();
      double doubletime3 = Get.find<iniController>().plusTime.value / 1000;
      ;
      int inttime3 = doubletime3.toInt();

      int allTime = time1 + inttime2 + inttime3;
      print('time1?? $time1');
      print('time2?? $inttime3');
      print('time3?? $inttime3');
      print('allTime??? $allTime');
      nChannelIdx = 0;
      chartData = Get.find<OesController>().oneData;
      Get.find<OesController>().timer = Timer.periodic(
          Duration(milliseconds: allTime),
          Get.find<OesController>().updateDataSource2);
      Get.find<LogListController>()
          .logData
          .add('${logfileTime()} channle moving t $time1');
      Get.find<LogController>()
          .loglist
          .add('${logfileTime()} channle moving t $time1');
      Get.find<LogListController>()
          .logData
          .add('${logfileTime()} all t $allTime');
      Get.find<LogController>().loglist.add('${logfileTime()} all t $allTime');
    } on FormatException {
      print('format error');
    }
    Get.find<OesController>().oneData;
    Get.find<runErrorStatusController>().connect.value = true;
    Get.find<runErrorStatusController>().textmsg.value = 'R U N';
    Get.find<LogListController>().clickedStart();
  } else if (Get.find<iniController>().sim.value == 0) {
    SimStartBtn();
  }
}

SimStartBtn() {
  Get.find<runErrorStatusController>().connect.value = true;
  Get.find<OesController>().inactiveBtn.value = true;
  try {
    Get.find<OesController>().simTimer = Timer.periodic(
        Duration(milliseconds: 500),
        Get.find<OesController>().updateSimulation);
  } on FormatException {
    print('format error');
  }
  Get.find<runErrorStatusController>().textmsg.value = 'S I M U L A T I O N';
  Get.find<LogListController>().clickedStart();
  Get.find<runErrorStatusController>().statusColor.value = Color(0xFFE9DF50);
}

// SimStartBtn() {
//   Get.find<OesController>().inactiveBtn.value = true;
//   try {
//     Get.find<OesController>().timer = Timer.periodic(
//         Duration(
//             milliseconds:
//                 int.parse(Get.find<iniController>().exposureTime.value)),
//         Get.find<OesController>().updateDataSource);
//   } on FormatException {
//     print('format error');
//   }
//   Get.find<OesController>().oneData;
//   Get.find<runErrorStatusController>().connect.value = true;
//   Get.find<runErrorStatusController>().textmsg.value = 'SIMULATION';
//   Get.find<LogListController>().clickedStart();
// }
