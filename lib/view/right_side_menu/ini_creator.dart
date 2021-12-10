import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ini/ini.dart';
import 'package:wr_ui/setting_content.dart';
import 'package:wr_ui/view/appbar/actions/setting/setting_menu_final.dart';
import 'package:wr_ui/view/appbar/leading/run_error_status_mark.dart';
import 'dart:io';

import 'package:wr_ui/view/chart/oes_chart.dart';
import 'package:wr_ui/view/right_side_menu/save_ini.dart';
import 'package:wr_ui/view/right_side_menu/start_stop.dart';

class iniControllerWithReactive extends GetxController {
  static iniControllerWithReactive get to => Get.find();

  /////////파일쓰기
  RxString path = ''.obs;
  File? file;
  RxInt OES_Simulation = 1.obs;
  RxInt OES_Count = 8.obs;
  RxBool bOESConnect = false.obs;
  RxInt VI_Simulation = 1.obs;
  RxInt VI_Count = 1.obs;
  RxBool bVIConnect = true.obs;
  RxString DataPath = './datafiles/'.obs;
  RxString SaveFromStartSignal = '1'.obs;
  RxString measureStartAtProgStart = '1'.obs;
  RxString ExposureTime = '100'.obs;
  RxString DelayTime = '200'.obs;
  RxString IntegrationTime = '200'.obs;
  RxString MOSChannel = '0'.obs;
  RxList<String> channelFlow = ['1', '3', '5', '7', '8', '6', '4', '2'].obs;
  RxString a = '0'.obs;
  RxString b = '2'.obs;
  Rx<Color> Series_Color_001 = Color(0xFFEF5350).obs;
  Rx<Color> Series_Color_002 = Color(0xFFFFA726).obs;
  Rx<Color> Series_Color_003 = Color(0xFFFFD54F).obs;
  Rx<Color> Series_Color_004 = Color(0xFF81C784).obs;
  Rx<Color> Series_Color_005 = Color(0xFF81C784).obs;
  Rx<Color> Series_Color_006 = Color(0xFF64B5F6).obs;
  Rx<Color> Series_Color_007 = Color(0xFF0D47A1).obs;
  Rx<Color> Series_Color_008 = Color(0xFFBA68C8).obs;

