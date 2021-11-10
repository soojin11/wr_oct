import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:wr_ui/chart/oes_chart.dart';
import 'package:wr_ui/chart/viz_chart.dart';

import 'log_save.dart';
import 'log_screen.dart';

class StartStop extends StatelessWidget {
  const StartStop({Key? key}) : super(key: key);

  // @override
  // Widget build(BuildContext context) {
  //   return ToggleSwitch(
  //     minWidth: 50,
  //     minHeight: 20,
  //     cornerRadius: 10.0,
  //     activeBgColors: [
  //       [Colors.green[800]!],
  //       [Colors.red[800]!]
  //     ],
  //     activeFgColor: Colors.white,
  //     inactiveBgColor: Colors.grey,
  //     inactiveFgColor: Colors.white,
  //     initialLabelIndex: 1,
  //     totalSwitches: 2,
  //     labels: ['Start', 'Stop'],
  //     radiusStyle: true,
  //     onToggle: (index) {
  //       if (index == 1) {
  //         Get.find<LogListController>().clickedStop();
  //       } else {
  //         Get.find<LogListController>().clickedStart();
  //       }
  //     },
  //   );
  // }
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        OutlinedButton(
            onPressed: () {
              Get.find<VizController>().timer = Timer.periodic(
                  Duration(milliseconds: 100),
                  Get.find<VizController>().updateDataSource);
              Get.find<LogListController>().clickedStart();
              Get.find<LogController>().loglist.add(
                  '${DateFormat('mm분 ss초').format(DateTime.now())} Start button is pressed' +
                      '\n');
              Get.find<LogController>().logSaveInit();
              Get.find<LogController>().fileSave.value = true;
            },
            child: Text('Start')),
        OutlinedButton(
            onPressed: () {
              Get.find<VizController>().timer.cancel();
              Get.find<LogListController>().clickedStop();

              Get.find<LogController>().loglist.add(
                  '${DateFormat('mm분 ss초').format(DateTime.now())} Stop button is pressed' +
                      '\n');
              Get.find<LogController>().logSaveInit();
              Get.find<LogController>().fileSave.value = true;
            },
            child: Text('Stop'))
      ],
    );
  }
}
