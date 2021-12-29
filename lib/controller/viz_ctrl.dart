import 'dart:async';
import 'dart:typed_data';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:libserialport/libserialport.dart';
import 'package:wr_ui/model/viz_data.dart';
import 'dart:math' as math;
import 'package:wr_ui/view/chart/pages/hover_chart/hover.dart';
import 'package:wr_ui/view/chart/viz_chart.dart';
import 'package:wr_ui/view/right_side_menu/csv_creator.dart';
import 'package:wr_ui/view/right_side_menu/save_ini.dart';

class VizCtrl extends GetxController {
  static VizCtrl get to => Get.find();
  RxList<bool> vizSeriesList = [true, true, true, true, true, true, true].obs;
  // RxList<bool> selectVizChannel = [true, true, true, true, true].obs;
  RxBool vizCheck1 = true.obs;
  RxBool vizCheck2 = true.obs;
  RxBool vizCheck3 = true.obs;
  RxBool vizCheck4 = true.obs;
  RxBool vizCheck5 = true.obs;
  RxList<VizChannel> vizChannel = RxList.empty();
  RxBool isStart = false.obs;
  Timer? timer;
  int numOfViz = 7;
  List<int> buffer = [];
  List<double> vizYValue = RxList.empty();
  Rx<VizData> vizData = VizData.init().obs;
  // RxBool sim = false.obs;
  RxString selected = "OES".obs;
  var dropItem = ['OES', 'VIZ', 'OES & VIZ'];

  //////////////차트ctrl///////////////

  RxList<List<FlSpot>> vizVal1 = RxList.empty();
  RxList<List<FlSpot>> vizVal2 = RxList.empty();
  RxList<List<FlSpot>> vizVal3 = RxList.empty();
  RxList<List<FlSpot>> vizVal4 = RxList.empty();
  RxList<List<FlSpot>> vizVal5 = RxList.empty();
  RxList<List<List<FlSpot>>> vizVal = RxList.empty();
  RxDouble step = 1.0.obs;
  RxDouble chartMaxX = 800.0.obs;
  RxDouble chartMinX = 0.0.obs;
  late RxDouble minX;
  late RxDouble maxX;
  RxDouble xValue = 0.0.obs;
  RxDouble yValue = 0.0.obs;
  RxInt chartNum = 0.obs;
  // RxList<FlSpot> vizBuffer = RxList.empty();
  Timer? vizChartTimer;

  double setRandom() {
    double yValue = math.Random().nextInt(10).toDouble();
    return yValue;
  }

  void setSelected(value) {
    selected.value = value;
  }

  ///////////////////////////////////////

  Future<void> init() async {
    vizChannel.clear();
    vizChannel.add(VizChannel(
        vizData: VizData.init(),
        port: SerialPort(Get.find<iniController>().viz_comport[0])));

    // vizVal1.clear();
    // for (var i = 0; i < numOfViz; i++) {
    //   vizVal1.add([]);
    // }
    // Get.find<OesController>().oesData.clear();
    // Get.find<OesController>().oesData[0].add(FlSpot(0, 0));
  }

  Future<void> vizUpdate(Timer vizChartTimer) async {
    // for (var i = 0; i < numOfViz; i++) {
    //   vizVal[i].add(FlSpot(xValue.value++, cutData[i]));
    // }
    //VIZ_1
    for (var i = 0; i < numOfViz; i++) {
      vizVal1[i].add(FlSpot(xValue.value++, vizYValue[i]));
    }
    if (Get.find<CsvController>().fileSave.value) {
      Get.find<CsvController>().vizDataSave();
    }
    for (var i = 0; i < 5; i++) {
      vizVal.add([]);
      for (var ii = 0; ii < 7; ii++) {
        vizVal[i].add([FlSpot(xValue.value++, vizYValue[i])]);
      }
    }

    // for (var i = 0; i < 5; i++) {
    //   value.add([]);
    //   for (var i = 0; i < 7; i++) {
    //     value[i].add()
    //   }
    // }

    // vizVal1[0].add(FlSpot(xValue.value++, vizYValue[0] / 1000000));
    // vizVal1[1].add(FlSpot(xValue.value++, (vizYValue[1] * 1000000) / 5));
    // vizVal1[2].add(FlSpot(xValue.value++, (vizYValue[2] * 100000) / 1.5));
    // vizVal1[3].add(FlSpot(xValue.value++, (vizYValue[3] * 10000000) / 3));
    // vizVal1[4].add(FlSpot(xValue.value++, (vizYValue[4] * 10000000) / 5.5));
    // vizVal1[5].add(FlSpot(xValue.value++, (vizYValue[5] * 10000000) / 9));
    // vizVal1[6].add(FlSpot(xValue.value++, (vizYValue[6] * 1000000) / 5.5));
    if (xValue.value > chartMaxX.value) {
      chartMinX.value += step.value;
      chartMaxX.value += step.value;
    }
    update();
  }

