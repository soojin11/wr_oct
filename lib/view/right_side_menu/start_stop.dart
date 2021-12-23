import 'dart:async';
import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wr_ui/main.dart';
import 'package:wr_ui/view/appbar/leading/run_error_status_mark.dart';
import 'package:wr_ui/view/chart/oes_chart.dart';
import 'package:wr_ui/view/chart/viz_ctrl.dart';
import 'package:wr_ui/view/right_side_menu/log_save.dart';
import 'package:wr_ui/view/right_side_menu/save_ini.dart';

import 'csv_creator.dart';
import 'log_screen.dart';

int nChannelIdx = 0;
// int nChannelIdx = -1;//range error 나서 초기값 바꿈

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
                  Get.find<runErrorStatusController>().statusColor.value =
                      Colors.red;
                  Get.find<OesController>().inactiveBtn.value = false;
                  Get.find<CsvController>().inactiveBtn.value = false;
                  Get.find<OesController>().timer?.cancel();
                  if (Get.find<iniController>().sim.value == 1) {
                    mpmSetChannel(0);
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
        Row(
          children: [
            ElevatedButton(
              child: Text('open'),
              onPressed: () {
                VizCtrl.to.startSerial();
                // VizCtrl.to.readSerial;
              },
            ),
            ElevatedButton(
              child: Text('close'),
              onPressed: () {
                VizCtrl.to.vizChannel[0].port.close();
                print('열렸나? ${VizCtrl.to.vizChannel[0].port.isOpen}');
              },
            ),
          ],
        ),
        Row(
          children: [
            ElevatedButton(
              child: Text('시작'),
              onPressed: () async {
                await VizCtrl.to.sendStart(); //측정 시작
                VizCtrl.to.buffer.clear();
                VizCtrl.to.vizTimer = Timer.periodic(
                    Duration(milliseconds: 100), VizCtrl.to.readSerial);
                // VizCtrl.to.readSerial();
              },
            ),
            ElevatedButton(
              child: Text('멈춤'),
              onPressed: () async {
                VizCtrl.to.vizTimer?.cancel();
              },
            )
          ],
        )
      ],
    );
  }
}

DataStartBtn() {
  DateTime current = DateTime.now();

  Get.find<CsvController>().saveFileName.value =
      DateFormat('yyyyMMdd-HHmmss').format(current);
  Get.find<runErrorStatusController>().connect.value = true;
  Get.find<LogListController>().clickedStart();
  Get.find<OesController>().inactiveBtn.value = true;
  if (Get.find<iniController>().sim.value == 1) {
    Get.find<runErrorStatusController>().statusColor.value = Color(0xFF2CA732);
    try {
      int time1 = Get.find<iniController>().channelMovingTime.value.toInt();
      double doubletime2 =
          Get.find<iniController>().integrationTime.value / 1000;
      int inttime2 = doubletime2.toInt();
      int time3 = Get.find<iniController>().plusTime.value;
      time3 = 150;
      int allTime =
          inttime2 + Get.find<iniController>().waitSwitchingTime.value + time3;
      if (doubletime2 <= Get.find<iniController>().waitSwitchingTime.value) {
        allTime = inttime2 +
            Get.find<iniController>().waitSwitchingTime.value +
            time3;
      } else
        allTime = (inttime2 * 2) + time3;
      print('time1?? $time1');
      print('time2?? $inttime2');
      print('time3?? $time3');
      print('allTime??? $allTime');
      Get.find<LogListController>().logData.add(
          'all/wait time : $allTime ${Get.find<iniController>().waitSwitchingTime.value}');

      setIntegrationTime(0, Get.find<iniController>().integrationTime.value);
      nChannelIdx = 0;
      Get.find<OesController>().timer = Timer.periodic(
        Duration(milliseconds: allTime),
        Get.find<OesController>().updateDataSource2,
      );
      Get.find<LogListController>().logData.add(
            'channle moving t $time1',
          );
      Get.find<LogController>()
          .loglist
          .add('${logfileTime()} channle moving t $time1');
      Get.find<LogListController>().logData.add(
            'all time $allTime',
          );
      Get.find<LogController>().loglist.add('${logfileTime()} all t $allTime');
    } on FormatException {
      print('format error');
    }
    Get.find<OesController>().oesData[0];

    Get.find<runErrorStatusController>().textmsg.value = 'R U N';
  } else if (Get.find<iniController>().sim.value == 0) {
    SimStartBtn();
  }
}

SimStartBtn() {
  Get.find<OesController>().timer = Timer.periodic(
    Duration(milliseconds: 100),
    Get.find<OesController>().updateDataSource2,
  );
  Get.find<runErrorStatusController>().textmsg.value = 'S I M U L A T I O N';
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
