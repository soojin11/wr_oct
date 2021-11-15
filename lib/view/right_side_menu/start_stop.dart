import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:wr_ui/view/chart/main_chart.dart';

import 'log_save.dart';
import 'log_screen.dart';

class StartStop extends StatelessWidget {
  const StartStop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Obx(
          () => IgnorePointer(
            ignoring: Get.find<ChartController>().igButton.value,
            child: OutlinedButton(
              child: Text('Start'),
              style: OutlinedButton.styleFrom(
                  primary: Get.find<ChartController>().igButton.value
                      ? Colors.grey
                      : Colors.blue),
              onPressed: () async {
                Get.find<ChartController>().igButton.value = true;
                Get.find<ChartController>().timer = Timer.periodic(
                    Duration(microseconds: 1),
                    Get.find<ChartController>().updateDataSource);

                Get.find<LogListController>().clickedStart();
                Get.find<LogController>().loglist.add(
                    '[Event Trigger] ${DateTime.now()}  :  Start button is pressed' +
                        '\n');
                Get.find<LogController>().logSaveInit();
                Get.find<LogController>().fileSave.value = true;
              },
            ),
          ),
        ),
        Obx(
          () => IgnorePointer(
            ignoring: !Get.find<ChartController>().igButton.value,
            child: OutlinedButton(
              child: Text('Stop'),
              style: OutlinedButton.styleFrom(
                  primary: Get.find<ChartController>().igButton.value
                      ? Colors.blue
                      : Colors.grey),
              onPressed: () {
                Get.find<ChartController>().igButton.value = false;
                Get.find<ChartController>().timer.cancel();
                Get.find<LogListController>().clickedStop();

                Get.find<LogController>().loglist.add(
                    '[Event Trigger] ${DateTime.now()}  :  Stop button is pressed' +
                        '\n');
                Get.find<LogController>().logSaveInit();
                Get.find<LogController>().fileSave.value = true;
              },
            ),
          ),
        ),
      ],
    );
  }
}
