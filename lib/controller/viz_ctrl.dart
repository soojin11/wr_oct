import 'dart:async';
import 'dart:ffi';
import 'dart:isolate';
import 'dart:typed_data';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:libserialport/libserialport.dart';
import 'package:wr_ui/main.dart';
import 'package:wr_ui/model/viz/viz_data.dart';
import 'dart:math' as math;
import 'package:wr_ui/view/right_side_menu/csv_creator.dart';
import 'package:wr_ui/view/right_side_menu/log_screen.dart';
import 'package:wr_ui/view/right_side_menu/save_ini.dart';

aa() {
  ReceivePort mainRP = ReceivePort();
  // mainRP.listen((message) async {
  //   debugPrint('aa message : $message');
  // });
  mainRP.listen((message) {
    VizCtrl.to.vizChannel;
  });
  Isolate.spawn(isolatedViz, mainRP.sendPort);
}

isolatedViz(SendPort vizSP) async {
  Get.put(iniController());
  Get.put(VizCtrl());
  Get.put(LogListController());
  VizCtrl.to.init(); //여기 serialPort.dll 도 있음

  ReceivePort vizRP = ReceivePort();
  vizSP.send(sendData());
  vizRP.listen((message) {
    vizSP.send(message);
    debugPrint('message : $message');
  });
}

Future<bool> sendData() async {
  for (var i = 0; i < 5; i++) {
    print('startSerial i $i');

    if (VizCtrl.to.vizChannel[i].port.openReadWrite()) {
      print('오픈 성공 i $i ${VizCtrl.to.vizChannel[i].port.name}');
      await SerialPortReader(VizCtrl.to.vizChannel[i].port)
          .stream
          .listen((data) async {
        print('listen $i');
        await VizCtrl.to.validity(data, i);
      });
    } else {
      print('오픈 에러 ?? $i ${SerialPort.lastError}');
      Get.find<LogListController>().logData.add('Viz Comport Error');
    }
    if (!VizCtrl.to.vizChannel[i].port.isOpen) {
      Get.find<LogListController>().logData.add('Check VIZ${i + 1} port');
    }
  }
  return true;
}

// aa() {
//   ReceivePort mainRP = ReceivePort();
//   Isolate.spawn(isolatedViz, mainRP.sendPort);
// }

// isolatedViz(SendPort vizSP) async {
//   Get.put(iniController());
//   Get.put(VizCtrl());
//   Get.put(LogListController());
//   VizCtrl.to.init();

//   ReceivePort vizRP = ReceivePort();
//   for (var i = 0; i < 5; i++) {
//     print('startSerial i $i');

//     if (VizCtrl.to.vizChannel[i].port.openReadWrite()) {
//       print('오픈 성공 i $i ${VizCtrl.to.vizChannel[i].port.name}');
//       await SerialPortReader(VizCtrl.to.vizChannel[i].port)
//           .stream
//           .listen((data) async {
//         print('listen $i');
//         await VizCtrl.to.validity(data, i);
//       });
//     } else {
//       print('오픈 에러 ?? $i ${SerialPort.lastError}');
//       Get.find<LogListController>().logData.add('Viz Comport Error');
//     }
//     if (!VizCtrl.to.vizChannel[i].port.isOpen) {
//       Get.find<LogListController>().logData.add('Check VIZ${i + 1} port');
//     }
//   }
// }

class VizCtrl extends GetxController {
  static VizCtrl get to => Get.find();
  RxList<VizChannel> vizChannel = RxList.empty();
  RxList<VizSeries> vizSeries = RxList.empty();
  late Timer timer;
  int numOfViz = 7;
  List<List<int>> buffer = [];
  RxString selected = "OES".obs;
  var dropItem = ['OES', 'VIZ'];
  RxList<RxList<RxList<FlSpot>>> vizPoints = RxList.empty();
  RxDouble step = 1.0.obs;
  RxDouble chartMaxX = 400.0.obs;
  RxDouble chartMinX = 0.0.obs;
  late RxDouble minX;
  late RxDouble maxX;
  RxDouble xValue = 0.0.obs;
  RxBool showAll = false.obs;

  double setRandom() {
    double yValue = 10 + math.Random().nextInt(10).toDouble();
    return yValue;
  }

  void setSelected(value) {
    selected.value = value;
  }

  Future<void> init() async {
    serialConnect = wgsFunction
        .lookup<NativeFunction<Int32 Function(Int32)>>("serialConnect")
        .asFunction();

    vizChannel.clear();
    for (var i = 0; i < 5; i++) {
      if (Get.find<iniController>().vizComport[i] > 0)
        serialConnect(Get.find<iniController>().vizComport[i]);
      buffer.add([]);
      vizChannel.add(VizChannel(
          toggle: true.obs,
          vizData: VizData.init(),
          port: SerialPort('COM${Get.find<iniController>().vizComport[i]}')));
      vizChannel[i].port.config.baudRate = 115200;
    }
    for (var i = 0; i < 7; i++) {
      vizSeries.add(VizSeries(toggle: true.obs));
    }
  }

