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
  RxInt OES_Simulation = 1.obs;
  RxInt OES_Count = 1.obs;
  RxBool bOESConnect = false.obs;
  RxInt VI_Simulation = 1.obs;
  RxInt VI_Count = 1.obs;
  RxBool bVIConnect = true.obs;
  RxString DataPath = './datafiles/'.obs;
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
    ever(OES_Simulation, (m) => writeIni());
    ever(OES_Count, (m) => writeIni());
    ever(bOESConnect, (m) => writeIni());
    ever(VI_Simulation, (m) => writeIni());
    ever(VI_Count, (m) => writeIni());
    ever(bVIConnect, (m) => writeIni());
    ever(DataPath, (m) => writeIni());
    ever(SaveFromStartSignal, (m) => writeIni());
    ever(measureStartAtProgStart, (m) => writeIni());
    ever(ExposureTime, (m) => writeIni());
    ever(DelayTime, (m) => writeIni());
    ever(a, (m) => writeIni());
    ever(b, (m) => writeIni());
    ever(Series_Color_001, (m) => writeIni());
    ever(Series_Color_002, (m) => writeIni());
    ever(Series_Color_003, (m) => writeIni());
    ever(Series_Color_004, (m) => writeIni());
    ever(Series_Color_005, (m) => writeIni());
  }

  Future<File> get iniPath async {
    final String fileName = 'FreqAI';
    await Directory('inifiles').create(recursive: true);
    path.value = "./inifiles/$fileName.ini";
    // String startTime = streamDateTime;
    File file = File(path.value);
    print('wrFile의 경로는??$file');
//     String aaa = '''OES_Simulation = 1
// OES_Count = 1
// bOESConnect = false
// VI_Simulation = 1
// VI_Count = 1
// bVIConnect = true
// DataPath = ./datafiles/
// SaveFromStartSignal = 1
// measureStartAtProgStart = 1''';
//     return file.writeAsString(aaa);

    return file;
  }

  /////////파일쓰기

  ////////read
  Future readIni() async {
    print('===============ini read start================');

    _readIni();
  }

  _readIni() async {
    var file = await iniPath;

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
    final file = await iniPath;
    Config c = new Config();

    c.addSection('Common');
    c.set('Common', 'OES_Simulation',
        Get.find<iniControllerWithReactive>().OES_Simulation.value.toString());

    c.set('Common', 'OES_Count',
        Get.find<iniControllerWithReactive>().OES_Count.value.toString());
    c.set('Common', 'bOESConnect',
        Get.find<iniControllerWithReactive>().bOESConnect.value.toString());
    c.set('Common', 'VI_Simulation',
        Get.find<iniControllerWithReactive>().VI_Simulation.value.toString());
    c.set('Common', 'VI_Count',
        Get.find<iniControllerWithReactive>().VI_Count.value.toString());
    c.set('Common', 'bVIConnect',
        Get.find<iniControllerWithReactive>().bVIConnect.value.toString());
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
    c.set('OES_Chart_Setting', 'Series_Color_005',
        Get.find<iniControllerWithReactive>().Series_Color_005.value);
    c.set('OES_Chart_Setting', 'Series_Color_006',
        Get.find<iniControllerWithReactive>().Series_Color_006.value);
    c.set('OES_Chart_Setting', 'Series_Color_007',
        Get.find<iniControllerWithReactive>().Series_Color_007.value);
    c.set('OES_Chart_Setting', 'Series_Color_008',
        Get.find<iniControllerWithReactive>().Series_Color_008.value);
    print('new : ${c.toString()}');
    print('===============write ini end============');

    return file.writeAsString(c.toString());
  }
}
