import 'package:get/get.dart';
import 'package:ini/ini.dart';
import 'package:wr_ui/view/appbar/leading/run_error_status_mark.dart';
import 'dart:io';

import 'package:wr_ui/view/chart/oes_chart.dart';
import 'package:wr_ui/view/right_side_menu/start_stop.dart';

class iniControllerWithReactive extends GetxService {
  static iniControllerWithReactive get to => Get.find();

  /////////파일쓰기
  RxString path = ''.obs;
  File? file;

  //////////프로그램 구동 시 자동시작
  RxString measureStartAtProgStart = '0'.obs;
  RxString OES_Simulation = '0'.obs;
  RxString OES_Count = '8'.obs;
  RxString VI_Simulation = '0'.obs;
  RxString VI_Count = '0'.obs;
  RxString currentDirectoryAutoSave = '1'.obs;
  RxString DataPath = './datafiles/'.obs;
  RxString saveFromStartSignal = '1'.obs;
  RxDouble dataViewStartFromMoreValueOES = 0.0.obs;
  /////////////여기부터 세팅창
  RxString ExposureTime = '100'.obs;
  RxString DelayTime = '200'.obs;
  RxString Series_Color_001 = 'red'.obs;
  RxString Series_Color_002 = 'red'.obs;
  RxString a = ''.obs;
  RxString b = ''.obs;
  //////////프로그램 구동 시 자동시작
  @override
  void onInit() {
    super.onInit();
    ever(measureStartAtProgStart, (m) => writeIni()
        // print('measureStartAtProgStart이 변경됨=>$_')
        );
    ever(ExposureTime, (m) => writeIni());
  }

  Future<File> get _iniPath async {
    final String fileName = 'FreqAI';
    await Directory('inifiles').create();
    path.value = "./inifiles/$fileName.ini";
    // String startTime = streamDateTime;
    File file = File(path.value);
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

    print('===============ini read end=============');
    return c;
  }

  Future writeIni() async {
    print('===============write ini start============');
    final file = await _iniPath;
    Config c = new Config();
    String? aa = c.get('deviceSettings', 'measureStartAtProgStart');
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
        Get.find<iniControllerWithReactive>().saveFromStartSignal.value);
    c.set('Common', 'measureStartAtProgStart ',
        Get.find<iniControllerWithReactive>().measureStartAtProgStart.value);
    //////////////////////////////////
    c.addSection('OES_Setting');
    c.set('OES_Setting', 'ExposureTime',
        Get.find<iniControllerWithReactive>().ExposureTime.value);
    c.set('OES_Setting', 'DelayTime',
        Get.find<iniControllerWithReactive>().DelayTime.value);
    c.addSection('VI_Setting');
    c.set('VI_Setting', 'a', Get.find<iniControllerWithReactive>().a.value);
    c.set('VI_Setting', 'b', Get.find<iniControllerWithReactive>().b.value);
    c.addSection('OES_Chart_Setting');
    c.set('OES_Chart_Setting', 'Series_Color_001',
        Get.find<iniControllerWithReactive>().Series_Color_001.value);
    c.set('OES_Chart_Setting', 'Series_Color_002',
        Get.find<iniControllerWithReactive>().Series_Color_002.value);

    print('${c.toString()}');
    print('===============write ini end============');

    return file.writeAsString(c.toString());
  }
}
