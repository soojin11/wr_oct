import 'dart:async';
import 'dart:ffi';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ini/ini.dart';
import 'package:wr_ui/main.dart';
import 'csv_creator.dart';

Future<List<double>> readData(int a) async {
  return compute(dllReadData, a);
}

List<double> dllReadData(int a) {
  Pointer<Double> fmtSpec = nullptr;
  getformatSpec = wgsFunction
      .lookup<NativeFunction<Pointer<Double> Function(Int32)>>(
          'GetFormatedSpectrum')
      .asFunction();
  fmtSpec = getformatSpec(a);
  List<double> rt = [];
  for (var x = 0; x < 2048; x++) {
    rt.add(fmtSpec[x].toDouble());
  }

  return rt;
}
// 100ms(이동시간)+100(in)*8
// 230*8->

class iniController extends GetxController {
  final GlobalKey<FormState> key = GlobalKey<FormState>();
  Rx<Color> Series_Color_001 = Color(0xFFEF5350).obs;
  Rx<Color> Series_Color_002 = Color(0xFFFFA726).obs;
  Rx<Color> Series_Color_003 = Color(0xFFFFD54F).obs;
  Rx<Color> Series_Color_004 = Color(0xFF81C784).obs;
  Rx<Color> Series_Color_005 = Color(0xFF64B5F6).obs;
  Rx<Color> Series_Color_006 = Color(0xFF0D47A1).obs;
  Rx<Color> Series_Color_007 = Color(0xFFBA68C8).obs;
  Rx<Color> Series_Color_008 = Color(0xFFFDB1E0).obs;
  RxString exposureTime = '100'.obs;
  RxString delayTime = '100'.obs;
  RxInt channelMovingTime = 200.obs;
  RxInt integrationTime = 100000.obs;
  RxInt plusTime = 30000.obs;
  RxString deviceSimul = ''.obs;
  RxString mosChannel = '0'.obs;
  RxInt sim = 0.obs;
  RxString measureStartAtProgStart = '1'.obs;
  RxString channelFlow = ''.obs;
  RxInt OES_Count = 8.obs;
  RxInt comPort = 3.obs;
  //디바이스데이터 채널 변경때문에 임시추가-원희-21/12/08
  RxList<String> chflow = ['1', '3', '5', '7', '8', '6', '4', '2'].obs;
  //디바이스데이터 채널 변경때문에 임시추가-원희-21/12/08
}

Future<String> writeToConf(contents) async {
  try {
    final file = await _localFile;
    file.writeAsString(contents.toString());
    return "success";
  } catch (e) {
    return e.toString();
  }
}

readConfig() async {
  print('in readConfig');
  var result;
  try {
    var file = await _localFile;
    Config config = Config.fromStrings(file.readAsLinesSync());
    result = config;

    if (int.parse(config.get("Common", "OES_Simulation").toString()) == 0 &&
        int.parse(config.get("Common", "measureStartAtProgStart").toString()) ==
            1) {
      //SimStartBtn(); // 시뮬레이션 바로 실행
    }
    if (int.parse(config.get("Common", "OES_Simulation").toString()) == 0) {
      //시뮬레이터 작동
      Get.find<iniController>().sim.value = 0;
    } else if (int.parse(config.get("Common", "OES_Simulation").toString()) ==
        1) {
      Get.find<iniController>().sim.value = 1;
      int integrationTime =
          int.parse(config.get("Common", "IntegrationTime").toString());
      print('parsing ?? $integrationTime');
      Get.find<iniController>().integrationTime.value = integrationTime;
      //////
      int channelMovingTime =
          int.parse(config.get("Common", "Channel_Moving_Time").toString());
      print('channel move t in ini : $channelMovingTime');
      Get.find<iniController>().channelMovingTime.value = channelMovingTime;
      int plusTime = int.parse(config.get("Common", "PlusTime").toString());
      Get.find<iniController>().plusTime.value = plusTime;
      //////
      int comPortNum = int.parse(config.get('Common', 'Comport').toString());
      Get.find<iniController>().comPort.value = comPortNum;
    }

    // int integrationTime =
    //     int.parse(config.get("Common", "IntegrationTime").toString());
    // Get.find<iniController>().integrationTime.value = integrationTime;
    // else if (int.parse(config.get("Common", "OES_Simulation").toString()) ==
    //     1) {
    //   Get.find<iniController>().sim.value = 1;
    //   print('${Get.find<iniController>().sim.value}');
    // }

    // else if (int.parse(config.get("Common", "OES_Simulation").toString()) ==
    //     1) {
    //   oesInit();
    // }
    //실제 데이터 부분 작동

    //데이터 들어오면 쓸 부분//////////////////////////////////////////
    // if(int.parse(config.get("Common", "OES_Simulation").toString()) == 0){
    //   이면 시뮬레이터 SimStartButton();
    // }
    // if(int.parse(config.get("Common", "OES_Simulation").toString()) == 1){
    //   이면 찐 데이터 들어오는거
    // }
    //////////////////////////////////////////////////////////

    if (int.parse(config.get("Common", "SaveFromStartSignal").toString()) ==
            1 &&
        int.parse(config.get("Common", "measureStartAtProgStart").toString()) ==
            1) {
      startSaveBtn();
    }

    // if (int.parse(config.get("Common", "OES_Simulation").toString()) == 1) {
    //   print('디바이스로 실행 준비');
    //   Get.find<deviceController>().setRealData();
    // } else if (int.parse(config.get("Common", "OES_Simulation").toString()) ==
    //     0) {
    //   print('시뮬레이션으로 실행 준비');
    // } else {
    //   print('ini에 0또는 1만 입력');
    // }
  } catch (e) {
    if (e is FileSystemException) {
      result = Config.fromString("");
    }
  }
  return result;
}

