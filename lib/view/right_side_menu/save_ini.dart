import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ini/ini.dart';
import 'package:wr_ui/view/right_side_menu/start_stop.dart';
import 'csv_creator.dart';

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
  RxInt sim = 0.obs;

  ///원희님꺼 추가한 부분/////////
  RxString measureStartAtProgStart = '1'.obs;
  RxString channelFlow = ''.obs;
  RxInt OES_Count = 8.obs;
  ///////////////////////////////
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
  var result;
  
  try {
    var file = await _localFile;
    Config config = Config.fromStrings(file.readAsLinesSync());
    result = config;
    if (int.parse(config.get("Common", "OES_Simulation").toString()) == 0 &&
        int.parse(config.get("Common", "measureStartAtProgStart").toString()) ==
            1) {
      StartButton(); // 시뮬레이션 바로 실행
      Get.find<iniController>().sim.value = 0;
    }


    if(int.parse(config.get("Common", "OES_Simulation").toString()) == 0){
      Get.find<iniController>().sim.value = 0;
      
    }
    if(int.parse(config.get("Common", "OES_Simulation").toString()) == 1){
     Get.find<iniController>().sim.value =1;
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
  return File('./inifiles/FreqAI.ini');
}

writeConfig() async {
  Config config = new Config();
  await readConfig();
  if (!config.hasSection("Common")) {
    config.addSection("Common");
    config.set("Common", "Comport", "3");
    config.set("Common", "OES_Simulation", '0');
    config.set("Common", "OES_Count", "8");
    config.set("Common", "bOESConnect", "false");
    config.set("Common", "VI_Simulation", "0");
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
