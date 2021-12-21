import 'dart:async';
import 'dart:ffi';
import 'dart:typed_data';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:libserialport/libserialport.dart';
import 'package:wr_ui/model/viz_data.dart';

class VizCtrl extends GetxController {
  static VizCtrl get to => Get.find();
  RxList<FlSpot> vizChartData = RxList.empty();
  RxList<VizChannel> vizChannel = RxList.empty();
  RxBool isStart = false.obs;

  Future<void> init() async {
    vizChannel.clear();
    // for (var i = 0; i < 5; i++) {
    //   vizChannel.add(VizChannel(vizData: VizData.init(),port: SerialPort('COM2'));
    // }
    vizChannel
        .add(VizChannel(vizData: VizData.init(), port: SerialPort('COM4')));
    // vizChannel
    //     .add(VizChannel(vizData: VizData.init(), port: SerialPort('COM5')));
  }

  Future<void> updateViz(Timer timer) async {}

  Future<int> startSerial() async {
    vizChannel[0].port.config.baudRate = 115200;

    if (vizChannel[0].port.openReadWrite()) {
      print('오픈 성공');
    } else {
      print('오픈 에러 ?? ${SerialPort.lastError}');
    }
    return 1;
  }

  Future readSerial() async {
    final reader = SerialPortReader(vizChannel[0].port);
    await sendStart(); //측정 시작
    await sendRead(); // 측정한 data 값

    await reader.stream.listen((data) async {
      print('읽기시작');
      Uint8List bytes = await Uint8List.fromList(data);
      int lenOfData = bytes.length;
      print('길이는 ? $lenOfData');
      print('read bytes : $bytes'); // 여기서 골라야지
      Uint8List freq = bytes.sublist(45, 49);
      Uint8List p_div = bytes.sublist(49, 53);
      Uint8List v = bytes.sublist(53, 57);
      Uint8List i = bytes.sublist(57, 61);
      Uint8List r = bytes.sublist(61, 65);
      Uint8List x = bytes.sublist(65, 69);
      print('Frequency List: $freq');
      print('P_div List: $p_div');
      print('V List: $v');
      print('I List: $i');
      print('R List: $r');
      print('X List: $x');
      double freq_val = freq.buffer.asByteData().getFloat32(0, Endian.little);
      double p_div_val = p_div.buffer.asByteData().getFloat32(0, Endian.little);
      double v_val = v.buffer.asByteData().getFloat32(0, Endian.little);
      double i_val = i.buffer.asByteData().getFloat32(0, Endian.little);
      double r_val = r.buffer.asByteData().getFloat32(0, Endian.little);
      double x_val = x.buffer.asByteData().getFloat32(0, Endian.little);

      print('Frequency : $freq_val');
      print('P_div : $p_div_val');
      print('V : $v_val');
      print('I : $i_val');
      print('R : $r_val');
      print('X : $x_val');
      print('다 읽음');
    });
  }

  Future sendStart() async {
    // final list = utf8.encode(text);
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

    //bytes.add(16);
    //print('write :  $text');
    //print('encode : $list');
    print('시작신호bytes : $bytes');
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
    adfasdasf.add(0x1a); //이미 컴퓨터 언어니까  encoding 할 필요 없는거넹
    final bytes = Uint8List.fromList(adfasdasf);
    print('데이터수집신호bytes : $bytes');
    vizChannel[0].port.write(bytes);
  }
}

class VizChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        onPressed: () {
          Uint8List aa = Uint8List.fromList([
            4,
            152,
            43,
            66,
          ]);
          var sss = aa.buffer.asByteData().getFloat32(0, Endian.little);
          print(sss);
        },
        child: Text('16진수로 바꾸기'));
  }
}