  Future<void> vizUpdate() async {
    List aaa = [];
    while (vizPoints[0][0].length > chartMaxX.value) {
      for (var i = 0; i < 5; i++) {
        for (var ii = 0; ii < 7; ii++) {
          vizPoints[i][ii].removeAt(0);
        }
      }
    }

    for (var i = 0; i < 5; i++) {
      //수정
      vizPoints[i][0]
          .add(FlSpot(xValue.value, vizChannel[i].vizData.freq / 1000000));
      vizPoints[i][1]
          .add(FlSpot(xValue.value, vizChannel[i].vizData.p_dlv * 2));
      vizPoints[i][2].add(FlSpot(xValue.value, vizChannel[i].vizData.v));
      vizPoints[i][3].add(FlSpot(xValue.value, vizChannel[i].vizData.i * 10));
      vizPoints[i][4].add(FlSpot(xValue.value, vizChannel[i].vizData.r * 10));
      vizPoints[i][5].add(FlSpot(xValue.value, vizChannel[i].vizData.x * 10));
      vizPoints[i][6]
          .add(FlSpot(xValue.value, vizChannel[i].vizData.phase * 1000 / 360));
      aaa.add(vizChannel[i].vizData.freq.toStringAsFixed(2));
      aaa.add(vizChannel[i].vizData.p_dlv.toStringAsFixed(2));
      aaa.add(vizChannel[i].vizData.v.toStringAsFixed(2));
      aaa.add(vizChannel[i].vizData.i.toStringAsFixed(2));
      aaa.add(vizChannel[i].vizData.r.toStringAsFixed(2));
      aaa.add(vizChannel[i].vizData.x.toStringAsFixed(2));
      aaa.add(vizChannel[i].vizData.phase.toStringAsFixed(2));

      // print('asdf${aaa}');

    }

    if (Get.find<CsvController>().csvSaveInit.value) {
      Get.find<CsvController>().vizDataSave(data: aaa);
    }
    if (xValue.value > chartMaxX.value) {
      chartMinX.value += step.value;
      chartMaxX.value += step.value;
    }
    xValue.value += step.value;

    update();
  }

  // startSRL(SendPort mainSendPort) {
  //   ReceivePort startRP = new ReceivePort();
  //   mainSendPort.send(startRP.sendPort);

  //   startRP.listen((msg) {
  //     mainSendPort.send(msg);
  //   });
  // }

//open/listen
  // Future<int> startSerial() async {
  //   for (var i = 0; i < 5; i++) {
  //     print('startSerial i $i');

  //     if (vizChannel[i].port.openReadWrite()) {
  //       print('오픈 성공 i $i ${vizChannel[i].port.name}');
  //       await SerialPortReader(vizChannel[i].port).stream.listen((data) async {
  //         print('listen $i');
  //         await validity(data, i);
  //       });
  //     } else {
  //       print('오픈 에러 ?? $i ${SerialPort.lastError}');
  //       Get.find<LogListController>().logData.add('Viz Comport Error');
  //     }
  //     if (!VizCtrl.to.vizChannel[i].port.isOpen) {
  //       Get.find<LogListController>().logData.add('Check VIZ${i + 1} port');
  //     }
  //   }
  //   return 1;
  // }

  int calcCheckSum(List<int> data) {
    int sum = 0;
    for (var i = 0; i < data.length; i++) {
      sum += data[i];
    }

    return sum & 0xff;
  }

