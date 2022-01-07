import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wr_ui/controller/button.dart';
import 'package:wr_ui/controller/viz_ctrl.dart';
import 'package:wr_ui/main.dart';
import 'package:wr_ui/view/chart/oes_chart.dart';
import 'package:wr_ui/view/right_side_menu/save_ini.dart';
import 'log_screen.dart';

startSaveBtn() async {
  if (Get.find<CsvController>().csvSaveInit.value) {
    Get.find<CsvController>().csvSaveData.value = true;
    for (var i = 0; i < Get.find<iniController>().OES_Count.value; i++) {
      Get.find<CsvController>().csvFormInit(
          path: "_${i + 1}.csv", channelNum: 'channelNum : ${i + 1}');
    }
    Get.find<CsvController>().vizSaveInit();
  }
}

class CSVButton extends GetView<CsvController> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SizedBox(height: 30),
      Obx(() => IgnorePointer(
          ignoring: controller.csvSaveData.value,
          child: RightButton(
              text: 'Save Start',
              icon: Icons.circle,
              color: controller.csvSaveData.value ? Colors.red : Colors.white,
              primary:
                  controller.csvSaveData.value ? Colors.grey : Colors.green,
              onPressed: () {
                Get.find<CsvController>().csvSaveInit.value = true;
                for (var i = 0;
                    i < Get.find<iniController>().OES_Count.value;
                    i++) {
                  Get.find<CsvController>().csvFormInit(
                      path: "_${i + 1}.csv",
                      channelNum: 'channelNum : ${i + 1}');
                }
                Get.find<CsvController>().vizSaveInit();
                Get.find<CsvController>().csvSaveData.value = true;
                Get.find<OesController>().startBtn.value = true;
                Get.find<LogListController>().startCsv();
              }))),
      SizedBox(height: 30),
      Obx(() => IgnorePointer(
          ignoring: !controller.csvSaveData.value,
          child: RightButton(
              text: 'Save Stop',
              icon: Icons.pause,
              primary: controller.csvSaveData.value ? Colors.red : Colors.grey,
              onPressed: () {
                Get.find<CsvController>().csvSaveInit.value = false;
                Get.find<CsvController>().csvSaveData.value = false;
                Get.find<OesController>().startBtn.value = false;
                Get.find<LogListController>().stopCsv();
              })))
    ]);
  }
}

class CsvController extends GetxController with SingleGetTickerProviderMixin {
  late AnimationController animationCtrl =
      AnimationController(vsync: this, duration: Duration(seconds: 1))
        ..repeat();
  late Animation<double> animation =
      CurvedAnimation(parent: animationCtrl, curve: Curves.ease);
  // RxBool fileSave = false.obs;
  RxBool csvSaveInit = false.obs;
  RxBool csvSaveData = false.obs;
  // RxBool inactiveBtn = false.obs;
  RxList<String> path = RxList.empty();
  RxString saveFileName = ''.obs;
  RxString startTime = ''.obs;
  String fileName() {
    DateTime current = DateTime.now();
    String fileName = DateFormat('yyyyMMdd-HHmmss').format(current).toString();
    return fileName;
  }

  //RxInt fileNum = 1.obs;

  String timeVal() {
    DateTime current = DateTime.now();
    String ms = DateTime.now().millisecondsSinceEpoch.toString();
    int msLength = ms.length;
    int third = int.parse(ms.substring(msLength - 3, msLength));
    String addTime = '${DateFormat('HH:mm:ss').format(current)}.$third';
    return addTime;
  }

  void csvForm({required String path, required List<dynamic> data}) async {
    Directory('datafiles').create();
    File file = File("./datafiles/${saveFileName.value}\_$path");
    // int a= 0;
    // print('a $a');
    // String s = a.toString().padLeft(4,'0');
    // print('s $s');
    String csv = DateFormat('yyyy-MM-dd HH:mm:ss.SSS').format(DateTime.now()) +
        ',' +
        data.join(',') +
        '\n';
    print("2번");
    await file.writeAsString(csv, mode: FileMode.append);
  }

  Future<bool> csvFormInit(
      {required String path, required String channelNum}) async {
    Directory('datafiles').create(recursive: true);
    File file = File("./datafiles/${saveFileName.value}\_$path");

    List<dynamic> initData = [
      "FileFormat : 1",
      "HWType : OCR",
      "Start Time : ${startTime.value}",
      "Intergration Time : ${Get.find<iniController>().integrationTime.value}",
      "Interval : 0"
    ];

    String intergrationColumn = initData.join('\n') +
        '\n' +
        channelNum +
        '\n' +
        "Time" +
        ',' +
        listWavelength.join(',') +
        '\n';
    print("1번${saveFileName.value}\_$path}");
    // if (!file.existsSync()) {
    await file.writeAsString(intergrationColumn);
    // }
    return true;
  }

  void vizDataSave({required List<dynamic> data}) async {
    Directory('datafiles').create(recursive: true);
    File file = File("./datafiles/WR_VIZ_${saveFileName.value}.csv");
    String csv = timeVal() + ',' + data.join(',') + '\n';
    await file.writeAsString(csv, mode: FileMode.append);
  }

  void vizSaveInit() async {
    Directory('datafiles').create(recursive: true);
    File file = File("./datafiles/WR_VIZ_${saveFileName.value}.csv");
    List<dynamic> initData = [
      "FileFormat : 2",
      "HWType : VIZ",
      "Start Time : ${startTime.value}",
      "Interval : ${Get.find<iniController>().viz_Interval.value}",
    ];
    List<String> init = [
      'Time',
      'Frequency',
      'P dlv',
      'Vms',
      'Irms',
      'R',
      'X',
      'Phase'
    ];
    String all = initData.join('\n') +
        '\n' +
        init.join(',') +
        init.join(',') +
        init.join(',') +
        init.join(',') +
        init.join(',') +
        '\n';
    if (!file.existsSync()) {
      await file.writeAsString(all);
    }
  }
}
