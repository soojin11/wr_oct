import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wr_ui/controller/viz_ctrl.dart';
import 'package:wr_ui/main.dart';
import 'package:wr_ui/view/right_side_menu/save_ini.dart';
import 'log_screen.dart';

startSaveBtn() async {
  if (Get.find<CsvController>().fileSave.value) {
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
    return Column(
      children: [
        SizedBox(height: 30),
        Obx(() => IgnorePointer(
            ignoring: controller.fileSave.value,
            child: ElevatedButton(
              onPressed: () async {
                Get.find<CsvController>().fileSave.value = true;
                Get.find<LogListController>().startCsv();
                startSaveBtn();
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
                primary: controller.fileSave.value
                    ? Colors.grey
                    : Colors.greenAccent[700],
                textStyle: TextStyle(fontSize: 16),
              ),
            ))),
        SizedBox(height: 30),
        Obx(() => IgnorePointer(
              ignoring: !controller.fileSave.value,
              child: ElevatedButton(
                onPressed: () async {
                  controller.fileSave.value = false;
                  Get.find<LogListController>().stopCsv();
                  // controller.inactiveBtn.value = false;
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
                        controller.fileSave.value ? Colors.red : Colors.grey,
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
  RxBool fileSave = false.obs;
  // RxBool inactiveBtn = false.obs;
  RxList<String> path = RxList.empty();
  RxString saveFileName = ''.obs;
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
    String csv = timeVal() + ',' + data.join(',') + '\n';
    await file.writeAsString(csv, mode: FileMode.append);
  }

  Future<void> csvFormInit({required String path, required String channelNum}) {
    Directory('datafiles').create(recursive: true);
    File file = File("./datafiles/${saveFileName.value}\_$path");
    List<dynamic> initData = [
      "FileFormat : 1",
      "HWType : OCR",
      "Start Time : ${saveFileName.value}",
      "Intergration Time : ${Get.find<iniController>().integrationTime.value}",
      "Interval : 0"
    ];

    String intergrationColumn = channelNum +
        '\n' +
        initData.join('\n') +
        '\n' +
        "Time" +
        ',' +
        listWavelength.join(',') +
        '\n';

    return file.writeAsString(intergrationColumn);
  }

  void vizDataSave() async {
    Directory('datafiles').create(recursive: true);
    File file = File("./datafiles/WR_VIZ_${saveFileName.value}.csv");
    String csv = timeVal() + ',' + VizCtrl.to.vizYValue.join(',') + '\n';
    await file.writeAsString(csv, mode: FileMode.append);
  }

  Future<void> vizSaveInit() {
    Directory('datafiles').create(recursive: true);
    File file = File("./datafiles/WR_VIZ_${saveFileName.value}.csv");
    List<dynamic> initData = [
      "FileFormat : 2",
      "HWType : VIZ",
      "Start Time : ${saveFileName.value}",
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
    String all = initData.join('\n') + '\n' + init.join(',') + '\n';
    return file.writeAsString(all);
  }
}