  validity(Uint8List data, int portIdx) async {
    if (data.isEmpty) return;
    const int receiveLength = 79;
    int startDataIdx = 5 + 32;
    List<int> _b = [];
    List<int> _bb = [];
    if (buffer[portIdx].isNotEmpty) {
      _b.addAll(buffer[portIdx]);
      _b.addAll(data.toList());
    } else {
      _b = data.toList();
    }
    print('receivedata: $_b');

    if (_b[0] != 0x16) {
      buffer[portIdx] = [];
      print('시작 0x16 아님');
      return;
    }
    if (_b.length < receiveLength) {
      if (_b.length >= 4) {
        if (_b[0] == 0x16 && _b[1] == 0x16 && _b[2] == 0x30 && _b[3] == 0x03) {
          buffer[portIdx].addAll(data.toList());
          return;
        } else {
          buffer[portIdx] = [];
          return;
        }
      } else {
        buffer[portIdx].addAll(data.toList());
        return;
      }
    } else if (_b.length > receiveLength) {
      _bb = _b.sublist(receiveLength, _b.length);
      _b = _b.sublist(0, receiveLength);
      print('$receiveLength자보다 커서 잘랐어 $_bb ${_b.length}');
    } else {}

    if (!(_b[0] == 0x16 && _b[1] == 0x16 && _b[2] == 0x30 && _b[3] == 0x03)) {
      print('헤더가 이상있어요');
      buffer[portIdx] = [];
      return;
    }
    if (_b[receiveLength - 1] != 0x1a) {
      print('마지막이 이상있어요');
      buffer[portIdx] = [];
      return;
    }
    final int cs = calcCheckSum(_b.sublist(2, _b.length - 2));
    print('cs $cs');
    if (cs != _b[receiveLength - 2]) {
      print('체크섬이 이상있어요');
      buffer[portIdx] = [];
      return;
    }

    vizChannel[portIdx].vizData.freq = Uint8List.fromList(_b)
        .sublist(startDataIdx, startDataIdx += 4)
        .buffer
        .asByteData()
        .getFloat32(0, Endian.little);
    vizChannel[portIdx].vizData.p_dlv = Uint8List.fromList(_b)
        .sublist(startDataIdx, startDataIdx += 4)
        .buffer
        .asByteData()
        .getFloat32(0, Endian.little);
    vizChannel[portIdx].vizData.v = Uint8List.fromList(_b)
        .sublist(startDataIdx, startDataIdx += 4)
        .buffer
        .asByteData()
        .getFloat32(0, Endian.little);
    vizChannel[portIdx].vizData.i = Uint8List.fromList(_b)
        .sublist(startDataIdx, startDataIdx += 4)
        .buffer
        .asByteData()
        .getFloat32(0, Endian.little);
    vizChannel[portIdx].vizData.r = Uint8List.fromList(_b)
        .sublist(startDataIdx, startDataIdx += 4)
        .buffer
        .asByteData()
        .getFloat32(0, Endian.little);
    vizChannel[portIdx].vizData.x = Uint8List.fromList(_b)
        .sublist(startDataIdx, startDataIdx += 4)
        .buffer
        .asByteData()
        .getFloat32(0, Endian.little);
    vizChannel[portIdx].vizData.phase = Uint8List.fromList(_b)
        .sublist(startDataIdx, startDataIdx += 4)
        .buffer
        .asByteData()
        .getFloat32(0, Endian.little);

    print('$receiveLength자와 같아 $_b');

    buffer[portIdx] = _bb;
  }

  Future<void> readSerial(Timer timer) async {
    for (var i = 0; i < 5; i++) {
      if (iniController.to.vizComport[i] != 0 &&
          iniController.to.vizComport[i] != -1) {
        print('object');
        await sendRead();
      }
      if (iniController.to.vizComport[i] == -1) {
        vizChannel[i].vizData.freq = setRandom() + 1405900;
        vizChannel[i].vizData.p_dlv = setRandom() + 40;
        vizChannel[i].vizData.v = setRandom() + 120;
        vizChannel[i].vizData.i = setRandom() - 10;
        vizChannel[i].vizData.r = setRandom() - 10;
        vizChannel[i].vizData.x = setRandom() - 10;
        vizChannel[i].vizData.phase = setRandom() + 30;
      }
      if (iniController.to.vizComport[i] == 0) {
        vizChannel[i];
      }
    }
    // 측정한 data 값 요구
    // if (vizList.isNotEmpty) {
    //   vizUpdate();
    // }
    if (vizChannel.isNotEmpty) {
      vizUpdate();
    }
    update();
  }

  Future readData(Timer timer) async {
    for (var i = 0; i < 5; i++) {
      List<int> data = vizChannel[i].port.read(87);
      data.sublist(45, 49);
      double dataVal = Uint8List.fromList(data)
          .buffer
          .asByteData()
          .getFloat32(0, Endian.little);
      print(dataVal);
    }
  }

  Future sendStart() async {
    List<int> adfasdasf = [];
    adfasdasf.add(0x16);
    adfasdasf.add(0x16);
    adfasdasf.add(0x30);
    adfasdasf.add(0x04);
    adfasdasf.add(0x01);
    adfasdasf.add(0x01);
    adfasdasf.add(0x36);
    adfasdasf.add(0x1a); //이미 컴퓨터 언어니까  encoding 할 필요 없는거넹
    final bytes = Uint8List.fromList(adfasdasf);
    for (var i = 0; i < 5; i++) {
      if (vizChannel[i].port.isOpen) vizChannel[i].port.write(bytes);
    }
  }

  Future sendRead() async {
    List<int> adfasdasf = [];
    adfasdasf.add(0x16);
    adfasdasf.add(0x16);
    adfasdasf.add(0x30);
    adfasdasf.add(0x03);
    adfasdasf.add(0x00);
    adfasdasf.add(0x33);
    adfasdasf.add(0x1a);
    final bytes = Uint8List.fromList(adfasdasf);
    for (var i = 0; i < 5; i++) {
      if (vizChannel[i].port.isOpen) vizChannel[i].port.write(bytes);
    }
  }
}
