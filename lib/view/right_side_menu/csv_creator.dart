import 'dart:async';
import 'dart:io';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wr_ui/view/chart/oes_chart.dart';

import 'log_screen.dart';

class CSVButton extends GetView<CsvController> {
  Future<void> updaeteCSV() async {
    Get.find<CsvController>().csvSave();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 30),
        Obx(() => IgnorePointer(
            ignoring: controller.inactiveBtn.value,
            child: ElevatedButton(
              onPressed: () async {
                await controller.csvSaveInit();
                controller.fileSave.value = true;
                Get.find<LogListController>().startCsv();
                controller.inactiveBtn.value = true;
              },
              child: Container(
                width: 200,
                child: Row(
                  children: [
                    Container(
                        padding: EdgeInsets.only(left: 30),
                        width: 65,
                        child: Obx(() => Visibility(
                              visible: controller.fileSave.value,
                              child: Row(
                                children: [
                                  FadeTransition(
                                      opacity: controller.animation,
                                      child: Icon(Icons.circle,
                                          size: 17, color: Colors.red)),
                                ],
                              ),
                            ))),
                    Text(
                      "Save Start",
                    ),
                  ],
                ),
              ),
              style: ElevatedButton.styleFrom(
                primary: controller.inactiveBtn.value
                    ? Colors.grey
                    : Colors.greenAccent[700],
                textStyle: TextStyle(fontSize: 16),
              ),
            ))),
        SizedBox(height: 30),
        Obx(() => IgnorePointer(
              ignoring: !controller.inactiveBtn.value,
              child: ElevatedButton(
                onPressed: () async {
                  controller.fileSave.value = false;
                  Get.find<LogListController>().stopCsv();
                  controller.inactiveBtn.value = false;
                },
                child: Container(
                  width: 200,
                  child: Center(
                    child: Text(
                      "Save Stop",
                    ),
                  ),
                ),
                style: ElevatedButton.styleFrom(
                    primary:
                        controller.inactiveBtn.value ? Colors.red : Colors.grey,
                    textStyle: TextStyle(fontSize: 16)),
              ),
            ))
      ],
    );
  }
}

class CsvController extends GetxController with SingleGetTickerProviderMixin {
  late AnimationController animationCtrl =
      AnimationController(vsync: this, duration: Duration(seconds: 1))
        ..repeat();
  late Animation<double> animation =
      CurvedAnimation(parent: animationCtrl, curve: Curves.ease);
  RxString path = ''.obs;
  RxBool fileSave = false.obs;
  RxBool inactiveBtn = false.obs;
  RxInt fileNum = 1.obs;

  Future<File> csvSave() async {
    DateTime current = DateTime.now();
    String ms = DateTime.now().millisecondsSinceEpoch.toString();
    int msLength = ms.length;
    int third = int.parse(ms.substring(msLength - 3, msLength));
    String fileName = '${DateFormat('HH:mm:ss').format(current)}.$third';
    File file = File(path.value);

    List<dynamic> firstData = [];
    List<List<dynamic>> addFirstData = [];
    firstData.add(fileName);
    if (Get.find<CsvController>().fileSave.value &&
        Get.find<OesController>().oneData.length > 284 &&
        Get.find<OesController>().oneData.length <= 285) {
      Get.find<OesController>().oneData.forEach((v) {
        firstData.add(v.num);
      });
    }

    addFirstData.add(firstData);
    String csv = const ListToCsvConverter().convert(addFirstData) + '\n';
    return file.writeAsString(csv, mode: FileMode.append);
  }

  Future<File> csvSaveInit() async {
    DateTime current = DateTime.now();
    //print("csv save");
    final String fileName = DateFormat('yyyyMMdd-HHmmss').format(current);
    final String streamDateTime =
        DateFormat('yyyy/MM/dd HH:mm:ss').format(current);
    await Directory('datafiles').create();
    path.value = "./datafiles/$fileName\_$fileNum.csv";
    String startTime = streamDateTime;
    File file = File(path.value);

    List<dynamic> initData = [
      "FileFormat:1",
      "HWType:SPdbUSBm",
      "Start Time : $startTime",
      "Intergration Time:",
      "Interval:"
    ];

    List<int> rangeData = [];
    Get.find<OesController>().oneData.forEach((v) {
      rangeData.add(v.range);
    });

    String intergrationColumn = initData.join('\n') +
        '\n' +
        "Time" +
        ',' +
        // "VIZ_1" +
        // ',' +
        rangeData.join(',') +
        '\n';

    return file.writeAsString(intergrationColumn);
  }
}
