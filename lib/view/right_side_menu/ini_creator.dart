import 'package:get/get.dart';
import 'package:ini/ini.dart';
import 'dart:io';

import 'package:wr_ui/view/chart/oes_chart.dart';

//////////////////////////원래있던거
// ////파일저장
// class iniControllerWithReactive extends GetxController {
//   static iniControllerWithReactive get to => Get.find();
//   RxString path = ''.obs;
//   RxBool fileSave = false.obs;

//   // RxBool ig = false.obs;
//   @override
//   void onInit() {
//     super.onInit();
//   }

//   Future<File> get _wrFile async {
//     final String fileName = 'FreqAI';
//     await Directory('inifiles').create();
//     path.value = "./inifiles/$fileName.ini";
//     // String startTime = streamDateTime;
//     File file = File(path.value);
//     print('wrFile의 경로는??$file');
//     return file;
//     // final path = await _localPath;
//     // print('$path');
//     // return File(path);
//   }
//   /////경로

// Future<File> Readini() async {
//   print('ini read start');
//   File file = File(path.value);
//   Get.find<iniControllerWithReactive>().iniWriteSave();
//   return file
//       .readAsLines()
//       .then((lines) => new Config.fromStrings(lines))
//       .then((Config ini) {
//     //수행할것.
//     print('컨피그 read 결과물 : ${ini}');
//     return file;
//   });

// }

//   Future<File> iniSave() async {
//     DateTime current = DateTime.now();
//     final String fileName = '${DateFormat('yyyyMMdd_hhmmss').format(current)}';
//     print('$fileName');
//     List<dynamic> firstData = [];
//     List<List<dynamic>> addFirstData = [];
//     File file = File(path.value);
//     addFirstData.add(firstData);
//     // String csv = const ListToCsvConverter().convert(addFirstData) + '\n';
//     Config ini = new Config.fromStrings(file.readAsLinesSync());
//     return file.writeAsString(ini.toString());
//   }

//   Future<File> iniWriteSave() async {
//     print("ini file create");
//     final String fileName = 'FreqAI';
//     await Directory('inifiles').create();
//     path.value = "./inifiles/$fileName.ini";
//     // String startTime = streamDateTime;
//     File file = File(path.value);
//     ////////////////섹션추가
//     Config ini = new Config();

//     ini.addSection("OES");
//     ini.set("OES", "IP", "OES");
//     ini.set("OES", "PORT", '9000');
//     ini.set("OES", "NAME", 'qqq');

//     ini.addSection('section');
//     ini.set('section', 'deviceSimulation', '1');
//     ini.set('section', 'exposureTime', '0');
//     ini.set('section', 'delayTime', '0');
//     ////////////////섹션추가

//     print('파일 경로는?? ${file.path}');
//     print("${ini.toString()}");
//     print('------------------------------------------------------');

//     return file.writeAsString(ini.toString());
//   }

// }

//////////////////////////원래있던거

//////////////////////////테스트
class iniControllerWithReactive extends GetxController {
  static iniControllerWithReactive get to => Get.find();

  /////////파일쓰기
  RxString path = ''.obs;
  late Config ini;
  late File file;
  RxInt deviceSimulation = 0.obs;

  @override
  void onInit() {
    super.onInit();
  }

  Future<File> _iniPath() async {
    final String fileName = 'FreqAI';
    await Directory('inifiles').create();
    path.value = "./inifiles/$fileName.ini";
    // String startTime = streamDateTime;
    File file = File(path.value);
    print('wrFile의 경로는??$file');
    return file;
  }

  /////////파일쓰기

  ////////read
  Future Readini() async {
    print('ini read start');
    try {
      final file = await _iniPath();
      print('ReadIni함수에서 file read 한것 : $file');
      var content = await file.readAsLines();
      var a = content.toString();
      print('content?????? : ${a}');
      return content;
    } catch (err) {
      print('ini파일 못읽어옴!!$err');
      return '';
    }

    //     .readAsLines()
    //     .then((lines) => new Config.fromStrings(lines))
    //     .then((Config ini) {
    //   //수행할것.
    //   print('컨피그 read 결과물 : ${ini}');
    //   return file;
    // });
  }

  ////////read
  ///////////////////섹션추가

  Future<dynamic> doConfigThings() async {
    late Config ini = new Config();

    ini.defaults()['defaults'];
    if (await ini.hasSection('OES')) {
      print('OES 섹션 존재.');
    } else {
      print('OES섹션 없으므로, 추가');
      ini.addSection("OES");
      ini.set("OES", "IP", "OES");
      ini.set("OES", "PORT", '9000');
      ini.set("OES", "NAME", 'qqq');
    }
    if (await ini.hasSection('section')) {
      print('section 섹션 존재.');
    } else {
      print('section 섹션 없으므로, 추가');
      ini.addSection('section');

      Get.find<OesController>().inactiveBtn.value
          ? ini.set(
              'section',
              'option',
              Get.find<iniControllerWithReactive>()
                  .deviceSimulation
                  .value
                  .toString())
          : ini.set(
              'section',
              'option',
              Get.find<iniControllerWithReactive>()
                  .deviceSimulation
                  .value
                  .toString());
      ini.set('section', 'exposureTime', '0');
      ini.set('section', 'delayTime', '0');
    }
    if (await ini.hasSection('new')) {
      print('section 섹션 존재.');
    } else {
      print('section 섹션 없으므로, 추가');
      ini.addSection('new');
      ini.set('new', 'newop1', '1');
      ini.set('new', 'newop2', '0');
      ini.set('new', 'newop3', '0');
    }

    print('${ini.get('new', 'newop1')}');

    Config configRes = ini;
    print('configRes????$configRes');
    return configRes;
  }

  ////////////////섹션추가
  ////////write
  Future writeIniFile() async {
    final file = await _iniPath();
    print("ini file create");

    Config configresult = await doConfigThings();
    print('configresult : $configresult');
    return file.writeAsString(configresult.toString(),
        mode: FileMode.writeOnly);
  }
  ////////write
  ////////write out
  ////////write out
}
//////////////////////////테스트
