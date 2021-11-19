import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ini/ini.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

import 'package:wr_ui/model/pallette.dart';

// class iniBtn extends StatelessWidget {
//   Future<void> updaeteINI() async {
//     Get.find<iniControllerWithReactive>().iniSave();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//       onPressed: () async {
//         await Get.find<iniControllerWithReactive>().iniWriteSave();
//         Get.find<iniControllerWithReactive>().fileSave;
//       },
//       child: Text('Ini',
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//           )),
//       style: ElevatedButton.styleFrom(primary: wrColors.wrPrimary),
//     );
//   }
// }

// ////파일저장
class doConfigController extends GetxController {
  static doConfigController get to => Get.find();
  int index = 0;
  RxString path = ''.obs;
  RxBool fileSave = false.obs;
  String iniData = '';
  Config config = new Config();
  // RxBool ig = false.obs;
  @override
  void onInit() {
    super.onInit();
  }

  Future<File> iniSave() async {
    DateTime current = DateTime.now();
    final String fileName = '${DateFormat('yyyyMMdd_hhmmss').format(current)}';
    print('$fileName');
    List<dynamic> iniData = [];
    List<List<dynamic>> addiniData = [];
    File file = File(path.value);
    addiniData.add(iniData);
    // String csv = const ListToCsvConverter().convert(addiniData) + '\n';
    Config config = new Config.fromStrings(file.readAsLinesSync());
    return file.writeAsString(config.toString(), mode: FileMode.append);
  }

//////////////////////////////ini write
  Future<File> iniWriteSave() async {
    print("ini생성");

    final String fileName = 'FreqAI';
    await Directory('inifiles').create();
    path.value = "./inifiles/$fileName.ini";
    // String startTime = streamDateTime;
    File file = File(path.value);

    // Config config = new Config();
    // print('컨피그 디폴트가뭐지..??  1${config.defaults()["DEFAULTS"]}');
    if (config.hasSection('DEFAULTS')) {
      print('컨피그가 존재');
    } else {
      config.addSection("DEFAULTS");
      config.set("DEFAULTS", "IP", "OES");
      config.set("DEFAULTS", "PORT", '9000');
      config.set("DEFAULTS", "NAME", 'qqq');
    }
    if (config.hasSection('SEC1')) {
      print('컨피그존재');
    } else {
      ///////////////////
      config.addSection('SEC1');
      config.set('SEC1', "IP", "OES");
      config.set('SEC1', "PORT", '9000');
      config.set('SEC1', "NAME", 'qqq');
      ////////////////////

    }
    print('컨피그 디폴트가뭐지..??   2:  ${config.items('DEFAULTS')}');
    print('컨피그 섹션이 뭐지..??   2:  ${config.sections()}');
    print('name이 DEFAULTS option이 IP인 VALUE 출력');
    print('${config.get('DEFAULTS', 'IP')}');
    print('name이 DEFAULTS option이 PORT인 VALUE 출력');
    print('${config.get('DEFAULTS', 'PORT')}');
    print('name이 DEFAULTS option이 NAME인 VALUE 출력');
    print('${config.get('DEFAULTS', 'NAME')}');
    // Config iniData = config;
    // print('iniData:\n' '$iniData');
    // iniData.addAll(Get.find<iniControllerWithReactive>().iniList);

    print('파일 경로는?? ${file.path}');
    print('config: \n' '${config.toString()}');
    print('iniData: \n' '$iniData');
    print('------------------------------------------------------');
    return file.writeAsString(config.toString());
  }

//////////////////////////////ini write
  ///
/////////////////////////////////ini read
  void iniReader() {
    Get.put(doConfigController()).iniWriteSave();
    // print('ini reader안의 iniData값:' + '${configController.config.get(name, option)}');
    print('윗줄이reader안에 뿌려준 데이터');
    config.sections();

// List options within a section
    config.options("default");
    config.options("section");
    config.hasSection("section");

// List of key value pairs for a section.
    config.items("section");

// Read specific options.
    config.get("section", "option");
    config.hasOption("section", "option");
  }

/////////////////////////////////ini read
  void allocateValueToSetting() async {}
}
