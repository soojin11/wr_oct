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

class VizCtrl extends GetxController {
  static VizCtrl get to => Get.find();
  late Isolate isolate;
  SendPort? isendPort;

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
        if (data.v.data.isNotEmpty) {
          final i = (data).idx;
          (vizCtrl as VizCtrl).vizChannel[i].vizData.freq = data.v.data[0];
          vizCtrl.vizChannel[i].vizData.p_dlv = data.v.data[1];
          vizCtrl.vizChannel[i].vizData.v = data.v.data[2];
          vizCtrl.vizChannel[i].vizData.i = data.v.data[3];
          vizCtrl.vizChannel[i].vizData.r = data.v.data[4];
          vizCtrl.vizChannel[i].vizData.x = data.v.data[5];
          vizCtrl.vizChannel[i].vizData.phase = data.v.data[6];

          // vizCtrl.vizUpdate(i);
        }
      } else if (data is bool) {
        isolate.kill(priority: Isolate.immediate);
      }
    });
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
    debugPrint('vizComPort : ${loadConfig.vizConfig.VizComPort}');
    List<SerialPort> serial = [];

    for (var i = 0; i < 5; i++) {
      final comPort = loadConfig.vizConfig.VizComPort[i];
      serialConnect(comPort);
      debugPrint('comPort: $comPort');
      serial.add(SerialPort('COM${comPort}'));
      List<int> sendDataS = [];
      sendDataS.add(0x16);
      sendDataS.add(0x16);
      sendDataS.add(0x30);
      sendDataS.add(0x04);
      sendDataS.add(0x01);
      sendDataS.add(0x01);
      sendDataS.add(0x36);
      sendDataS.add(0x1a);
      final bytesS = Uint8List.fromList(sendDataS);
      if (serial[i].openReadWrite()) {
        serial[i].write(bytesS);
        debugPrint('오픈 성공 i $i $comPort');
        await SerialPortReader(serial[i]).stream.listen((data) async {
          checkValidity(data);
          IsolateReceiveData iRD = IsolateReceiveData(
              idx: i,
              sendPort: iSD.sendPort,
              v: VizSerialData(
                  comPort: iSD.vizSerialData[i].comPort,
                  simulation: iSD.vizSerialData[i].simulation,
                  data: showData));
          if (showData.length == 7) iSD.sendPort.send(iRD);
        });
      }

      Timer.periodic(Duration(milliseconds: loadConfig.vizConfig.interval ~/ 3),
          (timer) async {
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
        } else if (loadConfig.vizConfig.VizComPort[i] == -1) {
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
        } else if (loadConfig.vizConfig.VizComPort[i] == 0) {
          IsolateReceiveData iRD = IsolateReceiveData(
              idx: i,
              sendPort: iSD.sendPort,
              v: VizSerialData(
                  comPort: iSD.vizSerialData[i].comPort,
                  simulation: iSD.vizSerialData[i].simulation,
                  data: []));

          iSD.sendPort.send(iRD);
        }
      });
      // }
    }
    port.listen((msg) {
      debugPrint('msg $msg');
      if (msg is bool) test = true;
    });
    // iSD.sendPort.send(isendData);
  }

  isolateStop() {
    isendPort?.send(true);
  }

  RxList<VizChannel> vizChannel = RxList.empty();
  RxList<VizSeries> vizSeries = RxList.empty();
  int numOfViz = 7;
  RxString selected = "OES".obs;
  var dropItem = ['OES', 'VIZ'];
  RxList<RxList<RxList<FlSpot>>> vizPoints = RxList.empty();
  RxDouble step = (iniController.to.viz_Interval.value / 1000).obs;
  RxDouble chartMaxX = 100.0.obs;
  double fixedMaxX = 100;
  RxDouble chartMinX = 0.0.obs;
  late RxDouble minX;
  late RxDouble maxX;
  RxBool showAll = false.obs;
  Timer? chartTimer;
  Timer? saveTimer;

  Future chartInit() async {
    chartMinX.value = 0;
    chartMaxX.value = 100;
    vizPoints.clear();
    for (var i = 0; i < 5; i++) {
      vizPoints.add(RxList.empty());
      vizChannel[i].xValue = 0;
      for (var ii = 0; ii < 7; ii++) {
        vizPoints[i].add(RxList.empty());
      }
    }
    update();
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
          xValue: 0.0,
          toggle: true.obs,
          vizData: VizData.init(),
          saveData: []));
      for (var i = 0; i < 7; i++) {
        vizSeries.add(VizSeries(toggle: true.obs));
      }
    }
  }

  void chartViz(Timer timer) async {
    List<String> forCsv = [];
    for (var i = 0; i < 5; i++) {
      while (vizPoints[i][0].length >
          fixedMaxX * (1000 / iniController.to.viz_Interval.value)) {
        for (var ii = 0; ii < 7; ii++) {
          vizPoints[i][ii].removeAt(0);
        }
      }
      vizPoints[i][0].add(
          FlSpot(vizChannel[i].xValue, vizChannel[i].vizData.freq / 1000000));
      vizPoints[i][1]
          .add(FlSpot(vizChannel[i].xValue, vizChannel[i].vizData.p_dlv * 2));
      vizPoints[i][2]
          .add(FlSpot(vizChannel[i].xValue, vizChannel[i].vizData.v));
      vizPoints[i][3]
          .add(FlSpot(vizChannel[i].xValue, vizChannel[i].vizData.i * 10));
      vizPoints[i][4]
          .add(FlSpot(vizChannel[i].xValue, vizChannel[i].vizData.r * 10));
      vizPoints[i][5]
          .add(FlSpot(vizChannel[i].xValue, vizChannel[i].vizData.x * 10));
      vizPoints[i][6].add(FlSpot(
          vizChannel[i].xValue, vizChannel[i].vizData.phase * 1000 / 360));
      if (vizChannel[i].xValue > chartMaxX.value) {
        chartMinX.value += step.value;
        chartMaxX.value += step.value;
      }
      vizChannel[i].xValue += step.value;
    }
    if (CsvController.to.csvSaveInit.value) {
      for (var i = 0; i < 5; i++) {
        forCsv.add(vizChannel[i].vizData.freq.toStringAsFixed(2));
        forCsv.add(vizChannel[i].vizData.p_dlv.toStringAsFixed(2));
        forCsv.add(vizChannel[i].vizData.v.toStringAsFixed(2));
        forCsv.add(vizChannel[i].vizData.i.toStringAsFixed(2));
        forCsv.add(vizChannel[i].vizData.r.toStringAsFixed(2));
        forCsv.add(vizChannel[i].vizData.x.toStringAsFixed(2));
        forCsv.add(vizChannel[i].vizData.phase.toStringAsFixed(2));
      }
      if (forCsv.isNotEmpty) {
        CsvController.to.vizDataSave(data: forCsv);
      }
    }
  }
}
