import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wr_ui/controller/setting_controller.dart';
import 'package:wr_ui/service/database/recipe/config_model.dart';
import 'package:wr_ui/view/appbar/actions/setting/setting_menu_final.dart';
import 'package:wr_ui/view/appbar/leading/run_error_status_mark.dart';
import 'package:wr_ui/view/chart/oes_chart.dart';
import 'package:wr_ui/view/right_side_menu/ini_creator.dart';

import 'csv_creator.dart';
import 'log_screen.dart';

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
                //Get.find<VizController>().inactiveBtn.value = true;
                Get.find<OesController>().inactiveBtn.value = true;
                // Get.find<OesController>().timer = Timer.periodic(
                //     Duration(milliseconds: 100),
                //     Get.find<OesController>().updateDataSource);
                try {
                  Get.find<OesController>().timer = Timer.periodic(
                      Duration(
                          milliseconds: int.parse(Get.find<SettingController>()
                              .exposureTime
                              .value)),
                      Get.find<OesController>().updateDataSource);
                } on FormatException {
                  print('format error');
                }
                Get.find<OesController>().oneData;
                Get.find<runErrorStatusController>().connect.value = true;
                Get.find<runErrorStatusController>().textmsg.value =
                    'SIMULATION';
                Get.find<iniControllerWithReactive>()
                    .measureStartAtProgStart
                    .value = '0';
                // Get.find<iniControllerWithReactive>().writeIni();

                // Get.find<VizController>().timer = Timer.periodic(
                //     Duration(milliseconds: 100),
                //Get.find<VizController>().updateDataSource);
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
                Get.find<OesController>().inactiveBtn.value = false;
                // Get.find<VizController>().inactiveBtn.value = false;
                // Get.find<VizController>().timer.cancel();
                Get.find<OesController>().timer.cancel();
                Get.find<LogListController>().clickedStop();
                Get.find<CsvController>().fileSave.value = false;
                Get.find<runErrorStatusController>().connect.value = false;
                Get.find<runErrorStatusController>().textmsg.value = 'STOP';
                Get.find<iniControllerWithReactive>()
                    .measureStartAtProgStart
                    .value = '';
                // Get.find<iniControllerWithReactive>().writeIni();
              },
            ),
          ),
        ),
      ],
    );
  }
}
