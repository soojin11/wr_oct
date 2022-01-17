import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wr_ui/controller/button.dart';
import 'package:wr_ui/controller/oes_ctrl.dart';
import 'package:wr_ui/main.dart';
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
          ignoring:
              controller.csvSaveData.value || iniController.to.checkAuto.value,
          child: RightButton(
              text: 'Save Start',
              icon: Icons.circle,
              color: controller.csvSaveData.value ? Colors.red : Colors.white,
              primary: controller.csvSaveData.value ||
                      iniController.to.checkAuto.value
                  ? Colors.grey
                  : Colors.green,
              onPressed: () {
                DateTime current = DateTime.now();
                DateTime dt = DateTime.utc(
                    current.year,
                    current.month,
                    current.day,
                    current.hour,
                    current.minute,
                    current.second,
                    current.millisecond);
                CsvController.to.saveFileName.value =
                    DateFormat('yyyyMMdd-HHmmss').format(current);
                CsvController.to.startTime.value =
                    DateFormat('HH:mm:ss.SSS').format(dt);
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
          ignoring:
              !controller.csvSaveData.value || iniController.to.checkAuto.value,
          child: RightButton(
              text: 'Save Stop',
              icon: Icons.pause,
              primary: aa(),
              // controller.csvSaveData.value ? Colors.red : Colors.grey,
              onPressed: () {
                Get.find<CsvController>().csvSaveInit.value = false;
                Get.find<CsvController>().csvSaveData.value = false;
                Get.find<OesController>().startBtn.value = false;
                Get.find<LogListController>().stopCsv();
              })))
    ]);
  }

  Color aa() {
    Color bb = Colors.grey;
    if (iniController.to.checkAuto.value && controller.csvSaveData.value) {
      bb = Colors.grey;
    }
    if (controller.csvSaveData.value && !iniController.to.checkAuto.value) {
      bb = Colors.red;
    }
    return bb;
  }
}

class CsvController extends GetxController {
  static CsvController get to => Get.find();
  RxBool csvSaveInit = false.obs;
  RxBool csvSaveData = false.obs;
  RxList<String> path = RxList.empty();
  RxString saveFileName = ''.obs;
  RxString startTime = ''.obs;
  String fileName() {
    DateTime current = DateTime.now();
    String fileName = DateFormat('yyyyMMdd-HHmmss').format(current).toString();
    return fileName;
  }

  String timeVal() {
    DateTime current = DateTime.now();
    DateTime dt = DateTime.utc(current.year, current.month, current.day,
        current.hour, current.minute, current.second, current.millisecond);
    String addTime = DateFormat('HH:mm:ss').format(dt);
    return addTime;
  }

  String difTime() {
    DateTime current = DateTime.now();
    final bb = DateTime.parse(saveFileName.value);
    final aa = DateTime(current.year, current.month, current.day, current.hour,
            current.minute, current.second, current.millisecond)
        .difference(DateTime(bb.year, bb.month, bb.day, bb.hour, bb.minute,
            bb.second, bb.millisecond));
    print('시가안 : $aa');
    return aa.toString();
  }

  void csvForm({required String path, required List<dynamic> data}) async {
    Directory('datafiles').create();
    File file = File("./datafiles/${saveFileName.value}\_$path");
    String csv = DateFormat('yyyy-MM-dd HH:mm:ss.SSS').format(DateTime.now()) +
        ',' +
        data.join(',') +
        '\n';
    try {
      await file.writeAsString(csv, mode: FileMode.append);
    } catch (e) {
      debugPrint(e.toString());
    }
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
    // if (!file.existsSync()) {
    await file.writeAsString(intergrationColumn);
    // }
    return true;
  }

  void vizDataSave({required List<dynamic> data}) async {
    Directory('datafiles').create(recursive: true);
    File file = File("./datafiles/WR_VIZ_${saveFileName.value}.csv");
    String csv = timeVal() + ',' + ',' + data.join(',') + '\n';
    try {
      await file.writeAsString(csv, mode: FileMode.append);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<bool> vizSaveInit() async {
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
      'Seconds',
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
    return true;
  }
}
