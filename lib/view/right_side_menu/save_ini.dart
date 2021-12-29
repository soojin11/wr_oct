import 'dart:async';
import 'dart:ffi';
import 'dart:io';
import 'dart:math' as math;
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
  Get.put(iniController());
  List<double> rt = [];
  if (Get.find<iniController>().sim == 1) {
    Pointer<Double> fmtSpec = nullptr;
    getformatSpec = wgsFunction
        .lookup<NativeFunction<Pointer<Double> Function(Int32)>>(
            'GetFormatedSpectrum')
        .asFunction();
    fmtSpec = getformatSpec(a);

    for (var x = 0; x < 2048; x++) {
      rt.add(fmtSpec[x].toDouble());
    }
  } else {
    Future.delayed(Duration(
        microseconds: Get.find<iniController>().integrationTime.value));

    for (var x = 0; x < 2048; x++) {
      rt.add(1900 + math.Random().nextInt(100).toDouble());
    }
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
  Rx<Color> Series_Color_007 = Color(0xFF8F24A1).obs;
  Rx<Color> Series_Color_008 = Color(0xFFFDB1E0).obs;
  RxString exposureTime = '100'.obs;
  RxString delayTime = '100'.obs;
  RxInt channelMovingTime = 2000.obs;
  RxInt integrationTime = 1000.obs;
  RxInt waitSwitchingTime = 1000.obs;
  RxInt plusTime = 100.obs;
  RxString deviceSimul = ''.obs;
  RxString mosChannel = '0'.obs;
  RxInt sim = 0.obs;
  RxString measureStartAtProgStart = '1'.obs;
  RxList<String> channelFlow = ['1', '3', '5', '7', '8', '6', '4', '2'].obs;
  RxInt OES_Count = 8.obs;
  RxInt oes_comport = 3.obs;
  RxString viz_Interval = '100'.obs;
  RxList<String> viz_comport = [
    'COM4',
    'COM1',
    'COM2',
    'COM6',
    'COM5',
  ].obs;
  RxDouble oesMaxValue = 2300.0.obs;
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

    if (int.parse(config.get("Common", "OES_Simulation").toString()) == 0) {
      //시뮬레이터 작동
      Get.find<iniController>().sim.value = 0;
    } else if (int.parse(config.get("Common", "OES_Simulation").toString()) ==
        1) {
      Get.find<iniController>().sim.value = 1;
      int integrationTime =
          int.parse(config.get("Common", "IntegrationTime").toString());
      print('parsing ?? $integrationTime');
      Get.find<iniController>().integrationTime.value = integrationTime * 1000;
      //////
      int channelMovingTime =
          int.parse(config.get("Common", "Channel_Moving_Time").toString());
      print('channel move t in ini : $channelMovingTime');
      Get.find<iniController>().channelMovingTime.value = channelMovingTime;
      int plusTime = int.parse(config.get("Common", "PlusTime").toString());
      Get.find<iniController>().plusTime.value = plusTime;
      //////
      int waitSwitchingTime =
          int.parse(config.get("Common", "waitSwitchingTime").toString());
      Get.find<iniController>().waitSwitchingTime.value = waitSwitchingTime;
      //////
      int comPortNum = int.parse(config.get('Common', 'Comport').toString());
      Get.find<iniController>().oes_comport.value = comPortNum;
    }

    if (int.parse(config.get("Common", "SaveFromStartSignal").toString()) ==
            1 &&
        int.parse(config.get("Common", "measureStartAtProgStart").toString()) ==
            1) {
      startSaveBtn();
    }
  } catch (e) {
    if (e is FileSystemException) {
      result = Config.fromString("");
    }
  }
  return result;
}

Future<File> get _localFile async {
  Directory('inifiles').create(recursive: true);
  return File('./inifiles/FreqAI.ini');
}

writeConfig() async {
  //
  Config config = await readConfig();
  if (!config.hasSection("Common")) {
    config.addSection("Common");
    config.set("Common", "OES_Comport", "3");
    config.set("Common", "IntegrationTime", "1000");
    config.set("Common", "Channel_Moving_Time", "1500");
    config.set("Common", "PlusTime", "100");
    //밀리세컨즈 1초 == 1000
    config.set("Common", "waitSwitchingTime", "1000");
    config.set("Common", "OES_Simulation", '0');
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

writeConfig2() async {
  Config config = new Config();

  config.addSection("Common");
  config.set("Common", "OES_Comport", "3");
  config.set("Common", "IntegrationTime",
      (Get.find<iniController>().integrationTime.value ~/ 1000).toString());
  config.set("Common", "Channel_Moving_Time", "1500");
  config.set("Common", "PlusTime", "100");
  //밀리세컨즈 1초 == 1000
  config.set("Common", "waitSwitchingTime",
      Get.find<iniController>().waitSwitchingTime.value.toString());
  config.set("Common", "OES_Simulation", '0');
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
  config.addSection("OES_Setting");
  config.set("OES_Setting", "ExposureTime", "100");

  config.set("OES_Setting", 'DelayTime', "100");
  writeToConf(config);
  config.addSection("VI_Setting");
  config.set("VI_Setting", "a", "0");
  config.set("VI_Setting", 'b', "2");
  writeToConf(config);
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
