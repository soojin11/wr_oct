import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:wr_ui/model/const/style/pallette.dart';
import 'package:wr_ui/view/chart/oes_chart.dart';
import 'package:wr_ui/view/chart/viz_chart.dart';

import 'log_save.dart';
import 'log_screen.dart';

class StartStop extends StatelessWidget {
  const StartStop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(height: 30),
        Obx(
          () => IgnorePointer(
            ignoring: Get.find<VizController>().inactiveBtn.value,
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
                  primary: Get.find<VizController>().inactiveBtn.value
                      ? Colors.grey
                      : Colors.greenAccent[700],
                  textStyle: TextStyle(fontSize: 16)),
              onPressed: () async {
                Get.find<VizController>().inactiveBtn.value = true;
                Get.find<OesController>().inactiveBtn.value = true;
                Get.find<OesController>().timer = Timer.periodic(
                    Duration(milliseconds: 100),
                    Get.find<OesController>().updateDataSource);
                Get.find<OesController>().oesData;
                Get.find<VizController>().timer = Timer.periodic(
                    Duration(milliseconds: 100),
                    Get.find<VizController>().updateDataSource);
                Get.find<LogListController>().clickedStart();
              },
            ),
          ),
        ),
        SizedBox(height: 30),
        Obx(
          () => IgnorePointer(
            ignoring: !Get.find<VizController>().inactiveBtn.value,
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
                  primary: Get.find<VizController>().inactiveBtn.value
                      ? Colors.red
                      : Colors.grey,
                  textStyle: TextStyle(fontSize: 16)),
              onPressed: () {
                Get.find<VizController>().inactiveBtn.value = false;
                Get.find<VizController>().timer.cancel();
                Get.find<OesController>().timer.cancel();
                Get.find<LogListController>().clickedStop();
              },
            ),
          ),
        ),
      ],
    );
  }
}
