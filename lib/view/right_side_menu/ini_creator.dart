import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ini/ini.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import 'package:wr_ui/model/const/style/pallette.dart';

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

  Future<File> get _wrFile async {
    final String fileName = 'FreqAI';
    await Directory('inifiles').create();
    path.value = "./inifiles/$fileName.ini";
    // String startTime = streamDateTime;
    File file = File(path.value);
    print('wrFile의 경로는??$file');
    return file;
    // final path = await _localPath;
    // print('$path');
    // return File(path);
  }
  /////경로

  Future Readini() async {
    print('ini read start');
    try {
      final file = await _wrFile;
      print('Readini에서 읽는 경로??${file}');
      String content = await file.readAsString();
      print('ini 읽음,content: $content');
      return content;
    } catch (e) {
      return print('ini읽기 실패');
    }
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
    print("ini file create");
    final String fileName = 'FreqAI';
    await Directory('inifiles').create();
    path.value = "./inifiles/$fileName.ini";
    // String startTime = streamDateTime;
    File file = File(path.value);
    ////////////////섹션추가
    Config config = new Config();

    config.addSection("OES");
    config.set("OES", "IP", "OES");
    config.set("OES", "PORT", '9000');
    config.set("OES", "NAME", 'qqq');

    config.addSection('DeviceSetting');
    config.set('DeviceSetting', 'deviceSimulation', '1');
    config.set('DeviceSetting', 'exposureTime', '0');
    config.set('DeviceSetting', 'delayTime', '0');
    ////////////////섹션추가

    print('파일 경로는?? ${file.path}');
    print("${config.toString()}");
    print('------------------------------------------------------');
    // runStatus() {
    //   config.hasOption('DeviceSetting', 'deviceSimulation');
    //   print(
    //       'run status?????????${config.hasOption('DeviceSetting', 'deviceSimulation')}');
    // }

    return file.writeAsString(config.toString());
  }

//   Future<String> get _localPath async {
//     final directory = await getApplicationDocumentsDirectory();
//     return directory.path;
//   }

//   Future<File> get _localIniFile async {
//     final path = await _localPath;
//     return File('$path/FreqAI.ini');
//   }

//   Future readIni() async {
//     final path = await _localIniFile;
//     if (File('$path').exists() == true) {
//       _readIni();
//     } else {
//       print(path.toString() + '파일이 없음');
//     }
//   }

//   _readIni() async {
//     var file = await _localIniFile;
//     Config config = new Config.fromStrings(file.readAsLinesSync());
//     print(config);
//   }
// }

}
