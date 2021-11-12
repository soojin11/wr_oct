import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ini/ini.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

import 'package:wr_ui/model/const/style/pallette.dart';

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
      child: Text('Ini',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          )),
      style: ElevatedButton.styleFrom(primary: wrColors.wrPrimary),
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

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localIniFile async {
    final path = await _localPath;

    return File('$path');
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
    print("ini생성");
    final String fileName = 'FreqAI';
    await Directory('inifiles').create();
    path.value = "./inifiles/$fileName.ini";
    // String startTime = streamDateTime;
    File file = File(path.value);
    Config config = new Config();
    config.addSection("OES");
    config.set("OES", "IP", "OES");
    config.set("OES", "PORT", '9000');
    config.set("OES", "NAME", 'qqq');
    print('파일 경로는?? ${file.path}');
    print("${config.toString()}");
    print('------------------------------------------------------');
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