Future<File> get _localFile async {
  return File('./inifiles/FreqAI.ini');
}

writeConfig() async {
  Config config = new Config();
  await readConfig();
  if (!config.hasSection("Common")) {
    config.addSection("Common");
    config.set("Common", "Comport", "3");
    config.set("Common", "IntegrationTime", "100000");
    config.set("Common", "Channel_Moving_Time", "200000");
    config.set("Common", "PlusTime", "30000");
    config.set("Common", "OES_Simulation", '1');
    config.set("Common", "OES_Count", "8");
    config.set("Common", "bOESConnect", "false");
    config.set("Common", "VI_Simulation", "1");
    config.set("Common", "VI_Count ", "1");
    config.set("Common", "bVIConnect", "false");
    config.set("Common", "DataPath", "./datafiles/");
    config.set("Common", "SaveFromStartSignal", "0");
    config.set("Common", "measureStartAtProgStart", "0");
    config.set("Common", "Channel_Flow", "1, 3, 5, 7, 8, 6, 4, 2");

    writeToConf(config);
  }
  if (!config.hasSection("OES_Setting")) {
    config.addSection("OES_Setting");
    config.set("OES_Setting", "ExposureTime", "100");

    config.set("OES_Setting", 'DelayTime', "100");
    writeToConf(config);
  }
  if (!config.hasSection("VI_Setting")) {
    config.addSection("VI_Setting");
    config.set("VI_Setting", "a", "0");
    config.set("VI_Setting", 'b', "2");
    writeToConf(config);
  }
  if (!config.hasSection("OES_Chart_Setting")) {
    config.addSection("OES_Chart_Setting");
    config.set("OES_Chart_Setting", "Series_Color_001",
        Get.find<iniController>().Series_Color_001.toString());
    config.set("OES_Chart_Setting", 'Series_Color_002',
        Get.find<iniController>().Series_Color_002.toString());
    config.set("OES_Chart_Setting", 'Series_Color_003',
        Get.find<iniController>().Series_Color_003.toString());
    config.set("OES_Chart_Setting", 'Series_Color_004',
        Get.find<iniController>().Series_Color_004.toString());
    config.set("OES_Chart_Setting", 'Series_Color_005',
        Get.find<iniController>().Series_Color_005.toString());
    config.set("OES_Chart_Setting", 'Series_Color_006',
        Get.find<iniController>().Series_Color_006.toString());
    config.set("OES_Chart_Setting", 'Series_Color_007',
        Get.find<iniController>().Series_Color_007.toString());
    config.set("OES_Chart_Setting", 'Series_Color_008',
        Get.find<iniController>().Series_Color_008.toString());
    writeToConf(config);
  }
}
