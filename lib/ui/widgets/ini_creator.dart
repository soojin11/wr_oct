import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ini/ini.dart';
import 'package:intl/intl.dart';
import 'dart:io';

// import 'package:path_provider/path_provider.dart';

class iniBtn extends StatelessWidget {
  Future<void> updaeteINI() async {
    Get.find<iniControllerWithReactive>().iniSave();
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        await Get.find<iniControllerWithReactive>().iniWriteSave();
        Get.find<iniControllerWithReactive>().fileSave;
      },
      child: Text('to *.ini'),
    );
  }
}

// ////파일저장
class iniControllerWithReactive extends GetxController {
  static iniControllerWithReactive get to => Get.find();
  RxString path = ''.obs;
  RxBool fileSave = false.obs;
  // RxBool ig = false.obs;
  @override
  void onInit() {
    super.onInit();
  }

  Future<File> iniSave() async {
    DateTime current = DateTime.now();
    final String fileName = '${DateFormat('yyyyMMdd_hhmmss').format(current)}';
    print('$fileName');
    List<dynamic> firstData = [];
    List<List<dynamic>> addFirstData = [];
    File file = File(path.value);
    addFirstData.add(firstData);
    // String csv = const ListToCsvConverter().convert(addFirstData) + '\n';
    Config config = new Config.fromStrings(file.readAsLinesSync());
    return file.writeAsString(config.toString());
  }

  Future<File> iniWriteSave() async {
    DateTime current = DateTime.now();
    print("*.ini 로 저장");
    final String fileName = DateFormat('yyyyMMdd-HHmmss').format(current);
    // final String streamDateTime =
    //     DateFormat('yyyy/MM/dd HH:mm:ss').format(current);
    await Directory('inifiles').create();
    path.value = "./inifiles/config_$fileName.ini";
    // String startTime = streamDateTime;
    File file = File(path.value);
    Config config = new Config();
    config.addSection("OES");
    config.set("OES", "IP", '192.168.0.1');
    config.set("OES", "PORT", '9000');
    config.set("OES", "NAME", 'qqq');
    print('파일 경로는?? ${file.path}');
    print("${config.toString()}");
    return file.writeAsString(config.toString());
  }
}
