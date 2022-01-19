import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wr_ui/main.dart';
import 'dart:ffi';
import 'package:flutter/foundation.dart';
import 'dart:math' as math;

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
  if (a.sim != -1 && a.sim != 0) {
    Pointer<Double> fmtSpec = nullptr;
    getformatSpec = wgsFunction
        .lookup<NativeFunction<Pointer<Double> Function(Int32)>>(
            'GetFormatedSpectrum')
        .asFunction();
    fmtSpec = getformatSpec(a.spectrometerIndex);

    for (var x = 0; x < 2048; x++) {
      // rt.add(fmtSpec[x].toDouble());
      rt.add(double.parse(fmtSpec[x].toStringAsFixed(2)));
    }
  } else if (a.sim == -1) {
    for (var x = 0; x < 2048; x++) {
      // rt.add(500 + math.Random().nextInt(1500).toDouble());
      rt.add(
          double.parse((500 + math.Random().nextInt(1500)).toStringAsFixed(0)));
    }
  } else if (a.sim == 0) {
    for (var i = 0; i < 2048; i++) {
      rt.add(0);
    }
  }

  return rt;
}

class iniController extends GetxController {
  static iniController get to => Get.find();
  final GlobalKey<FormState> key = GlobalKey<FormState>();

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
  //OES
  RxInt channelMovingTime = 2000.obs;
  RxInt integrationTime = loadConfig.oesConfig.integrationTime.obs;
  RxInt waitSwitchingTime = 400.obs;
  RxInt plusTime = 100.obs;
  // RxInt sim = 1.obs;
  RxList channelFlow = loadConfig.oesConfig.channelFlow.obs;
  RxInt OES_Count = 8.obs;
  RxInt oes_comport = loadConfig.oesConfig.oesComPort.obs;
  RxInt oesAutoSaveVal = loadConfig.oesConfig.autoSaveVal.obs;
  RxBool checkAuto = loadConfig.oesConfig.autoSave.obs;
  // RxBool oesSim = loadConfig.oesConfig.simulation.obs;
  RxInt viz_Interval = loadConfig.vizConfig.interval.obs;
  RxList vizComport = loadConfig.vizConfig.VizComPort.obs;
}
