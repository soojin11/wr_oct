import 'dart:async';
import 'dart:io';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wr_ui/model/const/style/pallette.dart';
import 'package:wr_ui/view/chart/oes_chart.dart';

import 'log_screen.dart';

class CSVButton extends StatelessWidget {
  Future<void> updaeteCSV() async {
    Get.find<CsvController>().csvSave();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 30),
        ElevatedButton(
          onPressed: () async {
            await Get.find<CsvController>().csvSaveInit();
            Get.find<CsvController>().fileSave.value = true;
            Get.find<LogListController>().startCsv();
          },
          child: Container(
            width: 200,
            child: Center(
              child: Text(
                "Save Start",
              ),
            ),
          ),
          style: ElevatedButton.styleFrom(
            primary: wrColors.wrPrimary,
          ),
        ),
        SizedBox(height: 30),
        ElevatedButton(
          onPressed: () async {
            Get.find<CsvController>().fileSave.value = false;
            Get.find<LogListController>().stopCsv();
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
            primary: wrColors.wrPrimary,
          ),
        ),
      ],
    );
  }
}

class CsvController extends GetxController {
  static CsvController get to => Get.find();
  RxString path = ''.obs;
  RxBool fileSave = false.obs;
  RxBool inactiveBtn = false.obs;
  RxDouble yVal = 0.0.obs;
  RxList vizYVal = RxList.empty();
  @override
  void onInit() {
    super.onInit();
  }

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
    if (Get.find<CsvController>().fileSave.value) {
      firstData.add(yVal.value);
      Get.find<OesController>().oesData.forEach((v) {
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
    path.value = "./datafiles/$fileName.csv";
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
    Get.find<OesController>().oesData.forEach((v) {
      rangeData.add(v.range);
    });

    String intergrationColumn = initData.join('\n') +
        '\n' +
        "Time" +
        ',' +
        "VIZ_1" +
        ',' +
        rangeData.join(',') +
        '\n';

    return file.writeAsString(intergrationColumn);
  }
}
