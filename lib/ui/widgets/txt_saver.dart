import 'dart:io';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CSVButton extends StatelessWidget {
  Future<void> updaeteTXT() async {
    Get.find<txtControllerWithReactive>().txtSave();
  }

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () async {
        await Get.find<txtControllerWithReactive>().txtSaveInit();
        Get.find<txtControllerWithReactive>().fileSave.value = true;
      },
      child: Text(
        "Save to .txt",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}

class txtControllerWithReactive extends GetxController {
  static txtControllerWithReactive get to => Get.find();
  RxString path = ''.obs;
  RxBool fileSave = false.obs;
  RxBool ig = false.obs;
  @override
  void onInit() {
    super.onInit();
  }

  Future<File> txtSave() async {
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

  Future<File> txtSaveInit() async {
    DateTime current = DateTime.now();
    print("txt저장");
    final String fileName = DateFormat('yyyyMMdd-HHmmss').format(current);

    await Directory('txtfiles').create();
    path.value = "./txtfiles/$fileName.txt";
    File file = File(path.value);
    String firstRow = "1";
    String secondRow = "2";
    String thirdRow = "3";
    String fourthRowFirst = "4";
    print("파일저장 여기됨");
    String intergrationColumn =
        firstRow + '\n' + secondRow + '\n' + thirdRow + '\n' + fourthRowFirst;

    // ',' +
    // fourthRowThird +

    return file.writeAsString(intergrationColumn);
  }
}
