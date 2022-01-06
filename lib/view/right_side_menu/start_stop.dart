import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wr_ui/controller/button.dart';
import 'package:wr_ui/main.dart';
import 'package:wr_ui/view/appbar/leading/run_error_status_mark.dart';
import 'package:wr_ui/view/chart/oes_chart.dart';
import 'package:wr_ui/controller/viz_ctrl.dart';
import 'package:wr_ui/view/right_side_menu/log_save.dart';
import 'package:wr_ui/view/right_side_menu/save_ini.dart';

import 'csv_creator.dart';
import 'log_screen.dart';

int nChannelIdx = 0;
// int nChannelIdx = -1;//range error 나서 초기값 바꿈

class StartStop extends StatelessWidget {
  const StartStop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(height: 30),
        Obx(() => IgnorePointer(
            ignoring: Get.find<OesController>().inactiveBtn.value,
            child: RightButton(
                text: 'Start',
                icon: Icons.play_arrow,
                primary: Get.find<OesController>().inactiveBtn.value
                    ? Colors.grey
                    : Colors.green,
                onPressed: () async {
                  await VizCtrl.to.sendStart(); //측정 시작

                  // Timer.periodic(Duration(milliseconds: 100), (timer) {
                  //   Uint8List aa = VizCtrl.to.vizChannel[1].port.read(100);
                  //   print('uint8list viz read $aa');
                  // });
                  for (var item in VizCtrl.to.buffer) {
                    item.clear();
                  }
                  DataStartBtn();
                }))),
        SizedBox(height: 30),
        Obx(
          () => IgnorePointer(
              ignoring: !Get.find<OesController>().inactiveBtn.value,
              child: RightButton(
                  text: 'Stop',
                  primary: Get.find<OesController>().inactiveBtn.value
                      ? Colors.red
                      : Colors.grey,
                  icon: Icons.pause,
                  onPressed: () {
                    Get.find<OesController>().timer?.cancel();
                    VizCtrl.to.timer.cancel();
                    Get.find<runErrorStatusController>().statusColor.value =
                        Colors.red;
                    Get.find<OesController>().inactiveBtn.value = false;
                    Get.find<CsvController>().csvSaveInit.value = false;
                    Get.find<CsvController>().csvSaveData.value = false;
                    Get.find<OesController>().startBtn.value = false;
                    if (Get.find<iniController>().sim.value == 0) {
                      mpmSetChannel(0);
                    }
                    Get.find<LogListController>().clickedStop();
                    Get.find<runErrorStatusController>().connect.value = false;
                    Get.find<runErrorStatusController>().textmsg.value =
                        'S T O P';
                  })),
        ),
        //   Row(
        //     children: [
        //       ElevatedButton(
        //         child: Text('open'),
        //         onPressed: () {
        //           VizCtrl.to.startSerial();
        //           // VizCtrl.to.readSerial;
        //         },
        //       ),
        //       ElevatedButton(
        //         child: Text('close'),
        //         onPressed: () {
        //           VizCtrl.to.vizChannel[0].port.close();
        //           print('열렸나? ${VizCtrl.to.vizChannel[0].port.isOpen}');
        //         },
        //       ),
        //       ElevatedButton(
        //         child: Text('시작'),
        //         onPressed: () async {
        //           await VizCtrl.to.sendStart(); //측정 시작
        //           VizCtrl.to.buffer.clear();
        //           VizCtrl.to.timer = Timer.periodic(
        //             Duration(
        //                 milliseconds: int.parse(
        //                     Get.find<iniController>().viz_Interval.value)),
        //             VizCtrl.to.readSerial,
        //           );
        //           // VizCtrl.to.vizChartTimer = Timer.periodic(
        //           //     Duration(milliseconds: 100), VizCtrl.to.vizUpdate);
        //         },
        //       ),
        //       ElevatedButton(
        //         child: Text('멈춤'),
        //         onPressed: () async {
        //           VizCtrl.to.timer?.cancel();
        //           VizCtrl.to.vizChartTimer?.cancel();
        //         },
        //       )
        //     ],
        //   ),
        //   Row(
        //     children: [
        //       ElevatedButton(
        //         child: Text('증가'),
        //         onPressed: () {
        //           // Get.find<OesController>().fmtSpec[300] + 200;
        //           // Get.find<OesController>().addYvalue.value = 500;
        //           // VizCtrl.to.vizChartTimer = Timer.periodic(
        //           //     Duration(milliseconds: 100), VizCtrl.to.vizSimUpdate);
        //           // VizCtrl.to.vizChartTimer = Timer.periodic(
        //           //     Duration(milliseconds: 100), VizCtrl.to.vizUpdate);
        //         },
        //       ),
        //       ElevatedButton(
        //         child: Text('감소'),
        //         onPressed: () {
        //           Get.find<OesController>().addYvalue.value = 0;
        //           // VizCtrl.to.vizChartTimer.cancel();
        //         },
        //       ),
        //       ElevatedButton(
        //         child: Text('줌리셋'),
        //         onPressed: () {
        //           Get.find<OesController>().minX.value = 0;
        //           Get.find<OesController>().maxX.value = 2048;
        //         },
        //       ),
        //     ],
        //   )
      ],
    );
  }
}