  Future<void> vizSimUpdate(Timer timer) async {
    // List<List<double>> aa = [];
    // for (var i = 0; i < aa.length; i++) {
    //   aa[i].add(setRandom());
    //   for (var i = 0; i < numOfViz; i++) {
    //     vizVal1[i].add(FlSpot(xValue.value++, aa[i][i]));
    //   }
    // }

    // List<double> time = [];
    // //vizYValue => List<double>
    // List<List<double>> data = [];
    // List<List<List<List<double>>>> asdf = [];
    // time.add(xValue.value++);
    // for (var i = 0; i < time.length; i++) {
    //   vizYValue.add(setRandom());
    // }
    // for (var i = 0; i < numOfViz; i++) {
    //   data.add()
    // }

    // List<double> xValues = [];
    // for (double i = 0; i < xValues.length; i++) {
    //   xValues.add(xValue.value + i);
    // }
    // List<List<double>> formatedSpec = [];
    // for (var z = 0; z < numOfViz; z++) {
    //   formatedSpec.add([]);
    //   for (var i = 0; i < xValues.length; i++) {
    //     formatedSpec[z].add(setRandom());
    //   }
    // }
    // for (var i = 0; i < numOfViz; i++) {
    //   for (int x = 0; x < xValues.length; x++) {
    //     vizVal1[i].add(FlSpot(xValue.value++, formatedSpec[i][x]));
    //   }
    //   for (int x = 0; x < xValues.length; x++) {
    //     vizVal2[i].add(FlSpot(xValue.value++, formatedSpec[i][x]));
    //   }
    //   for (int x = 0; x < xValues.length; x++) {
    //     vizVal3[i].add(FlSpot(xValue.value++, formatedSpec[i][x]));
    //   }
    //   for (int x = 0; x < xValues.length; x++) {
    //     vizVal4[i].add(FlSpot(xValue.value++, formatedSpec[i][x]));
    //   }
    //   for (int x = 0; x < xValues.length; x++) {
    //     vizVal5[i].add(FlSpot(xValue.value++, formatedSpec[i][x]));
    //   }
    // }
    vizVal1[0].add(FlSpot(xValue.value, setRandom())); //freq
    vizVal1[1].add(FlSpot(xValue.value, setRandom())); //p_div
    vizVal1[2].add(FlSpot(xValue.value, setRandom())); //v
    vizVal1[3].add(FlSpot(xValue.value, setRandom())); //i
    vizVal1[4].add(FlSpot(xValue.value, setRandom())); //r
    vizVal1[5].add(FlSpot(xValue.value, setRandom())); //x
    vizVal1[6].add(FlSpot(xValue.value, (setRandom()))); //phase
    //2
    vizVal2[0].add(FlSpot(xValue.value, (setRandom()))); //freq
    vizVal2[1].add(FlSpot(xValue.value, (setRandom()))); //p_div
    vizVal2[2].add(FlSpot(xValue.value, (setRandom()))); //v
    vizVal2[3].add(FlSpot(xValue.value, setRandom())); //i
    vizVal2[4].add(FlSpot(xValue.value, setRandom())); //r
    vizVal2[5].add(FlSpot(xValue.value, setRandom())); //x
    vizVal2[6].add(FlSpot(xValue.value, (setRandom()))); //phase
    //3
    vizVal3[0].add(FlSpot(xValue.value, (setRandom()))); //freq
    vizVal3[1].add(FlSpot(xValue.value, (setRandom()))); //p_div
    vizVal3[2].add(FlSpot(xValue.value, (setRandom()))); //v
    vizVal3[3].add(FlSpot(xValue.value, setRandom())); //i
    vizVal3[4].add(FlSpot(xValue.value, setRandom())); //r
    vizVal3[5].add(FlSpot(xValue.value, setRandom())); //x
    vizVal3[6].add(FlSpot(xValue.value, (setRandom()))); //phase
    //4
    vizVal4[0].add(FlSpot(xValue.value, (setRandom()))); //freq
    vizVal4[1].add(FlSpot(xValue.value, (setRandom()))); //p_div
    vizVal4[2].add(FlSpot(xValue.value, (setRandom()))); //v
    vizVal4[3].add(FlSpot(xValue.value, setRandom())); //i
    vizVal4[4].add(FlSpot(xValue.value, setRandom())); //r
    vizVal4[5].add(FlSpot(xValue.value, setRandom())); //x
    vizVal4[6].add(FlSpot(xValue.value, (setRandom()))); //phase
    //5
    vizVal5[0].add(FlSpot(xValue.value, (setRandom()))); //freq
    vizVal5[1].add(FlSpot(xValue.value, (setRandom()))); //p_div
    vizVal5[2].add(FlSpot(xValue.value, (setRandom()))); //v
    vizVal5[3].add(FlSpot(xValue.value, setRandom())); //i
    vizVal5[4].add(FlSpot(xValue.value, setRandom())); //r
    vizVal5[5].add(FlSpot(xValue.value, setRandom())); //x
    vizVal5[6].add(FlSpot(xValue.value++, (setRandom()))); //phase
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
        //Future.delayed(Duration(milliseconds: 10000));
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
    if (vizYValue.isNotEmpty) {
      vizYValue.clear();
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
      vizYValue.add((Uint8List.fromList(_b)
          .sublist(startDataIdx, startDataIdx += 4)
          .buffer
          .asByteData()
          .getFloat32(0, Endian.little)));
    }

    print('=================================================시작===');
    print(
        '=================================================Frequency : ${vizYValue[0]}');
    print(
        '=================================================P_div : ${vizYValue[1]}');
    print(
        '=================================================V : ${vizYValue[2]}');
    print(
        '=================================================I : ${vizYValue[3]}');
    print(
        '=================================================R : ${vizYValue[4]}');
    print(
        '=================================================X : ${vizYValue[5]}');
    print(
        '=================================================Phase : ${vizYValue[6]}');
    print('=================================================끝===');
    print('$receiveLength자와 같아 $_b');

    buffer = _bb;
  }

