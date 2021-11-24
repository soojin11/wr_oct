import 'package:get/get.dart';
import 'package:ini/ini.dart';
import 'dart:io';

class iniControllerWithReactive extends GetxController {
  static iniControllerWithReactive get to => Get.find();

  /////////파일쓰기
  RxString fileName = ''.obs;
  RxString path = ''.obs;
  File? file;
  String? deviceSimulation = '1';

  //////////프로그램 구동 시 자동시작
  RxString measureStartAtProgStart = '1'.obs;
  RxInt OESsimulation = 0.obs;
  RxInt OESchannelCount = 8.obs;
  RxInt currentDirectoryAutoSave = 1.obs;
  RxString CSVsavePath = './datafiles/'.obs;
  RxInt saveFromStartSignal = 0.obs;
  RxDouble dataViewStartFromMoreValueOES = 0.0.obs;
  RxInt exposureTime = 0.obs;
  RxInt delayTime = 0.obs;

  //////////프로그램 구동 시 자동시작
  @override
  void onInit() {
    super.onInit();
    ever(measureStartAtProgStart, (_) => writeIni()
        // print('measureStartAtProgStart이 변경됨=>$_')
        );
  }

  Future<File> get _iniPath async {
    fileName.value = 'FreqAI';
    path.value = "./inifiles/${fileName.value}.ini";
    Directory iniFolder = Directory('inifiles');
    await iniFolder.create();

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
    print('===============ini read end=============');
    return c;
  }

  Future writeIni() async {
    print('===============write ini start============');
    final file = await _iniPath;
    Config c = new Config();
    c.addSection('deviceSettings');
    c.set('deviceSettings', 'measureStartAtProgStart',
        measureStartAtProgStart.value);
    c.set('deviceSettings', 'exposureTime', exposureTime.string);
    c.set('deviceSettings', 'delayTime', delayTime.string);
    c.addSection('chartSettings');
    c.set('chartSettings', 'OESsimulation', OESsimulation.string);
    c.set('chartSettings', 'OESsimulation', OESchannelCount.string);

    c.addSection('saveSettings');
    c.set('saveSettings', 'currentDirectoryAutoSave',
        currentDirectoryAutoSave.string);
    c.set('saveSettings', 'CSVsavePath', path.value);
    c.set('saveSettings', 'saveFromStartSignal', saveFromStartSignal.string);
    c.set('saveSettings', 'saveFromStartSignal',
        dataViewStartFromMoreValueOES.string);
    print('ini content => ${c.toString()}');
    print('===============write ini end============');
    return file.writeAsString(c.toString());
  }
}
