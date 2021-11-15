import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:wr_ui/view/chart/oes_chart.dart';
import 'package:wr_ui/view/chart/viz_chart.dart';

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
        Obx(()=> IgnorePointer(ignoring: Get.find<VizController>().inactiveBtn.value,
        child: ElevatedButton(
          child: Text('Start'),
          style: ElevatedButton.styleFrom(
            primary: Get.find<VizController>().inactiveBtn.value ? Colors.grey : Colors.blue,
            textStyle: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)
          ),
            onPressed: () async{
              Get.find<VizController>().inactiveBtn.value = true;
              Get.find<VizController>().timer = Timer.periodic(
                  Duration(microseconds: 100),
                  Get.find<VizController>().updateDataSource);



Get.find<OesController>().timer = Timer.periodic(
                   Duration(milliseconds: 100), Get.find<OesController>().updateDataSource);
                   Get.find<OesController>().oesData;


              Get.find<LogListController>().clickedStart();
              Get.find<LogController>().loglist.add(
                  '[Event Trigger] ${DateTime.now()}  :  Start button is pressed' +
                      '\n');
              Get.find<LogController>().logSaveInit();
              Get.find<LogController>().fileSave.value = true;
              
            },
            ),),),
            SizedBox(width: 30),
       Obx(()=>IgnorePointer(
         ignoring : !Get.find<VizController>().inactiveBtn.value,
       child: ElevatedButton(
         child: Text('Stop'),
          style: ElevatedButton.styleFrom(
            primary: Get.find<VizController>().inactiveBtn.value ? Colors.blue : Colors.grey,
            textStyle: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)
          ),
            onPressed: () {
              Get.find<VizController>().inactiveBtn.value=false;
              Get.find<VizController>().timer.cancel();
              Get.find<OesController>().timer.cancel();
              Get.find<LogListController>().clickedStop();

              Get.find<LogController>().loglist.add(
                  '[Event Trigger] ${DateTime.now()}  :  Stop button is pressed' +
                      '\n');
              Get.find<LogController>().logSaveInit();
              Get.find<LogController>().fileSave.value = true;
            },
            ),),),
        
      ],
    );
  }
}
