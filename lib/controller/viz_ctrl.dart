import 'dart:async';
import 'dart:typed_data';
import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';
import 'package:libserialport/libserialport.dart';
import 'package:wr_ui/model/viz_data.dart';
import 'dart:math' as math;
import 'package:wr_ui/view/chart/pages/hover_chart/hover.dart';
import 'package:wr_ui/view/chart/viz_chart.dart';
import 'package:wr_ui/view/right_side_menu/csv_creator.dart';
import 'package:wr_ui/view/right_side_menu/log_screen.dart';
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
  late Timer timer;
  int numOfViz = 7;
  List<int> buffer = [];
  List<double> vizYValue = RxList.empty();
  Rx<VizData> vizData = VizData.init().obs;
  RxString selected = "OES".obs;
  var dropItem = ['OES', 'VIZ'];

  //////////////차트ctrl///////////////
  RxList<Rx<VizData>> vizList = RxList.empty();
  RxList<RxList<RxList<FlSpot>>> vizPoints = RxList.empty();
  RxList<List<List<FlSpot>>> vizVal = RxList.empty();
  //12.30
  RxList<Rx<VizData>> viz = RxList.empty();
  RxList<RxList<FlSpot>> vizChart = RxList.empty();
  //
  RxDouble step = 1.0.obs;
  RxDouble chartMaxX = 800.0.obs;
  RxDouble chartMinX = 0.0.obs;
  late RxDouble minX;
  late RxDouble maxX;
  RxDouble xValue = 0.0.obs;
  RxList<List<double>> xValues = RxList.empty();
  RxDouble yValue = 0.0.obs;
  RxInt chartNum = 0.obs;
  // Timer? vizChartTimer;

  double setRandom() {
    double yValue = 10 + math.Random().nextInt(10).toDouble();
    return yValue;
  }

  void setSelected(value) {
    selected.value = value;
  }

  ///////////////////////////////////////
//1/5
  Future<void> init() async {
    vizChannel.clear();
    for (var i = 0; i < 5; i++) {
      vizChannel.add(VizChannel(
          vizData: VizData.init(),
          port: SerialPort('COM${Get.find<iniController>().vizComport[i]}')));
    }
  }

  Future<void> vizUpdate() async {
    List aaa = [];
    for (var i = 0; i < 5; i++) {
      vizPoints[i][0]
          .add(FlSpot(xValue.value, vizList[i].value.rf_freq / 100000));
      vizPoints[i][1].add(FlSpot(xValue.value, vizList[i].value.p_del * 2));
      vizPoints[i][2].add(FlSpot(xValue.value, vizList[i].value.v));
      vizPoints[i][3].add(FlSpot(xValue.value, vizList[i].value.i * 10));
      vizPoints[i][4].add(FlSpot(xValue.value, vizList[i].value.r * 10));
      vizPoints[i][5].add(FlSpot(xValue.value, vizList[i].value.x * 10));
      vizPoints[i][6]
          .add(FlSpot(xValue.value, vizList[i].value.phase * 1000 / 360));
      aaa.add(vizList[i].value.rf_freq);
      aaa.add(vizList[i].value.p_del);
      aaa.add(vizList[i].value.v);
      aaa.add(vizList[i].value.i);
      aaa.add(vizList[i].value.r);
      aaa.add(vizList[i].value.x);
      aaa.add(vizList[i].value.phase);
      // print('asdf${aaa}');
    }
    if (Get.find<CsvController>().csvSaveInit.value) {
      Get.find<CsvController>().vizDataSave(data: aaa);
    }

    // vizVal1[0].add(FlSpot(xValue.value, vizYValue[0] / 100000)); //freq
    // vizVal1[1].add(FlSpot(xValue.value, (vizYValue[1] * 2))); //p
    // vizVal1[2].add(FlSpot(xValue.value, (vizYValue[2]))); //v
    // vizVal1[3].add(FlSpot(xValue.value, (vizYValue[3] * 10))); //i
    // vizVal1[4].add(FlSpot(xValue.value, (vizYValue[4] * 10))); //r
    // vizVal1[5].add(FlSpot(xValue.value, (vizYValue[5] * 10))); //x
    // vizVal1[6].add(FlSpot(xValue.value, (vizYValue[6] * 1000 / 360))); //phase

    if (xValue.value > chartMaxX.value) {
      chartMinX.value += step.value;
      chartMaxX.value += step.value;
    }
    xValue.value += step.value;
    vizPoints.remove(0);

    update();
  }