DataStartBtn() {
  DateTime current = DateTime.now();
  Get.find<CsvController>().saveFileName.value =
      DateFormat('yyyyMMdd-HHmmss').format(current);
  String ms = DateTime.now().millisecondsSinceEpoch.toString();
  int msLength = ms.length;
  int third = int.parse(ms.substring(msLength - 3, msLength));
  Get.find<CsvController>().startTime.value =
      '${DateFormat('HH:mm:ss').format(current)}.$third';
  Get.find<runErrorStatusController>().connect.value = true;
  Get.find<LogListController>().clickedStart();
  Get.find<OesController>().inactiveBtn.value = true;
  try {
    int time1 = Get.find<iniController>().channelMovingTime.value.toInt();
    double doubletime2 = Get.find<iniController>().integrationTime.value / 1000;
    int inttime2 = doubletime2.toInt();
    int time3 = Get.find<iniController>().plusTime.value;
    time3 = 150;
    Get.find<iniController>().waitSwitchingTime.value = 400;
    int allTime =
        inttime2 + Get.find<iniController>().waitSwitchingTime.value + time3;
    if (doubletime2 <= Get.find<iniController>().waitSwitchingTime.value) {
      allTime =
          inttime2 + Get.find<iniController>().waitSwitchingTime.value + time3;
    } else
      allTime = (inttime2 * 2) + time3;
    print('time1?? $time1');
    print('time2?? $inttime2');
    print('time3?? $time3');
    print('allTime??? $allTime');
    // Get.find<LogListController>().logData.add(
    //     'all/wait time : $allTime ${Get.find<iniController>().waitSwitchingTime.value}');
    Get.find<OesController>().startBtn.value = true;
    if (Get.find<iniController>().sim == 0) {
      setIntegrationTime(0, Get.find<iniController>().integrationTime.value);
      Get.find<runErrorStatusController>().statusColor.value =
          Color(0xFF2CA732);
      Get.find<runErrorStatusController>().textmsg.value = 'R U N';
    } else {
      Get.find<runErrorStatusController>().textmsg.value =
          'S I M U L A T I O N';
      Get.find<runErrorStatusController>().statusColor.value =
          Color(0xFFE9DF50);
    }

    nChannelIdx = 0;

    Get.find<OesController>().timer = Timer.periodic(
      Duration(milliseconds: allTime),
      Get.find<OesController>().updateDataSource,
    );

    // VizCtrl.to.vizChartTimer = Timer.periodic(
    //     Duration(
    //         milliseconds:
    //             int.parse(Get.find<iniController>().viz_Interval.value)),
    //     VizCtrl.to.vizSimUpdate);
    VizCtrl.to.timer = Timer.periodic(
      Duration(
          milliseconds:
              int.parse(Get.find<iniController>().viz_Interval.value)),
      VizCtrl.to.readSerial,
    );
    // Get.find<LogListController>().logData.add(
    //       'channle moving time $time1',
    //     );
    Get.find<LogController>()
        .loglist
        .add('${logfileTime()} channle moving t $time1');
    // Get.find<LogListController>().logData.add(
    //       'all time $allTime',
    //     );
    Get.find<LogController>().loglist.add('${logfileTime()} all t $allTime');
  } on FormatException {
    print('format error');
  }
  Get.find<OesController>().oesData[0];
}
