import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wr_ui/main.dart';
import 'package:wr_ui/view/chart/oes_chart.dart';
import 'package:wr_ui/view/right_side_menu/ini_creator.dart';

class DataMonitorCtrl extends GetxController {
  static DataMonitorCtrl get to => Get.find();

  bRunningFunc() {
    while (Get.find<OesController>().bRunning.value) {
      for (var i = 0;
          i < Get.find<iniControllerWithReactive>().OES_Count.value;
          i++) {
        mpmSetChannel(6);
        getformatSpec(0);
        print('bRunning  ing?? ' + ' ${getformatSpec(0)}');
      }
      print('bRunning stop?? ' + ' ${getformatSpec(0)}');
    }
  }
}

class DataMonitor extends StatelessWidget {
  const DataMonitor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
          child: Get.find<OesController>().bRunning.value == false
              ? Text('SIM')
              : Text('Real Data'),
        ));
  }
}