  Future<void> readSerial(Timer timer) async {
    if (vizChannel[0].port.isOpen) {
      await sendRead();
    } // 측정한 data 값 요구
    else {
      //다이얼로그 띄우기
    }
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

  vizFirst() {
    return HoverChart(
      chart: [
        if (VizCtrl.to.vizSeriesList[0])
          VizChart().lineChartBarData(VizCtrl.to.vizVal1[0],
              Get.find<iniController>().Series_Color_001.value),
        if (VizCtrl.to.vizSeriesList[1])
          VizChart().lineChartBarData(VizCtrl.to.vizVal1[1],
              Get.find<iniController>().Series_Color_002.value),
        if (VizCtrl.to.vizSeriesList[2])
          VizChart().lineChartBarData(VizCtrl.to.vizVal1[2],
              Get.find<iniController>().Series_Color_007.value),
        if (VizCtrl.to.vizSeriesList[3])
          VizChart().lineChartBarData(VizCtrl.to.vizVal1[3],
              Get.find<iniController>().Series_Color_004.value),
        if (VizCtrl.to.vizSeriesList[4])
          VizChart().lineChartBarData(VizCtrl.to.vizVal1[4],
              Get.find<iniController>().Series_Color_005.value),
        if (VizCtrl.to.vizSeriesList[5])
          VizChart().lineChartBarData(VizCtrl.to.vizVal1[5],
              Get.find<iniController>().Series_Color_006.value),
        if (VizCtrl.to.vizSeriesList[6])
          VizChart().lineChartBarData(VizCtrl.to.vizVal1[6],
              Get.find<iniController>().Series_Color_007.value)
      ],
    );
  }

  vizSecond() {
    return HoverChart(chart: [
      if (VizCtrl.to.vizSeriesList[0])
        VizChart().lineChartBarData(VizCtrl.to.vizVal2[0],
            Get.find<iniController>().Series_Color_001.value),
      if (VizCtrl.to.vizSeriesList[1])
        VizChart().lineChartBarData(VizCtrl.to.vizVal2[1],
            Get.find<iniController>().Series_Color_002.value),
      if (VizCtrl.to.vizSeriesList[2])
        VizChart().lineChartBarData(VizCtrl.to.vizVal2[2],
            Get.find<iniController>().Series_Color_007.value),
      if (VizCtrl.to.vizSeriesList[3])
        VizChart().lineChartBarData(VizCtrl.to.vizVal2[3],
            Get.find<iniController>().Series_Color_004.value),
      if (VizCtrl.to.vizSeriesList[4])
        VizChart().lineChartBarData(VizCtrl.to.vizVal2[4],
            Get.find<iniController>().Series_Color_005.value),
      if (VizCtrl.to.vizSeriesList[5])
        VizChart().lineChartBarData(VizCtrl.to.vizVal2[5],
            Get.find<iniController>().Series_Color_006.value),
      if (VizCtrl.to.vizSeriesList[6])
        VizChart().lineChartBarData(VizCtrl.to.vizVal2[6],
            Get.find<iniController>().Series_Color_007.value),
    ]);
  }

  vizThird() {
    return HoverChart(chart: [
      if (VizCtrl.to.vizSeriesList[0])
        VizChart().lineChartBarData(VizCtrl.to.vizVal3[0],
            Get.find<iniController>().Series_Color_001.value),
      if (VizCtrl.to.vizSeriesList[1])
        VizChart().lineChartBarData(VizCtrl.to.vizVal3[1],
            Get.find<iniController>().Series_Color_002.value),
      if (VizCtrl.to.vizSeriesList[2])
        VizChart().lineChartBarData(VizCtrl.to.vizVal3[2],
            Get.find<iniController>().Series_Color_007.value),
      if (VizCtrl.to.vizSeriesList[3])
        VizChart().lineChartBarData(VizCtrl.to.vizVal3[3],
            Get.find<iniController>().Series_Color_004.value),
      if (VizCtrl.to.vizSeriesList[4])
        VizChart().lineChartBarData(VizCtrl.to.vizVal3[4],
            Get.find<iniController>().Series_Color_005.value),
      if (VizCtrl.to.vizSeriesList[5])
        VizChart().lineChartBarData(VizCtrl.to.vizVal3[5],
            Get.find<iniController>().Series_Color_006.value),
      if (VizCtrl.to.vizSeriesList[6])
        VizChart().lineChartBarData(VizCtrl.to.vizVal3[6],
            Get.find<iniController>().Series_Color_007.value),
    ]);
  }

  vizFourth() {
    return HoverChart(chart: [
      if (VizCtrl.to.vizSeriesList[0])
        VizChart().lineChartBarData(VizCtrl.to.vizVal4[0],
            Get.find<iniController>().Series_Color_001.value),
      if (VizCtrl.to.vizSeriesList[1])
        VizChart().lineChartBarData(VizCtrl.to.vizVal4[1],
            Get.find<iniController>().Series_Color_002.value),
      if (VizCtrl.to.vizSeriesList[2])
        VizChart().lineChartBarData(VizCtrl.to.vizVal4[2],
            Get.find<iniController>().Series_Color_007.value),
      if (VizCtrl.to.vizSeriesList[3])
        VizChart().lineChartBarData(VizCtrl.to.vizVal4[3],
            Get.find<iniController>().Series_Color_004.value),
      if (VizCtrl.to.vizSeriesList[4])
        VizChart().lineChartBarData(VizCtrl.to.vizVal4[4],
            Get.find<iniController>().Series_Color_005.value),
      if (VizCtrl.to.vizSeriesList[5])
        VizChart().lineChartBarData(VizCtrl.to.vizVal4[5],
            Get.find<iniController>().Series_Color_006.value),
      if (VizCtrl.to.vizSeriesList[6])
        VizChart().lineChartBarData(VizCtrl.to.vizVal4[6],
            Get.find<iniController>().Series_Color_007.value),
    ]);
  }

  vizFifth() {
    return HoverChart(chart: [
      if (VizCtrl.to.vizSeriesList[0])
        VizChart().lineChartBarData(VizCtrl.to.vizVal5[0],
            Get.find<iniController>().Series_Color_001.value),
      if (VizCtrl.to.vizSeriesList[1])
        VizChart().lineChartBarData(VizCtrl.to.vizVal5[1],
            Get.find<iniController>().Series_Color_002.value),
      if (VizCtrl.to.vizSeriesList[2])
        VizChart().lineChartBarData(VizCtrl.to.vizVal5[2],
            Get.find<iniController>().Series_Color_007.value),
      if (VizCtrl.to.vizSeriesList[3])
        VizChart().lineChartBarData(VizCtrl.to.vizVal5[3],
            Get.find<iniController>().Series_Color_004.value),
      if (VizCtrl.to.vizSeriesList[4])
        VizChart().lineChartBarData(VizCtrl.to.vizVal5[4],
            Get.find<iniController>().Series_Color_005.value),
      if (VizCtrl.to.vizSeriesList[5])
        VizChart().lineChartBarData(VizCtrl.to.vizVal5[5],
            Get.find<iniController>().Series_Color_006.value),
      if (VizCtrl.to.vizSeriesList[6])
        VizChart().lineChartBarData(VizCtrl.to.vizVal5[6],
            Get.find<iniController>().Series_Color_007.value),
    ]);
  }
}
