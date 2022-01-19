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
import 'package:wr_ui/view/right_side_menu/start_stop.dart';

List<List<int>> buffer = [];
int calcCheckSum(List<int> data) {
  int sum = 0;
  for (var i = 0; i < data.length; i++) {
    sum += data[i];
  }

  return sum & 0xff;
}

validity(Uint8List data, int portIdx) async {
  List<VizChannel> vizChannel = [];
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

void isolatedViz() async {
  ReceivePort receivePort = ReceivePort();
  await Isolate.spawn(startViz, receivePort.sendPort);
  receivePort.listen((data) async {
    List aa = [];
    aa.assignAll(data);

    debugPrint('들어오는 데이터 $aa');
  });
}

void startViz(SendPort sendPort) async {
  // VizCtrl vizCtrl = VizCtrl();
  // VizChannel vizChannel;
  List<VizChannel> vizChannel = [];
  List<VizSeries> vizSeries = [];
  iniController iniCtrl = iniController();
  serialConnect = wgsFunction
      .lookup<NativeFunction<Int32 Function(Int32)>>("serialConnect")
      .asFunction();

  vizChannel.clear();
  // for (var i = 0; i < 5; i++) {
  //   if (iniCtrl.vizComport[i] > 0) serialConnect(iniCtrl.vizComport[i]);
  //   buffer.add([]);
  //   vizChannel.add(VizChannel(
  //       toggle: true.obs,
  //       vizData: VizData.init(),
  //       port: SerialPort('COM${iniCtrl.vizComport[i]}')));
  //   vizChannel[i].port.config.baudRate = 115200;
  // }
  for (var i = 0; i < 7; i++) {
    vizSeries.add(VizSeries(toggle: true.obs));
  }

  for (var i = 0; i < 5; i++) {
    debugPrint('startSerial i $i');

    // if (vizChannel[i].port.openReadWrite()) {
    //   debugPrint('오픈 성공 i $i ${vizChannel[i].port.name}');
    //   await SerialPortReader(vizChannel[i].port).stream.listen((aaa) async {
    //     List asdf = [];
    //     debugPrint('listen i : $i data : $aaa');
    //     await validity(aaa, i);
    //     asdf.add(vizChannel[i].vizData.freq);
    //     asdf.add(vizChannel[i].vizData.p_dlv);
    //     asdf.add(vizChannel[i].vizData.v);
    //     asdf.add(vizChannel[i].vizData.i);
    //     asdf.add(vizChannel[i].vizData.r);
    //     asdf.add(vizChannel[i].vizData.x);
    //     asdf.add(vizChannel[i].vizData.phase);
    //     sendPort.send(asdf);
    //   });
    // } else {
    //   debugPrint('오픈 실패 i $i');
    // }
    // vizCtrl.sendRead();
    debugPrint('startViz');
  }
  // sendPort.send(aaa);
}

class VizCtrl extends GetxController {
  static VizCtrl get to => Get.find();
  late Isolate isolate;
  late SendPort isendPort;

  //late ReceivePort

  isolateStart(vizCtrl, iniCtrl) async {
    ReceivePort receivePort = ReceivePort();
    List<VizSerialData> v = List.filled(5, VizSerialData.init());
    for (var i = 0; i < (iniCtrl as iniController).vizComport.length; i++) {
      v[i].comPort = iniCtrl.vizComport[i];
    }
    IsolateSendData iSD =
        IsolateSendData(sendPort: receivePort.sendPort, vizSerialData: v);
    isolate = await Isolate.spawn(serialReceive, iSD);
    receivePort.listen((data) async {
      if (data is SendPort) {
        isendPort = data;
      } else if (data is IsolateReceiveData) {
        final i = (data).idx;
        debugPrint('data ${data.v.data}');
        (vizCtrl as VizCtrl).vizChannel[i].vizData.freq = data.v.data[0];
        vizCtrl.vizChannel[i].vizData.p_dlv = data.v.data[1];
        vizCtrl.vizChannel[i].vizData.v = data.v.data[2];
        vizCtrl.vizChannel[i].vizData.i = data.v.data[3];
        vizCtrl.vizChannel[i].vizData.r = data.v.data[4];
        vizCtrl.vizChannel[i].vizData.x = data.v.data[5];
        vizCtrl.vizChannel[i].vizData.phase = data.v.data[6];
        vizCtrl.vizUpdate();
      } else if (data is bool) {
        isolate.kill(priority: Isolate.immediate);
      } else {
        // for (var i = 0; i < 5; i++) {
        // (ctrl as VizCtrl).vizChannel.add(VizChannel(
        //     toggle: true.obs,
        //     vizData: VizData.init(),
        //     // port num 바꿔야돼 iniCtrl에 있는거 viz로 옮겨
        //     port: SerialPort('COM${i}')));
        // (ctrl as OesController).oesData[0].oesToggle.value =
        // !ctrl.oesData[0].oesToggle.value;
        // ctrl.vizChannel[i].vizData.freq = data.vizSerialData[i].data[0];
        // ctrl.vizChannel[i].vizData.p_dlv = data.vizSerialData[i].data[1];
        // ctrl.vizChannel[i].vizData.v = data.vizSerialData[i].data[2];
        // ctrl.vizChannel[i].vizData.i = data.vizSerialData[i].data[3];
        // ctrl.vizChannel[i].vizData.r = data.vizSerialData[i].data[4];
        // ctrl.vizChannel[i].vizData.x = data.vizSerialData[i].data[5];
        // ctrl.vizChannel[i].vizData.phase = data.vizSerialData[i].data[6];
        // debugPrint(
        //     'isolateStart listen $ii ${data.vizSerialData[0].data[ii]}');
        // }
        //여기 타이머 돌려야 값이 갱신될거같은데..

      }
      // debugPrint('채널 ${ctrl.vizChannel[0].vizData}');
      // debugPrint('리슨 데이터 ${data.vizSerialData[0].data}');
    });
    // bb.assignAll(data);
  }

  static void serialReceive(IsolateSendData iSD) async {
    bool test = false;
    // dll링크 serialConnect
    var port = ReceivePort();
    iSD.sendPort.send(port.sendPort);
    serialConnect = wgsFunction
        .lookup<NativeFunction<Int32 Function(Int32)>>("serialConnect")
        .asFunction();
    IsolateSendData isendData = IsolateSendData(
        sendPort: iSD.sendPort, vizSerialData: iSD.vizSerialData);
    // serialConnect() 함수실행하고

// SerialPort initial
    debugPrint('vizComPort : ${loadConfig.vizConfig.VizComPort}');
    List<SerialPort> serial = [];

    for (var i = 0; i < 5; i++) {
      final comPort = loadConfig.vizConfig.VizComPort[i];
      serialConnect(comPort);
      debugPrint('comPort: $comPort');
      serial.add(SerialPort('COM${comPort}'));
      // SerialPort Open
      List<int> sendDataS = [];
      sendDataS.add(0x16);
      sendDataS.add(0x16);
      sendDataS.add(0x30);
      sendDataS.add(0x04);
      sendDataS.add(0x01);
      sendDataS.add(0x01);
      sendDataS.add(0x36);
      sendDataS.add(0x1a); //이미 컴퓨터 언어니까  encoding 할 필요 없는거넹
      final bytesS = Uint8List.fromList(sendDataS);
      if (serial[i].isOpen) serial[i].write(bytesS);
      //
      if (serial[i].openReadWrite()) {
        debugPrint('오픈 성공 i $i $comPort');
        await SerialPortReader(serial[i]).stream.listen((data) async {
          //debugPrint('listen $comPort / $data');
          //유효성검사 if portNum > 0
          await checkValidity(data);
          IsolateReceiveData iRD = IsolateReceiveData(
              idx: i,
              sendPort: iSD.sendPort,
              v: VizSerialData(
                  comPort: iSD.vizSerialData[i].comPort,
                  simulation: iSD.vizSerialData[i].simulation,
                  data: showData));
          // isendData.vizSerialData[0].data[0] = 123.123;

          // if (showData.length == 7) {
          //   for (var i = 0; i < 7; i++) {
          //     isendData.vizSerialData[i].data[i] = showData[i];
          //   }
          // }
          if (showData.length == 7) iSD.sendPort.send(iRD);
        });
      }
      //sendStart

      Timer.periodic(Duration(milliseconds: loadConfig.vizConfig.interval),
          (timer) async {
        //comport != 0 && comport != -1 일때만 보내 => json read
        if (test) {
          for (var item in serial) {
            item.close();
          }

          debugPrint('stop');
          iSD.sendPort.send(true);
        }

        if (loadConfig.vizConfig.VizComPort[i] > 0) {
          List<int> sendDataR = [];
          sendDataR.add(0x16);
          sendDataR.add(0x16);
          sendDataR.add(0x30);
          sendDataR.add(0x03);
          sendDataR.add(0x00);
          sendDataR.add(0x33);
          sendDataR.add(0x1a);
          final bytesR = Uint8List.fromList(sendDataR);
          //for i<5
          if (serial[i].isOpen) serial[i].write(bytesR);
        }
        //comport == -1 일 때 랜덤 데이터 넣기
        //isendData.vizSerialData[0].data[i] == setRandom();
        //얘도 타이머안에 넣어야돼
        if (loadConfig.vizConfig.VizComPort[i] == -1) {
          IsolateReceiveData iRD = IsolateReceiveData(
              idx: i,
              sendPort: iSD.sendPort,
              v: VizSerialData(
                  comPort: iSD.vizSerialData[i].comPort,
                  simulation: iSD.vizSerialData[i].simulation,
                  data: [
                    math.Random().nextInt(100).toDouble() + 1405900,
                    math.Random().nextInt(20).toDouble() + 40,
                    math.Random().nextInt(20).toDouble() + 120,
                    math.Random().nextInt(10).toDouble() + 120,
                    math.Random().nextInt(10).toDouble() + 120,
                    math.Random().nextInt(10).toDouble() + 120,
                    math.Random().nextInt(20).toDouble() + 30,
                  ]));

          iSD.sendPort.send(iRD);
        }
        if (loadConfig.vizConfig.VizComPort[i] == 0) {
          IsolateReceiveData iRD = IsolateReceiveData(
              idx: i,
              sendPort: iSD.sendPort,
              v: VizSerialData(
                  comPort: iSD.vizSerialData[i].comPort,
                  simulation: iSD.vizSerialData[i].simulation,
                  data: []));

          iSD.sendPort.send(iRD);
        }
        // else if (loadConfig.vizConfig.VizComPort[i] == 0) {}
        //comport == 0 이면 데이터 없음}
      });
    }
    port.listen((msg) {
      debugPrint('msg $msg');
      if (msg is bool) test = true;
    });
    // iSD.sendPort.send(isendData);
  }

  isolateStop() {
    isendPort.send(true);
  }

  RxList<VizChannel> vizChannel = RxList.empty();
  RxList<VizSeries> vizSeries = RxList.empty();
  Timer? timer;
  int numOfViz = 7;
  // List<List<int>> buffer = [];
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
///////////////////////////////////////
    //isolate Test
    vizChannel.clear();
    for (var i = 0; i < 5; i++) {
      if (Get.find<iniController>().vizComport[i] > 0)
        serialConnect(Get.find<iniController>().vizComport[i]);
      buffer.add([]);

      vizChannel.add(VizChannel(
        toggle: true.obs,
        vizData: VizData.init(),
//          port: SerialPort('COM${Get.find<iniController>().vizComport[i]}'))
      ));

///////////////////////////////////////

      for (var i = 0; i < 7; i++) {
        vizSeries.add(VizSeries(toggle: true.obs));
      }
    }
  }

  Future<void> vizUpdate() async {
    List forCsv = [];
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
      forCsv.add(vizChannel[i].vizData.freq.toStringAsFixed(2));
      forCsv.add(vizChannel[i].vizData.p_dlv.toStringAsFixed(2));
      forCsv.add(vizChannel[i].vizData.v.toStringAsFixed(2));
      forCsv.add(vizChannel[i].vizData.i.toStringAsFixed(2));
      forCsv.add(vizChannel[i].vizData.r.toStringAsFixed(2));
      forCsv.add(vizChannel[i].vizData.x.toStringAsFixed(2));
      forCsv.add(vizChannel[i].vizData.phase.toStringAsFixed(2));

      // print('asdf${aaa}');

    }

    if (Get.find<CsvController>().csvSaveInit.value) {
      Get.find<CsvController>().vizDataSave(data: forCsv);
    }
    if (xValue.value > chartMaxX.value) {
      chartMinX.value += step.value;
      chartMaxX.value += step.value;
    }
    xValue.value += step.value;

    update();
  }

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

  // int calcCheckSum(List<int> data) {
  //   int sum = 0;
  //   for (var i = 0; i < data.length; i++) {
  //     sum += data[i];
  //   }

  //   return sum & 0xff;
  // }

  // validity(Uint8List data, int portIdx) async {
  //   if (data.isEmpty) return;
  //   const int receiveLength = 79;
  //   int startDataIdx = 5 + 32;
  //   List<int> _b = [];
  //   List<int> _bb = [];
  //   if (buffer[portIdx].isNotEmpty) {
  //     _b.addAll(buffer[portIdx]);
  //     _b.addAll(data.toList());
  //   } else {
  //     _b = data.toList();
  //   }
  //   print('receivedata: $_b');

  //   if (_b[0] != 0x16) {
  //     buffer[portIdx] = [];
  //     print('시작 0x16 아님');
  //     return;
  //   }
  //   if (_b.length < receiveLength) {
  //     if (_b.length >= 4) {
  //       if (_b[0] == 0x16 && _b[1] == 0x16 && _b[2] == 0x30 && _b[3] == 0x03) {
  //         buffer[portIdx].addAll(data.toList());
  //         return;
  //       } else {
  //         buffer[portIdx] = [];
  //         return;
  //       }
  //     } else {
  //       buffer[portIdx].addAll(data.toList());
  //       return;
  //     }
  //   } else if (_b.length > receiveLength) {
  //     _bb = _b.sublist(receiveLength, _b.length);
  //     _b = _b.sublist(0, receiveLength);
  //     print('$receiveLength자보다 커서 잘랐어 $_bb ${_b.length}');
  //   } else {}

  //   if (!(_b[0] == 0x16 && _b[1] == 0x16 && _b[2] == 0x30 && _b[3] == 0x03)) {
  //     print('헤더가 이상있어요');
  //     buffer[portIdx] = [];
  //     return;
  //   }
  //   if (_b[receiveLength - 1] != 0x1a) {
  //     print('마지막이 이상있어요');
  //     buffer[portIdx] = [];
  //     return;
  //   }
  //   final int cs = calcCheckSum(_b.sublist(2, _b.length - 2));
  //   print('cs $cs');
  //   if (cs != _b[receiveLength - 2]) {
  //     print('체크섬이 이상있어요');
  //     buffer[portIdx] = [];
  //     return;
  //   }

  //   vizChannel[portIdx].vizData.freq = Uint8List.fromList(_b)
  //       .sublist(startDataIdx, startDataIdx += 4)
  //       .buffer
  //       .asByteData()
  //       .getFloat32(0, Endian.little);
  //   vizChannel[portIdx].vizData.p_dlv = Uint8List.fromList(_b)
  //       .sublist(startDataIdx, startDataIdx += 4)
  //       .buffer
  //       .asByteData()
  //       .getFloat32(0, Endian.little);
  //   vizChannel[portIdx].vizData.v = Uint8List.fromList(_b)
  //       .sublist(startDataIdx, startDataIdx += 4)
  //       .buffer
  //       .asByteData()
  //       .getFloat32(0, Endian.little);
  //   vizChannel[portIdx].vizData.i = Uint8List.fromList(_b)
  //       .sublist(startDataIdx, startDataIdx += 4)
  //       .buffer
  //       .asByteData()
  //       .getFloat32(0, Endian.little);
  //   vizChannel[portIdx].vizData.r = Uint8List.fromList(_b)
  //       .sublist(startDataIdx, startDataIdx += 4)
  //       .buffer
  //       .asByteData()
  //       .getFloat32(0, Endian.little);
  //   vizChannel[portIdx].vizData.x = Uint8List.fromList(_b)
  //       .sublist(startDataIdx, startDataIdx += 4)
  //       .buffer
  //       .asByteData()
  //       .getFloat32(0, Endian.little);
  //   vizChannel[portIdx].vizData.phase = Uint8List.fromList(_b)
  //       .sublist(startDataIdx, startDataIdx += 4)
  //       .buffer
  //       .asByteData()
  //       .getFloat32(0, Endian.little);

  //   print('$receiveLength자와 같아 $_b');

  //   buffer[portIdx] = _bb;
  // }

  // Future<void> readSerial(Timer timer) async {
  //   for (var i = 0; i < 5; i++) {
  //     if (iniController.to.vizComport[i] != 0 &&
  //         iniController.to.vizComport[i] != -1) {
  //       // debugPrint('sendRead');
  //       await sendRead();
  //     }
  //     if (iniController.to.vizComport[i] == -1) {
  //       vizChannel[i].vizData.freq = setRandom() + 1405900;
  //       vizChannel[i].vizData.p_dlv = setRandom() + 40;
  //       vizChannel[i].vizData.v = setRandom() + 120;
  //       vizChannel[i].vizData.i = setRandom() - 10;
  //       vizChannel[i].vizData.r = setRandom() - 10;
  //       vizChannel[i].vizData.x = setRandom() - 10;
  //       vizChannel[i].vizData.phase = setRandom() + 30;
  //     }
  //     if (iniController.to.vizComport[i] == 0) {
  //       vizChannel[i];
  //     }
  //   }
  //   // 측정한 data 값 요구
  //   // if (vizList.isNotEmpty) {
  //   //   vizUpdate();
  //   // }
  //   if (vizChannel.isNotEmpty) {
  //     vizUpdate();
  //   }
  //   update();
  // }

  // Future readData(Timer timer) async {
  //   for (var i = 0; i < 5; i++) {
  //     List<int> data = vizChannel[i].port.read(87);
  //     data.sublist(45, 49);
  //     double dataVal = Uint8List.fromList(data)
  //         .buffer
  //         .asByteData()
  //         .getFloat32(0, Endian.little);
  //     print(dataVal);
  //   }
  // }

  // Future sendStart() async {
  //   List<int> adfasdasf = [];
  //   adfasdasf.add(0x16);
  //   adfasdasf.add(0x16);
  //   adfasdasf.add(0x30);
  //   adfasdasf.add(0x04);
  //   adfasdasf.add(0x01);
  //   adfasdasf.add(0x01);
  //   adfasdasf.add(0x36);
  //   adfasdasf.add(0x1a); //이미 컴퓨터 언어니까  encoding 할 필요 없는거넹
  //   final bytes = Uint8List.fromList(adfasdasf);
  //   for (var i = 0; i < 5; i++) {
  //     if (vizChannel[i].port.isOpen) vizChannel[i].port.write(bytes);
  //   }
  // }

  // Future sendRead() async {
  //   List<int> adfasdasf = [];
  //   adfasdasf.add(0x16);
  //   adfasdasf.add(0x16);
  //   adfasdasf.add(0x30);
  //   adfasdasf.add(0x03);
  //   adfasdasf.add(0x00);
  //   adfasdasf.add(0x33);
  //   adfasdasf.add(0x1a);
  //   final bytes = Uint8List.fromList(adfasdasf);
  //   for (var i = 0; i < 5; i++) {
  //     if (vizChannel[i].port.isOpen) vizChannel[i].port.write(bytes);
  //   }
  // }
}