  //////////프로그램 구동 시 자동시작
  // RxString measureStartAtProgStart = '1'.obs;
  // RxInt OESsimulation = 0.obs;
  // RxInt OESchannelCount = 8.obs;
  // RxInt currentDirectoryAutoSave = 1.obs;
  // RxString CSVsavePath = './datafiles/'.obs;
  // RxInt saveFromStartSignal = 0.obs;
  // RxDouble dataViewStartFromMoreValueOES = 0.0.obs;
  // RxString exposureTime = '100'.obs;
  // RxInt delayTime = 0.obs;
  //////////프로그램 구동 시 자동시작
//   @override
//   void onInit() {
//     super.onInit();
//     ever(OES_Simulation, (m) => writeIni());
//     ever(OES_Count, (m) => writeIni());
//     ever(bOESConnect, (m) => writeIni());
//     ever(VI_Simulation, (m) => writeIni());
//     ever(VI_Count, (m) => writeIni());
//     ever(bVIConnect, (m) => writeIni());
//     ever(DataPath, (m) => writeIni());
//     ever(SaveFromStartSignal, (m) => writeIni());
//     ever(measureStartAtProgStart, (m) => writeIni());
//     ever(ExposureTime, (m) => writeIni());
//     ever(DelayTime, (m) => writeIni());
//     ever(IntegrationTime, (m) => writeIni());
//     ever(MOSChannel, (m) => writeIni());
//     ever(channelFlow, (m) => writeIni());
//     ever(a, (m) => writeIni());
//     ever(b, (m) => writeIni());
//     ever(Series_Color_001, (m) => writeIni());
//     ever(Series_Color_002, (m) => writeIni());
//     ever(Series_Color_003, (m) => writeIni());
//     ever(Series_Color_004, (m) => writeIni());
//     ever(Series_Color_005, (m) => writeIni());
//   }

//   Future<File> get iniPath async {
//     final String fileName = 'FreqAI';
//     await Directory('inifiles').create(recursive: true);
//     path.value = "./inifiles/$fileName.ini";
//     // String startTime = streamDateTime;
//     File file = File(path.value);
//     print('wrFile의 경로는??$file');
// //     String aaa = '''OES_Simulation = 1
// // OES_Count = 1
// // bOESConnect = false
// // VI_Simulation = 1
// // VI_Count = 1
// // bVIConnect = true
// // DataPath = ./datafiles/
// // SaveFromStartSignal = 1
// // measureStartAtProgStart = 1''';
// //     return file.writeAsString(aaa);

//     return file;
//   }

//   /////////파일쓰기

//   ////////read
//   ///
//   ///
//   Future readIni() async {
//     print('===============ini read start================');

//     _readIni();
//   }

//   _readIni() async {
//     var file = await iniPath;

//     Config c = new Config.fromStrings(file.readAsLinesSync());

//     print('new : ${c.toString()}');
//     print('default=>"${c.defaults()['dsd' 'dsd']}"');
//     print('section=>"${c.sections()}');
//     print('items=>"${c.items('deviceSettings')}"');
//     print('get?=>"${c.get('deviceSettings', 'measureStartAtProgStart')}"');
//     print('===============ini read end=============');
//     return c;
//   }

//   Future writeIni() async {
//     print('===============write ini start============');
//     final file = await iniPath;
//     Config c = new Config();

//     c.addSection('Common');
//     c.set('Common', 'OES_Simulation',
//         Get.find<iniControllerWithReactive>().OES_Simulation.value.toString());

//     c.set('Common', 'OES_Count',
//         Get.find<iniControllerWithReactive>().OES_Count.value.toString());
//     c.set('Common', 'bOESConnect',
//         Get.find<iniControllerWithReactive>().bOESConnect.value.toString());
//     c.set('Common', 'VI_Simulation',
//         Get.find<iniControllerWithReactive>().VI_Simulation.value.toString());
//     c.set('Common', 'VI_Count',
//         Get.find<iniControllerWithReactive>().VI_Count.value.toString());
//     c.set('Common', 'bVIConnect',
//         Get.find<iniControllerWithReactive>().bVIConnect.value.toString());
//     c.set('Common', 'DataPath',
//         Get.find<iniControllerWithReactive>().DataPath.value);
//     c.set('Common', 'SaveFromStartSignal ',
//         Get.find<iniControllerWithReactive>().SaveFromStartSignal.value);
//     c.set('Common', 'measureStartAtProgStart ',
//         Get.find<iniControllerWithReactive>().measureStartAtProgStart.value);
//     ///////////////////////
//     c.addSection('OES_Setting');
//     c.set('OES_Setting', 'ExposureTime',
//         Get.find<iniController>().exposureTime.value);
//     c.set('OES_Setting', 'DelayTime',
//         Get.find<iniControllerWithReactive>().DelayTime.value);
//     c.set('OES_Setting', 'IntegrationTime',
//         Get.find<iniControllerWithReactive>().IntegrationTime.value);
//     c.set('OES_Setting', 'MOSChannel',
//         Get.find<iniControllerWithReactive>().MOSChannel.value);
//     c.set('OES_Setting', 'channelFlow',
//         Get.find<iniControllerWithReactive>().channelFlow.string);
//     ///////////////
//     c.addSection('VI_Setting');
//     c.set('VI_Setting', 'a', Get.find<iniControllerWithReactive>().a.value);
//     c.set('VI_Setting', 'b', Get.find<iniControllerWithReactive>().b.value);
//     //////////

//     c.addSection('OES_Chart_Setting');
//     c.set(
//         'OES_Chart_Setting',
//         'Series_Color_001',
//         Get.find<iniControllerWithReactive>()
//             .Series_Color_001
//             .value
//             .toString());
//     c.set(
//         'OES_Chart_Setting',
//         'Series_Color_002',
//         Get.find<iniControllerWithReactive>()
//             .Series_Color_002
//             .value
//             .toString());
//     c.set(
//         'OES_Chart_Setting',
//         'Series_Color_003',
//         Get.find<iniControllerWithReactive>()
//             .Series_Color_003
//             .value
//             .toString());
//     c.set(
//         'OES_Chart_Setting',
//         'Series_Color_004',
//         Get.find<iniControllerWithReactive>()
//             .Series_Color_004
//             .value
//             .toString());
//     c.set(
//         'OES_Chart_Setting',
//         'Series_Color_005',
//         Get.find<iniControllerWithReactive>()
//             .Series_Color_005
//             .value
//             .toString());
//     c.set(
//         'OES_Chart_Setting',
//         'Series_Color_006',
//         Get.find<iniControllerWithReactive>()
//             .Series_Color_006
//             .value
//             .toString());
//     c.set(
//         'OES_Chart_Setting',
//         'Series_Color_007',
//         Get.find<iniControllerWithReactive>()
//             .Series_Color_007
//             .value
//             .toString());
//     c.set(
//         'OES_Chart_Setting',
//         'Series_Color_008',
//         Get.find<iniControllerWithReactive>()
//             .Series_Color_008
//             .value
//             .toString());

//     print('new : ${c.toString()}');
//     print('===============write ini end============');

//     return file.writeAsString(c.toString());
//   }
}
