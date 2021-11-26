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
  //////measureStartAtProgStart가 0일 때, 프로그램 시작 시, 수동으로 측정시작,
  //////measureStartAtProgStart가 1일 때, 프로그램 시작 시, 자동으로 측정시작,

  RxString measureStartAtProgStart = '1'.obs;
  // /OES Check [begin]
// if (1 == OES_simulation)
// {
  //  bOESConnect = true
// }
// else if (0 >= OES_count)
// {
  //  bOESConnect = true
// }
// else // oes simulation 상태가 아니고, 디바이스 카운트가 0보다 크다.
// {
  //  bOESConnect = OES_Connect(); // c++ 접속 요청
// }
// OES Check [end]
// VI Check [begin]
// if (1 == VI_simulation)
// {
  //  bVIConnect = true
// }
// else if (0 >= VI_count)
// {
  //  bVIConnect = true
// }
// else // vi simulation 상태가 아니고, 디바이스 카운트가 0보다 크다.
// {
  //  bVIConnect = VI_Connect(); // c++ 접속 요청
// }
// VI Check [end]
// if ( 1 == OES_simulation && 1 == VI_simulation)
// {
  //  Status = "SIM"
// }
// else
// {
  //  if (true == bOESConnect && true == bVIConnect)
  //  {
  // Status = "RUN"
  //  }
  //  else
  //  {
  // Status = "Error"
  //  }
// }
//OESsimulation&OESchannelCount =>위에 조건문에 넣을 거,기능명세서에서 device all check
  RxInt OESsimulation = 0.obs;
  RxInt OESchannelCount = 8.obs;

  ///currentDirectoryAutoSave 0이면 유저가 파일이름 위치 설정하는 창 띄우기
  ///currentDirectoryAutoSave 1이면 원래저장경로(CSVsavePath)에 저장되기
  RxInt currentDirectoryAutoSave = 0.obs;
  RxString CSVsavePath = './datafiles/'.obs;
  //saveFromStartSignal 0이면 동작 없음
  //saveFromStartSignal 1이면 측정 시작점~측정종료점까지 데이터들 저장.
  RxInt saveFromStartSignal = 0.obs;
  //dataViewStartFromMoreValueOES=>oes측정값이 몇 초과 일 때부터 그래프에 표시
  RxDouble dataViewStartFromMoreValueOES = 0.0.obs;
  RxDouble dataViewStartFromMoreValuesVI = 0.0.obs;
  RxString exposureTime = '100'.obs;
  RxInt delayTime = 0.obs;
  //////////프로그램 구동 시 자동시작
  @override
  void onInit() {
    super.onInit();
    ever(measureStartAtProgStart, (m) => writeIni()
        // print('measureStartAtProgStart이 변경됨=>$_')
        );
    ever(exposureTime, (m) => writeIni());
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
    if (c.hasOption('option', 'defaultValue')) {
      print('${c.hasOption('option', 'defaultValue')}');
      c.addSection('name');
    }
    print('${c.hasOption('option', 'defaultValue')}');
    // c.sections()
    // c.defaults()['option'] = 'defaultValue';
    // c.defaults()['name'] = 'defaultname';
    c.addSection('deviceSettings');

    c.set('deviceSettings', 'deviceSimulation', '1');
    c.set('deviceSettings', 'measureStartAtProgStart',
        measureStartAtProgStart.value);

    c.set('deviceSettings', 'exposureTime', exposureTime.string);
    c.set('deviceSettings', 'delayTime', delayTime.string);
    c.addSection('chartSettings');
    c.set('chartSettings', 'OESsimulation', OESsimulation.string);
    c.set('chartSettings', 'OESchannelCount', OESchannelCount.string);

    c.addSection('saveSettings');
    c.set('saveSettings', 'currentDirectoryAutoSave',
        currentDirectoryAutoSave.string);
    c.set('saveSettings', 'CSVsavePath', path.value);
    c.set('saveSettings', 'saveFromStartSignal', saveFromStartSignal.string);
    c.set('saveSettings', 'dataViewStartFromMoreValueOES',
        dataViewStartFromMoreValueOES.string);
    print('new : ${c.toString()}');
    print('===============write ini end============');

    return file.writeAsString(c.toString());
  }
}
