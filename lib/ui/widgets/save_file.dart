import 'dart:io';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'log_save.dart';
import 'log_screen.dart';

class CSVButton extends StatelessWidget {
  Future<void> updaeteCSV() async {
    Get.find<ControllerWithReactive>().csvSave();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ElevatedButton(
          onPressed: () async {
            await Get.find<ControllerWithReactive>().csvSaveInit();
            Get.find<LogListController>().clickedCsv();
            Get.find<ControllerWithReactive>().fileSave.value = true;
          },
          child: Text(
            "Start Save",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          style: ElevatedButton.styleFrom(primary: Colors.blueGrey[700]),
        ),
        ElevatedButton(
          onPressed: () async {
            await Get.find<ControllerWithReactive>().csvSaveInit();
            Get.find<LogListController>().clickedCsv();
            Get.find<ControllerWithReactive>().fileSave.value = true;
            Get.find<LogController>().loglist.add(
                '${DateFormat('mm분 ss초').format(DateTime.now())} Save Data File');
            Get.find<LogController>().logSaveInit();
            Get.find<LogController>().fileSave.value = true;
          },
          child: Text(
            "Stop Stop",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          style: ElevatedButton.styleFrom(primary: Colors.blueGrey[700]),
        ),
      ],
    );
  }
}

class ControllerWithReactive extends GetxController {
  static ControllerWithReactive get to => Get.find();
  RxString path = ''.obs;
  RxBool fileSave = false.obs;
  RxBool ig = false.obs;
  @override
  void onInit() {
    super.onInit();
  }

  Future<File> csvSave() async {
    DateTime current = DateTime.now();
    final String fileName = '${DateFormat('yyyyMMdd_hhmmss').format(current)}';
    print('$fileName');
    List<dynamic> firstData = [];
    List<List<dynamic>> addFirstData = [];
    File file = File(path.value);
    addFirstData.add(firstData);
    String csv = const ListToCsvConverter().convert(addFirstData) + '\n';
    return file.writeAsString(csv, mode: FileMode.append);
  }

  Future<File> csvSaveInit() async {
    DateTime current = DateTime.now();
    print("csv save");
    final String fileName = DateFormat('yyyyMMdd-HHmmss').format(current);
    final String streamDateTime =
        DateFormat('yyyy/MM/dd HH:mm:ss').format(current);
    await Directory('datafiles').create();
    path.value = "./datafiles/$fileName.csv";
    String startTime = streamDateTime;
    File file = File(path.value);
    String firstRow = "FileFormat:1";
    String secondRow = "HWType:SPdbUSBm";
    String thirdRow = "Start Time : $startTime";
    String fourthRowFirst = "Intergration Time:";
    String fourthRowSecond = "Interval:";
    print("exists in");
    String intergrationColumn = firstRow +
        '\n' +
        secondRow +
        '\n' +
        thirdRow +
        '\n' +
        fourthRowFirst +
        ',' +
        fourthRowSecond +
        // ',' +
        // fourthRowThird +
        '\n' +
        "Time" +
        ',' +
        '\n';
    return file.writeAsString(intergrationColumn);
  }
}
