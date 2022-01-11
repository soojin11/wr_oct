import 'dart:async';
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
                    if (iniController.to.oes_comport.value != 0 &&
                        iniController.to.oes_comport.value != -1) {
                      mpmSetChannel(0);
                    }
                    Get.find<LogListController>().clickedStop();
                    Get.find<runErrorStatusController>().connect.value = false;
                    Get.find<runErrorStatusController>().textmsg.value =
                        'S T O P';
                  })),
        ),
      ],
    );
  }
}

DataStartBtn() async {
  // if (Get.find<iniController>().sim.value == 0) {
  // if (iniController.to.oesSim.value == false) {
  if (iniController.to.oes_comport.value != 0 &&
      iniController.to.oes_comport.value != -1) {
    if (ocrs != 0) await oesClose();
    await oesInit();
  }

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
    Get.find<OesController>().startBtn.value = true;
    if (iniController.to.oes_comport.value != 0 &&
        iniController.to.oes_comport.value != -1) {
      setIntegrationTime(0, Get.find<iniController>().integrationTime.value);
      Get.find<runErrorStatusController>().statusColor.value =
          Color(0xFF2CA732);
      Get.find<runErrorStatusController>().textmsg.value = 'R U N';
    } else if (iniController.to.oes_comport.value != -1) {
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
    VizCtrl.to.timer = Timer.periodic(
      Duration(milliseconds: Get.find<iniController>().viz_Interval.value),
      VizCtrl.to.readSerial,
    );
    Get.find<LogController>()
        .loglist
        .add('${logfileTime()} channle moving t $time1');
    Get.find<LogController>().loglist.add('${logfileTime()} all t $allTime');
  } on FormatException {
    print('format error');
  }
}
