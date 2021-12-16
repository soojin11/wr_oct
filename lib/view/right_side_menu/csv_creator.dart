import 'dart:async';
import 'dart:io';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wr_ui/view/chart/oes_chart.dart';
import 'package:wr_ui/view/right_side_menu/save_ini.dart';
import 'log_screen.dart';

startSaveBtn() async {
  for (var i = 0; i < Get.find<iniController>().OES_Count.value; i++) {
    Get.find<CsvController>().csvFormInit(
        path: "_${i + 1}.csv", channelNum: 'channelNum : ${i + 1}');
  }

  Get.find<CsvController>().fileSave.value = true;
  Get.find<LogListController>().startCsv();
  Get.find<CsvController>().inactiveBtn.value = true;
}

class CSVButton extends GetView<CsvController> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 30),
        Obx(() => IgnorePointer(
            ignoring: controller.inactiveBtn.value,
            child: ElevatedButton(
              onPressed: () async {
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
  RxBool fileSave = false.obs;
  RxBool inactiveBtn = false.obs;
  RxList<String> path = RxList.empty();
  //late Rx<DateTime> current;
  RxString saveFileName = ''.obs;
  String fileName() {
    DateTime current = DateTime.now();
    String fileName = DateFormat('yyyyMMdd-HHmmss').format(current).toString();
    return fileName;
  }

  //RxInt fileNum = 1.obs;
  List<dynamic> initData = [
    "FileFormat:1",
    "HWType:SPdbUSBm",
    "Start Time : ${screenTime()}",
    "Intergration Time: ${Get.find<iniController>().exposureTime.value}",
    "Interval: 0"
  ];

  String timeVal() {
    DateTime current = DateTime.now();
    String ms = DateTime.now().millisecondsSinceEpoch.toString();
    int msLength = ms.length;
    int third = int.parse(ms.substring(msLength - 3, msLength));
    String addTime = '${DateFormat('HH:mm:ss').format(current)}.$third';
    return addTime;
  }

  void csvForm({required String path, required List<dynamic> data}) {
    //DateTime current = DateTime.now();
    //final String fileName = DateFormat('yyyyMMdd-HHmmss').format(current);
    Directory('datafiles').create(recursive: true);
    File file = File("./datafiles/${saveFileName.value}\_$path");
    List<List<dynamic>> addData = [];
    addData.add(data);
    List<dynamic> time = [];
    time.add(timeVal());
    String timeee = time.join('\n');
    String csv = const ListToCsvConverter().convert(addData) + '\n';
    file.writeAsString(timeee + csv, mode: FileMode.append);
  }

  Future<void> csvFormInit({required String path, required String channelNum}) {
    // DateTime current = DateTime.now();
    //final String fileName = DateFormat('yyyyMMdd-HHmmss').format(current);

    Directory('datafiles').create();
    File file = File("./datafiles/${saveFileName.value}\_$path");
    List<double> rangeData = [];
    for (var i = 0; i < Get.find<iniController>().OES_Count.value; i++) {
      Get.find<OesController>().oesData[i].forEach((e) {
        rangeData.add(e.x);
      });
    }
    String intergrationColumn = channelNum +
        '\n' +
        initData.join('\n') +
        '\n' +
        "Time" +
        ',' +
        rangeData.join(',') +
        '\n';

    return file.writeAsString(intergrationColumn);
  }
}






  // Future<File> csvSave() async {
  //   File file = File(path.value);
  //   List<dynamic> firstData = [];
  //   List<List<dynamic>> addFirstData = [];

  //   if (Get.find<CsvController>().fileSave.value) {
  //     firstData.add(TimeVal());
  //     // Get.find<OesController>().chartData[0].forEach((e) {
  //     //   firstData.add(e.y);
  //     // });
  //     Get.find<OesController>().oneData.forEach((v) {
  //       firstData.add(v.y);
  //     });
  //   } else
  //     (print('OES 1번 데이터 이상함'));

  //   addFirstData.add(firstData);
  //   String csv = const ListToCsvConverter().convert(addFirstData) + '\n';
  //   return file.writeAsString(csv, mode: FileMode.append);
  // }

  // Future<File> csvSaveInit() async {
  //   DateTime current = DateTime.now();
  //   final String fileName = DateFormat('yyyyMMdd-HHmmss').format(current);
  //   await Directory('datafiles').create();
  //   path.value = "./datafiles/$fileName\_1.csv";
  //   File file = File(path.value);
  //   List<double> rangeData1 = [];

  //   Get.find<OesController>().oneData.forEach((v) {
  //     rangeData1.add(v.x);
  //   });

  //   String intergrationColumn = initData.join('\n') +
  //       '\n' +
  //       "Time" +
  //       ',' +
  //       // "VIZ_1" +
  //       // ',' +
  //       rangeData1.join(',') +
  //       '\n';

  //   return file.writeAsString(intergrationColumn);
  // }

  // Future<File> SecondcsvSave() async {
  //   File file2 = File(path2.value);

  //   List<dynamic> firstData = [];
  //   List<List<dynamic>> addFirstData = [];
  //   firstData.add(TimeVal());
  //   if (Get.find<CsvController>().fileSave2.value) {
  //     Get.find<OesController>().twoData.forEach((v) {
  //       firstData.add(v.y);
  //     });
  //   } else
  //     (print('OES 2번 데이터 이상함'));

  //   addFirstData.add(firstData);
  //   String csv = const ListToCsvConverter().convert(addFirstData) + '\n';
  //   return file2.writeAsString(csv, mode: FileMode.append);
  // }

  // Future<File> SecondcsvSaveInit() async {
  //   DateTime current = DateTime.now();
  //   final String fileName = DateFormat('yyyyMMdd-HHmmss').format(current);
  //   await Directory('datafiles').create();
  //   path2.value = "./datafiles/$fileName\_2.csv";
  //   File file2 = File(path2.value);
  //   List<double> rangeData = [];
  //   Get.find<OesController>().twoData.forEach((v) {
  //     rangeData.add(v.x);
  //   });

  //   String intergrationColumn =
  //       initData.join('\n') + '\n' + "Time" + ',' + rangeData.join(',') + '\n';

  //   return file2.writeAsString(intergrationColumn);
  // }

//}