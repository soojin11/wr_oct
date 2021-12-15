import 'dart:async';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wr_ui/main.dart';
import 'package:wr_ui/view/appbar/leading/run_error_status_mark.dart';
import 'package:wr_ui/view/chart/oes_chart.dart';
import 'package:wr_ui/view/right_side_menu/log_save.dart';
import 'package:wr_ui/view/right_side_menu/save_ini.dart';

import 'csv_creator.dart';
import 'log_screen.dart';

int nChannelIdx = 0;
// int nChannelIdx = -1;//range error 나서 초기값 바꿈
List<FlSpot> chartData = RxList.empty();

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
                // Get.defaultDialog<bool>(
                //   title: 'ocrstart 2',
                //   content: Text('test'),
                //   // onConfirm: () => null,
                //   // onCancel: () => null,
                //   // onCustom: () => null,
                //   // textConfirm: "확인",
                //   // textCancel: "취소",
                //   // confirm: Container(height: 20),
                //   // cancel: Container(height: 20),
                // );
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
                  //스탑버튼 눌렀을 때, OES_Simulation==1(디바이스 데이터) 일 경우에 할 것들
                  if (Get.find<iniController>().sim.value == 1) {
                    //채널 1번으로
                    mpmSetChannel(0);
                    //타이머 캔슬
                    Get.find<OesController>().timer?.cancel();
                    //스탑버튼 눌렀을 때, OES_Simulation==0(디바이스 데이터) 일 경우에 할 것들
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
  DateTime current = DateTime.now();
  Get.find<CsvController>().saveFileName.value =
      DateFormat('yyyyMMdd-HHmmss').format(current);
  if (Get.find<iniController>().sim.value == 1) {
    Get.find<runErrorStatusController>().statusColor.value = Color(0xFF2CA732);
    Get.find<OesController>().inactiveBtn.value = true;
    try {
      //채널움직이는시간
      int time1 = Get.find<iniController>().channelMovingTime.value.toInt();
      //integration 빛수집
      double doubletime2 =
          Get.find<iniController>().integrationTime.value / 1000;
      int inttime2 = doubletime2.toInt();
      //30ms여유시간(빛 수집 후)
      double doubletime3 = Get.find<iniController>().plusTime.value / 1000;

      int inttime3 = doubletime3.toInt();

      int allTime = time1 + inttime2 + inttime3;
      print('time1?? $time1');
      print('time2?? $inttime3');
      print('time3?? $inttime3');
      print('allTime??? $allTime');
      nChannelIdx = 0;
      chartData = Get.find<OesController>().oesData[0];
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
  // try {
  //   Get.find<OesController>().simTimer = Timer.periodic(
  //       Duration(milliseconds: 500),
  //       Get.find<OesController>().updateSimulation);
  // } on FormatException {
  //   print('format error');
  // }
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