import 'dart:async';
import 'dart:ffi';
import 'package:ffi/ffi.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wr_ui/main.dart';
import 'package:wr_ui/view/appbar/actions/setting/setting_menu_final.dart';
import 'package:wr_ui/view/appbar/leading/run_error_status_mark.dart';
import 'package:wr_ui/view/chart/oes_chart.dart';
import 'package:wr_ui/view/right_side_menu/ini_creator.dart';
import 'package:wr_ui/view/right_side_menu/save_ini.dart';
import 'csv_creator.dart';
import 'log_screen.dart';

class StartStopController extends GetxController {
  // update111() {
  //   mpmSetChannel(0);
  //   Pointer<Double> getfmtSpec = calloc<Double>(2048);
  //   getfmtSpec = getformatSpec(0);
  //   List<double> xsTemp1 = [];
  //   for (var i = 0; i < 2048; i++) {
  //     xsTemp1.add(getfmtSpec[i]);
  //     print('xsTemp1?? ${xsTemp1[i]}');
  //   }
  //   double ddd = getfmtSpec[2047];
  //   print('ddd$ddd');
  //   Get.find<OesController>().oneData.clear();
  //   Get.find<OesController>().twoData.clear();
  //   Get.find<OesController>().threeData.clear();
  //   Get.find<OesController>().fourData.clear();
  //   Get.find<OesController>().fiveData.clear();
  //   Get.find<OesController>().sixData.clear();
  //   Get.find<OesController>().sevenData.clear();
  //   Get.find<OesController>().eightData.clear();

  //   List<double> xsTemp2 = [];
  //   Pointer<Double> getwveLength = getWavelength(0);
  //   // for (var i = 0; i < 2048; i++) {
  //   //   xsTemp2.add(getwveLength[i]);
  //   //   print('xsTemp2?? ${xsTemp2[i]}');
  //   // }
  //   //Get.find<OesController>().timer.cancel();
  //   // for (var i = 0; i < 2048; i++) {
  //   //   Get.find<OesController>()
  //   //       .oneData
  //   //       .add(FlSpot(getwveLength[i], getfmtSpec[i]));
  //   //   Get.find<OesController>()
  //   //       .twoData
  //   //       .add(FlSpot(getwveLength[i], getfmtSpec[i]));
  //   //   Get.find<OesController>()
  //   //       .threeData
  //   //       .add(FlSpot(getwveLength[i], getfmtSpec[i]));

  //   //   Get.find<OesController>()
  //   //       .fourData
  //   //       .add(FlSpot(getwveLength[i], getfmtSpec[i]));
  //   //   Get.find<OesController>()
  //   //       .fiveData
  //   //       .add(FlSpot(getwveLength[i], getfmtSpec[i]));
  //   //   Get.find<OesController>()
  //   //       .sixData
  //   //       .add(FlSpot(getwveLength[i], getfmtSpec[i]));
  //   //   Get.find<OesController>()
  //   //       .sevenData
  //   //       .add(FlSpot(getwveLength[i], getfmtSpec[i]));
  //   //   Get.find<OesController>()
  //   //       .eightData
  //   //       .add(FlSpot(getwveLength[i], getfmtSpec[i]));
  //   //   if (getfmtSpec[i] < 1) print('aa?? ${getfmtSpec[i]}');
  //   // }
  //   //calloc.free(aa);
  // }
}

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
                StartButton();
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
                Get.find<CsvController>().inactiveBtn.value = false;
                // Get.find<VizController>().inactiveBtn.value = false;
                // Get.find<VizController>().timer.cancel();

                Get.find<OesController>().timer.cancel();
                Get.find<OesController>().timer.cancel();
                Get.find<LogListController>().clickedStop();
                Get.find<CsvController>().fileSave.value = false;
                Get.find<runErrorStatusController>().connect.value = false;
                Get.find<runErrorStatusController>().textmsg.value = 'STOP';
                Get.find<runErrorStatusController>().runColor.value =
                    Color(0xFFD12F2D);

                // Get.find<iniControllerWithReactive>()
                //     .measureStartAtProgStart
                //     .value = '';
                // Get.find<iniControllerWithReactive>().writeIni();

                // Get.find<OesController>().inactiveBtn.value = false;
                // Get.find<CsvController>().inactiveBtn.value = false;
                // // Get.find<VizController>().inactiveBtn.value = false;
                // // Get.find<VizController>().timer.cancel();
                // Get.find<OesController>().timer!.cancel();
                // Get.find<LogListController>().clickedStop();
                // Get.find<CsvController>().fileSave.value = false;
                // Get.find<runErrorStatusController>().connect.value = false;
                // Get.find<runErrorStatusController>().textmsg.value = 'STOP';
                // Get.find<iniControllerWithReactive>()
                //     .measureStartAtProgStart
                //     .value = '';
                // Get.find<iniControllerWithReactive>().writeIni();
              },
            ),
          ),
        ),
      ],
    );
  }
}

void StartButton() {
  if (Get.find<iniController>().sim.value == 1) {
    Get.find<OesController>().inactiveBtn.value = true;
    try {
      Get.find<OesController>().timer = Timer.periodic(
          Duration(
              milliseconds:
                  int.parse(Get.find<iniController>().exposureTime.value)),
          Get.find<OesController>().updateDataSource);
    } on FormatException {
      print('format error');
    }
    // Get.find<OesController>().chartData;
    //Get.find<OesController>().oneData;
    Get.find<runErrorStatusController>().connect.value = true;
    Get.find<runErrorStatusController>().textmsg.value = 'RUN';
    Get.find<runErrorStatusController>().runColor.value = Color(0xFF2CA732);

    Get.find<LogListController>().clickedStart();
  }
  if (Get.find<iniController>().sim.value == 0) {
    //SimStart();
  }
}


// SimStart(){
// Get.find<OesController>().inactiveBtn.value = true;
// try{Get.find<OesController>().timer = Timer.periodic(
//                   Duration(milliseconds: int.parse(Get.find<iniController>().exposureTime.value)),
//                   Get.find<OesController>().SimupdateDataSource);} on FormatException{print('format error');}
//                 Get.find<OesController>().oneData;
//                 Get.find<runErrorStatusController>().connect.value = true;
//                 Get.find<runErrorStatusController>().textmsg.value = 'SIMULATION';
//                 Get.find<runErrorStatusController>().runColor.value = Color(0xFFE9DF50);
//                 Get.find<LogListController>().clickedStart();
// }