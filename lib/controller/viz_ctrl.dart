import 'dart:async';
import 'dart:typed_data';
import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';
import 'package:libserialport/libserialport.dart';
import 'package:wr_ui/model/viz_data.dart';
import 'dart:math' as math;

class VizCtrl extends GetxController {
  static VizCtrl get to => Get.find();
  RxList<bool> vizCheckVal = [true, true, true, true, true, true, true].obs;
  RxList<bool> selectVizChannel = [true, true, true, true, true].obs;
  RxList<VizChannel> vizChannel = RxList.empty();
  RxBool isStart = false.obs;
  Timer? timer;
  int numOfViz = 7;
  List<int> buffer = [];
  RxList<double> cutData = RxList.empty();
  Rx<VizData> vizData = VizData.init().obs;

  //////////////차트ctrl///////////////
  RxList<List<FlSpot>> vizSimVal = RxList.empty();
  RxList<List<FlSpot>> vizVal1 = RxList.empty();
  RxList<List<FlSpot>> vizVal2 = RxList.empty();
  RxList<List<FlSpot>> vizVal3 = RxList.empty();
  RxList<List<FlSpot>> vizVal4 = RxList.empty();
  RxList<List<FlSpot>> vizVal5 = RxList.empty();
  RxDouble step = 1.0.obs;
  RxDouble chartMaxX = 800.0.obs;
  RxDouble chartMinX = 0.0.obs;
  late RxDouble minX;
  late RxDouble maxX;
  RxDouble xValue = 0.0.obs;
  RxDouble yValue = 0.0.obs;
  // RxList<FlSpot> vizBuffer = RxList.empty();
  late Timer vizChartTimer;

  double setRandom() {
    double yValue = math.Random().nextInt(10).toDouble();
    return yValue;
  }

  ///////////////////////////////////////

  Future<void> init() async {
    vizChannel.clear();
    vizChannel
        .add(VizChannel(vizData: VizData.init(), port: SerialPort('COM4')));
    // vizSimVal.clear();
    // vizSimVal.add(FlSpot(0, 0));
    // Get.find<OesController>().oesData.clear();
    // Get.find<OesController>().oesData[0].add(FlSpot(0, 0));
  }

  Future<void> vizUpdate(Timer vizChartTimer) async {
    // for (var i = 0; i < numOfViz; i++) {
    //   vizVal[i].add(FlSpot(xValue.value++, cutData[i]));
    // }
    //VIZ_1
    vizVal1[0].add(FlSpot(xValue.value++, cutData[0] / 1000000));
    vizVal1[1].add(FlSpot(xValue.value++, cutData[1]));
    vizVal1[2].add(FlSpot(xValue.value++, cutData[2] / 10));
    vizVal1[3].add(FlSpot(xValue.value++, cutData[3] * 10));
    vizVal1[4].add(FlSpot(xValue.value++, cutData[4]));
    vizVal1[5].add(FlSpot(xValue.value++, cutData[5]));
    vizVal1[6].add(FlSpot(xValue.value++, cutData[6]));
    if (xValue.value > chartMaxX.value) {
      chartMinX.value += step.value;
      chartMaxX.value += step.value;
    }
    update();
  }

  Future<void> vizSimUpdate(Timer timer) async {
    // for (var i = 0; i < numOfViz; i++) {
    //   vizVal[i].add(FlSpot(xValue.value++, setRandom()));
    // }
    vizVal1[0].add(
        FlSpot(xValue.value++, (setRandom() + 14000000) / 10000000)); //freq
    vizVal1[1].add(FlSpot(xValue.value++, (setRandom() + 57) / 100)); //p_div
    vizVal1[2].add(FlSpot(xValue.value++, (setRandom() + 50) / 100)); //v
    vizVal1[3].add(FlSpot(xValue.value++, setRandom() / 10)); //i
    vizVal1[4].add(FlSpot(xValue.value++, setRandom() / 10)); //r
    vizVal1[5].add(FlSpot(xValue.value++, setRandom() / 10)); //x
    vizVal1[6].add(FlSpot(xValue.value++, (setRandom() + 50) / 100)); //phase
    //2
    vizVal2[0].add(
        FlSpot(xValue.value++, (setRandom() + 14000000) / 10000000)); //freq
    vizVal2[1].add(FlSpot(xValue.value++, (setRandom() + 57) / 100)); //p_div
    vizVal2[2].add(FlSpot(xValue.value++, (setRandom() + 50) / 100)); //v
    vizVal2[3].add(FlSpot(xValue.value++, setRandom() / 10)); //i
    vizVal2[4].add(FlSpot(xValue.value++, setRandom() / 10)); //r
    vizVal2[5].add(FlSpot(xValue.value++, setRandom() / 10)); //x
    vizVal2[6].add(FlSpot(xValue.value++, (setRandom() + 50) / 100)); //phase
    //3
    vizVal3[0].add(
        FlSpot(xValue.value++, (setRandom() + 14000000) / 10000000)); //freq
    vizVal3[1].add(FlSpot(xValue.value++, (setRandom() + 57) / 100)); //p_div
    vizVal3[2].add(FlSpot(xValue.value++, (setRandom() + 50) / 100)); //v
    vizVal3[3].add(FlSpot(xValue.value++, setRandom() / 10)); //i
    vizVal3[4].add(FlSpot(xValue.value++, setRandom() / 10)); //r
    vizVal3[5].add(FlSpot(xValue.value++, setRandom() / 10)); //x
    vizVal3[6].add(FlSpot(xValue.value++, (setRandom() + 50) / 100)); //phase
    //4
    vizVal4[0].add(
        FlSpot(xValue.value++, (setRandom() + 14000000) / 10000000)); //freq
    vizVal4[1].add(FlSpot(xValue.value++, (setRandom() + 57) / 100)); //p_div
    vizVal4[2].add(FlSpot(xValue.value++, (setRandom() + 50) / 100)); //v
    vizVal4[3].add(FlSpot(xValue.value++, setRandom() / 10)); //i
    vizVal4[4].add(FlSpot(xValue.value++, setRandom() / 10)); //r
    vizVal4[5].add(FlSpot(xValue.value++, setRandom() / 10)); //x
    vizVal4[6].add(FlSpot(xValue.value++, (setRandom() + 50) / 100)); //phase
    //5
    vizVal5[0].add(
        FlSpot(xValue.value++, (setRandom() + 14000000) / 10000000)); //freq
    vizVal5[1].add(FlSpot(xValue.value++, (setRandom() + 57) / 100)); //p_div
    vizVal5[2].add(FlSpot(xValue.value++, (setRandom() + 50) / 100)); //v
    vizVal5[3].add(FlSpot(xValue.value++, setRandom() / 10)); //i
    vizVal5[4].add(FlSpot(xValue.value++, setRandom() / 10)); //r
    vizVal5[5].add(FlSpot(xValue.value++, setRandom() / 10)); //x
    vizVal5[6].add(FlSpot(xValue.value++, (setRandom() + 50) / 100)); //phase
    if (xValue.value > chartMaxX.value) {
      chartMinX.value += step.value;
      chartMaxX.value += step.value;
    }
    update();
  }

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
    if (cutData.isNotEmpty) {
      cutData.clear();
    }
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
    for (var i = 0; i < numOfViz; i++) {
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
    if (vizChannel[0].port.isOpen) {
      await sendRead();
    } // 측정한 data 값 요구
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

