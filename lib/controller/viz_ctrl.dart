import 'dart:async';
import 'dart:typed_data';
import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';
import 'package:libserialport/libserialport.dart';
import 'package:wr_ui/model/viz_data.dart';
import 'dart:math' as math;

import 'package:wr_ui/view/chart/oes_chart.dart';

class VizCtrl extends GetxController {
  static VizCtrl get to => Get.find();
  RxList<VizChannel> vizChannel = RxList.empty();
  RxBool isStart = false.obs;
  Timer? timer;
  List<int> buffer = [];
  List<double> cutData = [];
  RxList<List<FlSpot>> vizVal = RxList.empty();
  Rx<VizData> vizData = VizData.init().obs;

  //////////////차트ctrl///////////////
  RxList<FlSpot> vizSimVal = RxList.empty();
  RxList<FlSpot> vizBuffer = RxList.empty();
  double time = 0;
  late Timer vizChartTimer;
  double setRandom() {
    double yValue = math.Random().nextInt(500).toDouble();
    return yValue;
  }

  Future<void> vizUpdate(Timer vizChartTimer) async {
    vizSimVal.add(FlSpot(time++, setRandom()));

    // if (vizSimVal.length == 800) {
    //   vizSimVal.removeAt(0);
    //   vizBuffer.addAll(vizSimVal);
    // }
    // vizSimVal = vizBuffer;

    update();
  }
  ///////////////////////////////////////

  Future<void> init() async {
    vizChannel.clear();
    vizChannel
        .add(VizChannel(vizData: VizData.init(), port: SerialPort('COM4')));
    vizSimVal.clear();
    vizSimVal.add(FlSpot(0, 0));
    Get.find<OesController>().oesData.clear();
    Get.find<OesController>().oesData[0].add(FlSpot(0, 0));
  }

  Future<void> updateViz(Timer timer) async {}

  Future<int> startSerial() async {
    vizChannel[0].port.config.baudRate = 115200;

    if (vizChannel[0].port.openReadWrite()) {
      print('오픈 성공');
      final reader = SerialPortReader(vizChannel[0].port);

      // Uint8List data = vizChannel[0].port.read(200, timeout: 1);
      //await validity2(data);
      await reader.stream.listen((data) async {
        // try {
        await validity(data);
        // } catch (e) {
        //   print(e);
        // }
      });
    } else {
      print('오픈 에러 ?? ${SerialPort.lastError}');
    }
    return 1;
  }

  int calcCheckSum(List<int> data) {
    int sum = 0;
    for (var i = 0; i < data.length; i++) {
      sum += data[i];
    }

    return sum & 0xff;
  }

  validity(Uint8List data) async {
    if (data.isEmpty) return;
    const int receiveLength = 79;
    int startDataIdx = 5 + 32;
    List<int> _b = [];
    List<int> _bb = [];
    if (buffer.isNotEmpty) {
      _b.addAll(buffer);
      _b.addAll(data.toList());
    } else {
      _b = data.toList();
    }
    print('receivedata: $_b');

    if (_b[0] != 0x16) {
      buffer = [];
      // throw Failure('시작 0x16 아님');
      print('맨첨이 0x16이 아니에요');
      return;
    }
    if (_b.length < receiveLength) {
      if (_b.length >= 4) {
        if (_b[0] == 0x16 && _b[1] == 0x16 && _b[2] == 0x30 && _b[3] == 0x03) {
          buffer.addAll(data.toList());
          return;
        } else {
          buffer = [];
          return;
        }
      } else {
        buffer.addAll(data.toList());
        return;
      }
    } else if (_b.length > receiveLength) {
      _bb = _b.sublist(receiveLength, _b.length);
      _b = _b.sublist(0, receiveLength);
      print('$receiveLength자보다 커서 잘랐어 $_bb ${_b.length}');
    } else {
      //buffer = _b;
    }

    if (!(_b[0] == 0x16 && _b[1] == 0x16 && _b[2] == 0x30 && _b[3] == 0x03)) {
      //  throw Failure('헤더 이상');
      print('헤더가 이상있어요');
      buffer = [];
      return;
    }
    if (_b[receiveLength - 1] != 0x1a) {
      // throw Failure('마지막 이상');
      print('마지막이 이상있어요');
      buffer = [];
      return;
    }
    final int cs = calcCheckSum(_b.sublist(2, _b.length - 2));
    print('cs $cs');
    if (cs != _b[receiveLength - 2]) {
      // throw Failure('체크섬 이상');
      print('체크섬이 이상있어요');
      buffer = [];
      return;
    }
    //length == 87
    //freq = qwre
    //v = fwe
    for (var i = 0; i < 7; i++) {
      cutData.add((Uint8List.fromList(_b)
          .sublist(startDataIdx, startDataIdx += 4)
          .buffer
          .asByteData()
          .getFloat32(0, Endian.little)));
    }

    print('=================================================시작===');
    print(
        '=================================================Frequency : ${cutData[0]}');
    print(
        '=================================================P_div : ${cutData[1]}');
    print('=================================================V : ${cutData[2]}');
    print('=================================================I : ${cutData[3]}');
    print('=================================================R : ${cutData[4]}');
    print('=================================================X : ${cutData[5]}');
    print(
        '=================================================Phase : ${cutData[6]}');
    print('=================================================끝===');
    print('$receiveLength자와 같아 $_b');

    buffer = _bb;
  }

  Future<void> readSerial(Timer timer) async {
    if (vizChannel[0].port.isOpen) await sendRead(); // 측정한 data 값 요구
  }

  Future readData(Timer timer) async {
    List<int> data = vizChannel[0].port.read(87);
    data.sublist(45, 49);
    double dataVal = Uint8List.fromList(data)
        .buffer
        .asByteData()
        .getFloat32(0, Endian.little);
    print(dataVal);
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
    vizChannel[0].port.write(bytes);
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
    vizChannel[0].port.write(bytes);
  }
}

// class Failure {
//   final String message;
//   Failure(this.message);

//   @override
//   String toString() => message;
// }