//open/listen
  Future<int> startSerial() async {
    for (var i = 0; i < 5; i++) {
      vizChannel[i].port.config.baudRate = 115200;
      if (!VizCtrl.to.vizChannel[i].port.isOpen) {
        Get.find<LogListController>().logData.add('Check VIZ${i + 1} port');
      }
    }

    // vizChannel[0].port.config.baudRate = 115200;
    if (vizChannel[0].port.openReadWrite()) {
      print('오픈 성공');
      final reader = SerialPortReader(vizChannel[0].port);
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
      Get.find<LogListController>().logData.add('Viz Comport Error');
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
      print('시작 0x16 아님');
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
      vizYValue.add(Uint8List.fromList(_b)
          .sublist(startDataIdx, startDataIdx += 4)
          .buffer
          .asByteData()
          .getFloat32(0, Endian.little));
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

    vizList[0].value.rf_freq = vizYValue[0];
    vizList[0].value.p_del = vizYValue[1];
    vizList[0].value.v = vizYValue[2];
    vizList[0].value.i = vizYValue[3];
    vizList[0].value.r = vizYValue[4];
    vizList[0].value.x = vizYValue[5];
    vizList[0].value.phase = vizYValue[6];
  }

  Future<void> readSerial(Timer timer) async {
    if (vizChannel[0].port.isOpen) {
      await sendRead();
    } else {
      for (var i = 0; i < 5; i++) {
        vizList[i].value.rf_freq = setRandom() + 1405900;
        vizList[i].value.p_del = setRandom() + 40;
        vizList[i].value.v = setRandom() + 120;
        vizList[i].value.i = setRandom() - 10;
        vizList[i].value.r = setRandom() - 10;
        vizList[i].value.x = setRandom() - 10;
        vizList[i].value.phase = setRandom() + 30;
      }
    }
    // 측정한 data 값 요구
    // if (vizYValue.isNotEmpty) {
    //   vizUpdate();
    // }
    if (vizList.isNotEmpty) {
      vizUpdate();
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
          VizChart().lineChartBarData(VizCtrl.to.vizPoints[0][0],
              Get.find<iniController>().vizColor[0]),
        if (VizCtrl.to.vizSeriesList[1])
          VizChart().lineChartBarData(VizCtrl.to.vizPoints[0][1],
              Get.find<iniController>().vizColor[1]),
        if (VizCtrl.to.vizSeriesList[2])
          VizChart().lineChartBarData(VizCtrl.to.vizPoints[0][2],
              Get.find<iniController>().vizColor[2]),
        if (VizCtrl.to.vizSeriesList[3])
          VizChart().lineChartBarData(VizCtrl.to.vizPoints[0][3],
              Get.find<iniController>().vizColor[3]),
        if (VizCtrl.to.vizSeriesList[4])
          VizChart().lineChartBarData(VizCtrl.to.vizPoints[0][4],
              Get.find<iniController>().vizColor[4]),
        if (VizCtrl.to.vizSeriesList[5])
          VizChart().lineChartBarData(VizCtrl.to.vizPoints[0][5],
              Get.find<iniController>().vizColor[5]),
        if (VizCtrl.to.vizSeriesList[6])
          VizChart().lineChartBarData(
              VizCtrl.to.vizPoints[0][6], Get.find<iniController>().vizColor[6])
      ],
    );
  }

  vizSecond() {
    return HoverChart(chart: [
      if (VizCtrl.to.vizSeriesList[0])
        VizChart().lineChartBarData(
            VizCtrl.to.vizPoints[1][0], Get.find<iniController>().vizColor[0]),
      if (VizCtrl.to.vizSeriesList[1])
        VizChart().lineChartBarData(
            VizCtrl.to.vizPoints[1][1], Get.find<iniController>().vizColor[1]),
      if (VizCtrl.to.vizSeriesList[2])
        VizChart().lineChartBarData(
            VizCtrl.to.vizPoints[1][2], Get.find<iniController>().vizColor[2]),
      if (VizCtrl.to.vizSeriesList[3])
        VizChart().lineChartBarData(
            VizCtrl.to.vizPoints[1][3], Get.find<iniController>().vizColor[3]),
      if (VizCtrl.to.vizSeriesList[4])
        VizChart().lineChartBarData(
            VizCtrl.to.vizPoints[1][4], Get.find<iniController>().vizColor[4]),
      if (VizCtrl.to.vizSeriesList[5])
        VizChart().lineChartBarData(
            VizCtrl.to.vizPoints[1][5], Get.find<iniController>().vizColor[5]),
      if (VizCtrl.to.vizSeriesList[6])
        VizChart().lineChartBarData(
            VizCtrl.to.vizPoints[0][6], Get.find<iniController>().vizColor[6])
    ]);
  }

  vizThird() {
    return HoverChart(chart: [
      if (VizCtrl.to.vizSeriesList[0])
        VizChart().lineChartBarData(
            VizCtrl.to.vizPoints[2][0], Get.find<iniController>().vizColor[0]),
      if (VizCtrl.to.vizSeriesList[1])
        VizChart().lineChartBarData(
            VizCtrl.to.vizPoints[2][1], Get.find<iniController>().vizColor[1]),
      if (VizCtrl.to.vizSeriesList[2])
        VizChart().lineChartBarData(
            VizCtrl.to.vizPoints[2][2], Get.find<iniController>().vizColor[2]),
      if (VizCtrl.to.vizSeriesList[3])
        VizChart().lineChartBarData(
            VizCtrl.to.vizPoints[2][3], Get.find<iniController>().vizColor[3]),
      if (VizCtrl.to.vizSeriesList[4])
        VizChart().lineChartBarData(
            VizCtrl.to.vizPoints[2][4], Get.find<iniController>().vizColor[4]),
      if (VizCtrl.to.vizSeriesList[5])
        VizChart().lineChartBarData(
            VizCtrl.to.vizPoints[2][5], Get.find<iniController>().vizColor[5]),
      if (VizCtrl.to.vizSeriesList[6])
        VizChart().lineChartBarData(
            VizCtrl.to.vizPoints[2][6], Get.find<iniController>().vizColor[6])
    ]);
  }

  vizFourth() {
    return HoverChart(chart: [
      if (VizCtrl.to.vizSeriesList[0])
        VizChart().lineChartBarData(
            VizCtrl.to.vizPoints[3][0], Get.find<iniController>().vizColor[0]),
      if (VizCtrl.to.vizSeriesList[1])
        VizChart().lineChartBarData(
            VizCtrl.to.vizPoints[3][1], Get.find<iniController>().vizColor[1]),
      if (VizCtrl.to.vizSeriesList[2])
        VizChart().lineChartBarData(
            VizCtrl.to.vizPoints[3][2], Get.find<iniController>().vizColor[2]),
      if (VizCtrl.to.vizSeriesList[3])
        VizChart().lineChartBarData(
            VizCtrl.to.vizPoints[3][3], Get.find<iniController>().vizColor[3]),
      if (VizCtrl.to.vizSeriesList[4])
        VizChart().lineChartBarData(
            VizCtrl.to.vizPoints[3][4], Get.find<iniController>().vizColor[4]),
      if (VizCtrl.to.vizSeriesList[5])
        VizChart().lineChartBarData(
            VizCtrl.to.vizPoints[3][5], Get.find<iniController>().vizColor[5]),
      if (VizCtrl.to.vizSeriesList[6])
        VizChart().lineChartBarData(
            VizCtrl.to.vizPoints[3][6], Get.find<iniController>().vizColor[6])
    ]);
  }

  vizFifth() {
    return HoverChart(chart: [
      if (VizCtrl.to.vizSeriesList[0])
        VizChart().lineChartBarData(
            VizCtrl.to.vizPoints[4][0], Get.find<iniController>().vizColor[0]),
      if (VizCtrl.to.vizSeriesList[1])
        VizChart().lineChartBarData(
            VizCtrl.to.vizPoints[4][1], Get.find<iniController>().vizColor[1]),
      if (VizCtrl.to.vizSeriesList[2])
        VizChart().lineChartBarData(
            VizCtrl.to.vizPoints[4][2], Get.find<iniController>().vizColor[2]),
      if (VizCtrl.to.vizSeriesList[3])
        VizChart().lineChartBarData(
            VizCtrl.to.vizPoints[4][3], Get.find<iniController>().vizColor[3]),
      if (VizCtrl.to.vizSeriesList[4])
        VizChart().lineChartBarData(
            VizCtrl.to.vizPoints[4][4], Get.find<iniController>().vizColor[4]),
      if (VizCtrl.to.vizSeriesList[5])
        VizChart().lineChartBarData(
            VizCtrl.to.vizPoints[4][5], Get.find<iniController>().vizColor[5]),
      if (VizCtrl.to.vizSeriesList[6])
        VizChart().lineChartBarData(
            VizCtrl.to.vizPoints[4][6], Get.find<iniController>().vizColor[6])
    ]);
  }
}
