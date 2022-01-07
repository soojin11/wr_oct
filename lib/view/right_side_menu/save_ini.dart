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

class ArgReadData {
  int spectrometerIndex;
  int sim;
  ArgReadData({
    required this.spectrometerIndex,
    required this.sim,
  });
}

Future<List<double>> readData(ArgReadData a) async {
  return compute(dllReadData, a);
}

List<double> dllReadData(ArgReadData a) {
  List<double> rt = [];
  if (a.sim == 0) {
    Pointer<Double> fmtSpec = nullptr;
    getformatSpec = wgsFunction
        .lookup<NativeFunction<Pointer<Double> Function(Int32)>>(
            'GetFormatedSpectrum')
        .asFunction();
    fmtSpec = getformatSpec(a.spectrometerIndex);

    for (var x = 0; x < 2048; x++) {
      rt.add(fmtSpec[x].toDouble());
    }
  } else {
    // Future.delayed(Duration(
    //     microseconds: Get.find<iniController>().integrationTime.value));

    for (var x = 0; x < 2048; x++) {
      rt.add(500 + math.Random().nextInt(1500).toDouble());
    }
  }

  return rt;
}
// 100ms(이동시간)+100(in)*8
// 230*8->

class iniController extends GetxController {
  static iniController get to => Get.find();
  final GlobalKey<FormState> key = GlobalKey<FormState>();
  Rx<Color> Series_Color_001 = Color(0xFFEF5350).obs;
  Rx<Color> Series_Color_002 = Color(0xFFFFA726).obs;
  Rx<Color> Series_Color_003 = Color(0xFFFFD54F).obs;
  Rx<Color> Series_Color_004 = Color(0xFF81C784).obs;
  Rx<Color> Series_Color_005 = Color(0xFF64B5F6).obs;
  Rx<Color> Series_Color_006 = Color(0xFF0D47A1).obs;
  Rx<Color> Series_Color_007 = Color(0xFF8F24A1).obs;
  Rx<Color> Series_Color_008 = Color(0xFFFDB1E0).obs;
  RxList<Color> oesColor = [
    Color(0xFFEF5350),
    Color(0xFFFFA726),
    Color(0xFFFFD54F),
    Color(0xFF81C784),
    Color(0xFF64B5F6),
    Color(0xFF0D47A1),
    Color(0xFF8F24A1),
    Color(0xFFFDB1E0)
  ].obs;
  RxList<Color> vizColor = [
    Color(0xFFEF5350),
    Color(0xFFFFA726),
    Color(0xFF8F24A1),
    Color(0xFF81C784),
    Color(0xFF64B5F6),
    Color(0xFF0D47A1),
    Color(0xFFFDB1E0)
  ].obs;
  RxString exposureTime = '100'.obs;
  RxString delayTime = '100'.obs;
  RxInt channelMovingTime = 2000.obs;
  RxInt integrationTime = 1000.obs;
  RxInt waitSwitchingTime = 400.obs;
  RxInt plusTime = 100.obs;
  RxString deviceSimul = ''.obs;
  RxString mosChannel = '0'.obs;
  RxInt sim = 0.obs;
  RxInt vizSimulation = 1.obs;
  RxString measureStartAtProgStart = '1'.obs;
  RxList<String> channelFlow = ['1', '3', '5', '7', '8', '6', '4', '2'].obs;
  RxInt OES_Count = 8.obs;
  RxInt oes_comport = 3.obs;
  RxString viz_Interval = '100'.obs;
  RxList<int> vizComport = [4, 1, 2, 6, 5].obs;
  RxDouble oesAutoSaveVal = 3000.0.obs;
  // RxInt autoSave = 1.obs;
  RxBool checkAuto = true.obs;
  //디바이스데이터 채널 변경때문에 임시추가-원희-21/12/08
  RxList<String> chflow = ['1', '3', '5', '7', '8', '6', '4', '2'].obs;
  //디바이스데이터 채널 변경때문에 임시추가-원희-21/12/08
  RxInt oesSimulation = 1.obs;

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
      for (var i = 0; i < 5; i++) {
        Get.find<iniController>().vizComport[i] = int.parse(
            config.get("VI_Setting", 'VIZ_${i + 1}_COM_PORT').toString());
      }
      Get.find<iniController>().oesAutoSaveVal.value =
          double.parse(config.get("OES_Setting", 'AutoSave_Value').toString());

      print('readConfig comport list: ${iniController.to.vizComport}');
      if (int.parse(config.get("Common", "OES_Simulation").toString()) == 1) {
        //시뮬레이터 작동
        Get.find<iniController>().sim.value = 1;
      } else if (int.parse(config.get("Common", "OES_Simulation").toString()) ==
          0) {
        Get.find<iniController>().sim.value = 0;
        int integrationTime =
            int.parse(config.get("Common", "IntegrationTime").toString());
        print('parsing ?? $integrationTime');
        Get.find<iniController>().integrationTime.value =
            integrationTime * 1000;
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
          int.parse(
                  config.get("Common", "measureStartAtProgStart").toString()) ==
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
      config.set(
          "Common", "OES_Simulation", Get.find<iniController>().sim.toString());
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
      // config.set("OES_Setting", "AutoSave", "1");
      config.set("OES_Setting", "AutoSave_Value", "3000");
      config.set("OES_Setting", "AutoSave", "true");
      writeToConf(config);
    }
    if (!config.hasSection("VI_Setting")) {
      config.addSection("VI_Setting");
      config.set("VI_Setting", "VIZ_INTERVAL", "100");
      for (var i = 0; i < 5; i++) {
        config.set("VI_Setting", 'VIZ_${i + 1}_COM_PORT', '${i + 1}');
      }
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
    config.set(
        "Common", "OES_Simulation", Get.find<iniController>().sim.toString());
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
    // config.set("OES_Setting", "AutoSave",
    //     Get.find<iniController>().autoSave.toString());
    config.set("OES_Setting", 'DelayTime', "100");
    config.set("OES_Setting", "AutoSave_Value",
        Get.find<iniController>().oesAutoSaveVal.toString());
    config.set(
        "OES_Setting", "AutoSave", iniController.to.checkAuto.toString());
    writeToConf(config);
    config.addSection("VI_Setting");
    config.set(
        "VI_Setting", "VIZ_INTERVAL", iniController.to.viz_Interval.toString());
    for (var i = 0; i < 5; i++) {
      config.set("VI_Setting", 'VIZ_${i + 1}_COM_PORT',
          iniController.to.vizComport[i].toString());
    }

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
}
