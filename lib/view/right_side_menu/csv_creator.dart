import 'dart:async';
import 'dart:io';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wr_ui/view/chart/oes_chart.dart';
import 'package:wr_ui/view/right_side_menu/start_stop.dart';

import 'log_screen.dart';

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
                // await controller.csvSaveInit();
                // await controller.SecondcsvSaveInit();
                // await controller.ThirdcsvSaveInit();
                // await controller.FourthcsvSaveInit();
                // await controller.FifthcsvSaveInit();
                // await controller.SixthcsvSaveInit();
                // await controller.SeventhcsvSaveInit();
                // await controller.EightcsvSaveInit();
                // controller.fileSave.value = true;
                // controller.fileSave2.value = true;
                // controller.fileSave3.value = true;
                // controller.fileSave4.value = true;
                // controller.fileSave5.value = true;
                // controller.fileSave6.value = true;
                // controller.fileSave7.value = true;
                // controller.fileSave8.value = true;
                // Get.find<LogListController>().startCsv();
                // controller.inactiveBtn.value = true;
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
  RxString path = ''.obs;
  RxString path2 = ''.obs;
  RxString path3 = ''.obs;
  RxString path4 = ''.obs;
  RxString path5 = ''.obs;
  RxString path6 = ''.obs;
  RxString path7 = ''.obs;
  RxString path8 = ''.obs;

  RxBool fileSave = false.obs;
  RxBool fileSave2 = false.obs;
  RxBool fileSave3 = false.obs;
  RxBool fileSave4 = false.obs;
  RxBool fileSave5 = false.obs;
  RxBool fileSave6 = false.obs;
  RxBool fileSave7 = false.obs;
  RxBool fileSave8 = false.obs;

  RxBool inactiveBtn = false.obs;
  
  //RxInt fileNum = 1.obs;
  List<dynamic> initData = [
    "FileFormat:1",
    "HWType:SPdbUSBm",
    "Start Time : startTime",
    "Intergration Time:",
    "Interval:"
  ];

  String TimeVal() {
    DateTime current = DateTime.now();
    String ms = DateTime.now().millisecondsSinceEpoch.toString();
    int msLength = ms.length;
    int third = int.parse(ms.substring(msLength - 3, msLength));
    String addTime = '${DateFormat('HH:mm:ss').format(current)}.$third';
    return addTime;
  }

  Future<File> csvSave() async {
    File file = File(path.value);
    List<dynamic> firstData = [];
    List<List<dynamic>> addFirstData = [];

    if (Get.find<CsvController>().fileSave.value) {
      firstData.add(TimeVal());
      Get.find<OesController>().oneData.forEach((v) {
        firstData.add(v.y);
      });
    }else
      (print('OES 2번 데이터 이상함'));

    addFirstData.add(firstData);
    String csv = const ListToCsvConverter().convert(addFirstData) + '\n';
    return file.writeAsString(csv, mode: FileMode.append);
  }

  Future<File> csvSaveInit() async {
    DateTime current = DateTime.now();
    final String fileName = DateFormat('yyyyMMdd-HHmmss').format(current);
    await Directory('datafiles').create();
    path.value = "./datafiles/$fileName\_1.csv";
    File file = File(path.value);
    List<double> rangeData1 = [];

    
      Get.find<OesController>().oneData.forEach((v) {
        rangeData1.add(v.x);
      });

      String intergrationColumn = initData.join('\n') +
          '\n' +
          "Time" +
          ',' +
          // "VIZ_1" +
          // ',' +
          rangeData1.join(',') +
          '\n';

      return file.writeAsString(intergrationColumn);
    
  }

  Future<File> SecondcsvSave() async {
    File file2 = File(path2.value);

    List<dynamic> firstData = [];
    List<List<dynamic>> addFirstData = [];
    firstData.add(TimeVal());
    if (Get.find<CsvController>().fileSave2.value) {
      Get.find<OesController>().twoData.forEach((v) {
        firstData.add(v.y);
      });
    } else
      (print('OES 2번 데이터 이상함'));

    addFirstData.add(firstData);
    String csv = const ListToCsvConverter().convert(addFirstData) + '\n';
    return file2.writeAsString(csv, mode: FileMode.append);
  }

  Future<File> SecondcsvSaveInit() async {
    DateTime current = DateTime.now();
    final String fileName = DateFormat('yyyyMMdd-HHmmss').format(current);
    await Directory('datafiles').create();
    path2.value = "./datafiles/$fileName\_2.csv";
    File file2 = File(path2.value);
    List<double> rangeData = [];
    Get.find<OesController>().twoData.forEach((v) {
      rangeData.add(v.x);
    });

    String intergrationColumn = initData.join('\n') +
        '\n' +
        "Time" +
        ',' +
        rangeData.join(',') +
        '\n';

    return file2.writeAsString(intergrationColumn);
  }

  Future<File> ThirdcsvSave() async {
    File file3 = File(path3.value);
    List<dynamic> firstData = [];
    List<List<dynamic>> addFirstData = [];

    firstData.add(TimeVal());
    if (Get.find<CsvController>().fileSave3.value) {
      Get.find<OesController>().threeData.forEach((v) {
        firstData.add(v.y);
      });
    } else
      (print('OES 3번 데이터 이상함'));

    addFirstData.add(firstData);
    String csv = const ListToCsvConverter().convert(addFirstData) + '\n';
    return file3.writeAsString(csv, mode: FileMode.append);
  }

  Future<File> ThirdcsvSaveInit() async {
    DateTime current = DateTime.now();
    final String fileName = DateFormat('yyyyMMdd-HHmmss').format(current);
    await Directory('datafiles').create();
    path3.value = "./datafiles/$fileName\_3.csv";
    File file3 = File(path3.value);
    List<double> rangeData = [];
    Get.find<OesController>().threeData.forEach((v) {
      rangeData.add(v.x);
    });

    String intergrationColumn = initData.join('\n') +
        '\n' +
        "Time" +
        ',' +
        rangeData.join(',') +
        '\n';

    return file3.writeAsString(intergrationColumn);
  }
  Future<File> FourthcsvSave() async {
    File file4 = File(path4.value);
    List<dynamic> firstData = [];
    List<List<dynamic>> addFirstData = [];

    firstData.add(TimeVal());
    if (Get.find<CsvController>().fileSave4.value) {
      Get.find<OesController>().fourData.forEach((v) {
        firstData.add(v.y);
      });
    } else
      (print('OES 4번 데이터 이상함'));

    addFirstData.add(firstData);
    String csv = const ListToCsvConverter().convert(addFirstData) + '\n';
    return file4.writeAsString(csv, mode: FileMode.append);
  }

  Future<File> FourthcsvSaveInit() async {
    DateTime current = DateTime.now();
    final String fileName = DateFormat('yyyyMMdd-HHmmss').format(current);
    await Directory('datafiles').create();
    path4.value = "./datafiles/$fileName\_\4.csv";
    File file4 = File(path4.value);
    List<double> rangeData = [];
    Get.find<OesController>().fourData.forEach((v) {
      rangeData.add(v.x);
    });

    String intergrationColumn = initData.join('\n') +
        '\n' +
        "Time" +
        ',' +
        rangeData.join(',') +
        '\n';

    return file4.writeAsString(intergrationColumn);
  }
  Future<File> FifthcsvSave() async {
    File file5 = File(path5.value);
    List<dynamic> firstData = [];
    List<List<dynamic>> addFirstData = [];

    firstData.add(TimeVal());
    if (Get.find<CsvController>().fileSave5.value) {
      Get.find<OesController>().fiveData.forEach((v) {
        firstData.add(v.y);
      });
    } else
      (print('OES 5번 데이터 이상함'));

    addFirstData.add(firstData);
    String csv = const ListToCsvConverter().convert(addFirstData) + '\n';
    return file5.writeAsString(csv, mode: FileMode.append);
  }

  Future<File> FifthcsvSaveInit() async {
    DateTime current = DateTime.now();
    final String fileName = DateFormat('yyyyMMdd-HHmmss').format(current);
    await Directory('datafiles').create();
    path5.value = "./datafiles/$fileName\_\5.csv";
    File file5 = File(path5.value);
    List<double> rangeData = [];
    Get.find<OesController>().fiveData.forEach((v) {
      rangeData.add(v.x);
    });

    String intergrationColumn = initData.join('\n') +
        '\n' +
        "Time" +
        ',' +
        rangeData.join(',') +
        '\n';

    return file5.writeAsString(intergrationColumn);
  }
  Future<File> SixthcsvSave() async {
    File file6 = File(path6.value);
    List<dynamic> firstData = [];
    List<List<dynamic>> addFirstData = [];

    firstData.add(TimeVal());
    if (Get.find<CsvController>().fileSave6.value) {
      Get.find<OesController>().sixData.forEach((v) {
        firstData.add(v.y);
      });
    } else
      (print('OES 6번 데이터 이상함'));

    addFirstData.add(firstData);
    String csv = const ListToCsvConverter().convert(addFirstData) + '\n';
    return file6.writeAsString(csv, mode: FileMode.append);
  }

  Future<File> SixthcsvSaveInit() async {
    DateTime current = DateTime.now();
    final String fileName = DateFormat('yyyyMMdd-HHmmss').format(current);
    await Directory('datafiles').create();
    path6.value = "./datafiles/$fileName\_\6.csv";
    File file6 = File(path6.value);
    List<double> rangeData = [];
    Get.find<OesController>().sixData.forEach((v) {
      rangeData.add(v.x);
    });

    String intergrationColumn = initData.join('\n') +
        '\n' +
        "Time" +
        ',' +
        rangeData.join(',') +
        '\n';

    return file6.writeAsString(intergrationColumn);
  }
  Future<File> SeventhcsvSave() async {
    File file7 = File(path7.value);
    List<dynamic> firstData = [];
    List<List<dynamic>> addFirstData = [];

    firstData.add(TimeVal());
    if (Get.find<CsvController>().fileSave7.value) {
      Get.find<OesController>().sevenData.forEach((v) {
        firstData.add(v.y);
      });
    } else
      (print('OES 7번 데이터 이상함'));

    addFirstData.add(firstData);
    String csv = const ListToCsvConverter().convert(addFirstData) + '\n';
    return file7.writeAsString(csv, mode: FileMode.append);
  }

  Future<File> SeventhcsvSaveInit() async {
    DateTime current = DateTime.now();
    final String fileName = DateFormat('yyyyMMdd-HHmmss').format(current);
    await Directory('datafiles').create();
    path7.value = "./datafiles/$fileName\_\7.csv";
    File file7 = File(path7.value);
    List<double> rangeData = [];
    Get.find<OesController>().sevenData.forEach((v) {
      rangeData.add(v.x);
    });

    String intergrationColumn = initData.join('\n') +
        '\n' +
        "Time" +
        ',' +
        rangeData.join(',') +
        '\n';

    return file7.writeAsString(intergrationColumn);
  }
  Future<File> EightcsvSave() async {
    File file8 = File(path8.value);
    List<dynamic> firstData = [];
    List<List<dynamic>> addFirstData = [];

    firstData.add(TimeVal());
    if (Get.find<CsvController>().fileSave8.value) {
      Get.find<OesController>().eightData.forEach((v) {
        firstData.add(v.y);
      });
    } else
      (print('OES 8번 데이터 이상함'));

    addFirstData.add(firstData);
    String csv = const ListToCsvConverter().convert(addFirstData) + '\n';
    return file8.writeAsString(csv, mode: FileMode.append);
  }

  Future<File> EightcsvSaveInit() async {
    DateTime current = DateTime.now();
    final String fileName = DateFormat('yyyyMMdd-HHmmss').format(current);
    await Directory('datafiles').create();
    path8.value = "./datafiles/$fileName\_\8.csv";
    File file8 = File(path8.value);
    List<double> rangeData = [];
    Get.find<OesController>().sevenData.forEach((v) {
      rangeData.add(v.x);
    });

    String intergrationColumn = initData.join('\n') +
        '\n' +
        "Time" +
        ',' +
        rangeData.join(',') +
        '\n';

    return file8.writeAsString(intergrationColumn);
  }
  
}
void startSaveBtn() async {
  await Get.find<CsvController>().csvSaveInit();
  await Get.find<CsvController>().SecondcsvSaveInit();
  await Get.find<CsvController>().ThirdcsvSaveInit();
  await Get.find<CsvController>().FourthcsvSaveInit();
  await Get.find<CsvController>().FifthcsvSaveInit();
  await Get.find<CsvController>().SixthcsvSaveInit();
  await Get.find<CsvController>().SeventhcsvSaveInit();
  await Get.find<CsvController>().EightcsvSaveInit();
  Get.find<CsvController>().fileSave.value = true;
  Get.find<CsvController>().fileSave2.value = true;
  Get.find<CsvController>().fileSave3.value = true;
  Get.find<CsvController>().fileSave4.value = true;
  Get.find<CsvController>().fileSave5.value = true;
  Get.find<CsvController>().fileSave6.value = true;
  Get.find<CsvController>().fileSave7.value = true;
  Get.find<CsvController>().fileSave8.value = true;
  Get.find<LogListController>().startCsv();
  Get.find<CsvController>().inactiveBtn.value = true;
}