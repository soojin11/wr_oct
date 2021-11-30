import 'package:get/get.dart';
import 'package:ini/ini.dart';
import 'package:wr_ui/view/appbar/leading/run_error_status_mark.dart';
import 'dart:io';

import 'package:wr_ui/view/chart/oes_chart.dart';
import 'package:wr_ui/view/right_side_menu/start_stop.dart';

class iniControllerWithReactive extends GetxController {
  static iniControllerWithReactive get to => Get.find();

  /////////파일쓰기
  RxString path = ''.obs;
  File? file;
  RxString OES_Simulation = '0'.obs;
  RxString OES_Count = '0'.obs;
  RxString VI_Simulation = '0'.obs;
  RxString VI_Count = '0'.obs;
  RxString DataPath = ''.obs;
  RxString SaveFromStartSignal = '1'.obs;
  RxString measureStartAtProgStart = '1'.obs;
  RxString ExposureTime = '100'.obs;
  RxString DelayTime = '200'.obs;
  RxString a = '0'.obs;
  RxString b = '2'.obs;
  RxString Series_Color_001 = 'red'.obs;
  RxString Series_Color_002 = 'blue'.obs;
  RxString Series_Color_003 = 'grey'.obs;
  RxString Series_Color_004 = 'orange'.obs;
  RxString Series_Color_005 = 'green'.obs;
  RxString Series_Color_006 = 'bluegrey'.obs;
  RxString Series_Color_007 = 'pink'.obs;
  RxString Series_Color_008 = 'purple'.obs;

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
  @override
  void onInit() {
    super.onInit();
    ever(measureStartAtProgStart, (m) => writeIni());
    ever(measureStartAtProgStart, (m) => writeIni());
    ever(ExposureTime, (m) => writeIni());
  }

  Future<File> get _iniPath async {
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
  Future readIni() async {
    print('===============ini read start================');

    _readIni();
  }

  _readIni() async {
    var file = await _iniPath;

    Config c = new Config.fromStrings(file.readAsLinesSync());
    print('new : ${c.toString()}');
    print('default=>"${c.defaults()['dsd' 'dsd']}"');
    print('section=>"${c.sections()}');
    print('items=>"${c.items('deviceSettings')}"');
    print('get?=>"${c.get('deviceSettings', 'measureStartAtProgStart')}"');
    print('===============ini read end=============');
    return c;
  }

  Future writeIni() async {
    print('===============write ini start============');
    final file = await _iniPath;
    Config c = new Config();

    c.addSection('Common');
    c.set('Common', 'OES_Simulation',
        Get.find<iniControllerWithReactive>().OES_Simulation.value);
    c.set('Common', 'OES_Count',
        Get.find<iniControllerWithReactive>().OES_Count.value);
    c.set('Common', 'VI_Simulation',
        Get.find<iniControllerWithReactive>().VI_Simulation.value);
    c.set('Common', 'VI_Count',
        Get.find<iniControllerWithReactive>().VI_Count.value);
    c.set('Common', 'DataPath',
        Get.find<iniControllerWithReactive>().DataPath.value);
    c.set('Common', 'SaveFromStartSignal ',
        Get.find<iniControllerWithReactive>().SaveFromStartSignal.value);
    c.set('Common', 'measureStartAtProgStart ',
        Get.find<iniControllerWithReactive>().measureStartAtProgStart.value);
    ///////////////////////
    c.addSection('OES_Setting');
    c.set('OES_Setting', 'ExposureTime',
        Get.find<iniControllerWithReactive>().ExposureTime.value);
    c.set('OES_Setting', 'DelayTime',
        Get.find<iniControllerWithReactive>().DelayTime.value);
    ///////////////
    c.addSection('VI_Setting');
    c.set('VI_Setting', 'a', Get.find<iniControllerWithReactive>().a.value);
    c.set('VI_Setting', 'b', Get.find<iniControllerWithReactive>().b.value);
    //////////
    c.addSection('OES_Chart_Setting');
    c.set('OES_Chart_Setting', 'Series_Color_001',
        Get.find<iniControllerWithReactive>().Series_Color_001.value);
    c.set('OES_Chart_Setting', 'Series_Color_002',
        Get.find<iniControllerWithReactive>().Series_Color_002.value);
    c.set('OES_Chart_Setting', 'Series_Color_003',
        Get.find<iniControllerWithReactive>().Series_Color_003.value);
    c.set('OES_Chart_Setting', 'Series_Color_004',
        Get.find<iniControllerWithReactive>().Series_Color_004.value);
    print('new : ${c.toString()}');
    print('===============write ini end============');

    return file.writeAsString(c.toString());
  }
}
