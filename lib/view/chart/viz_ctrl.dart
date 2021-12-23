import 'dart:async';
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
  Timer? vizTimer;
  List<int> buffer = [];
  List<double> cutData = [];

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
      final reader = SerialPortReader(vizChannel[0].port);

      // Uint8List data = vizChannel[0].port.read(200, timeout: 1);
      //await validity2(data);
      await reader.stream.listen((data) async {
        // try{
        await validity2(data);
        // }
        // catch(e){
        //   if(e.toString()= 'wef')
        //     print(e);
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

  validity2(Uint8List data) async {
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
      // throw 'wef';
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
      print('헤더가 이상있어요');
      buffer = [];
      return;
    }
    if (_b[receiveLength - 1] != 0x1a) {
      print('마지막이 이상있어요');
      buffer = [];
      return;
    }
    final int cs = calcCheckSum(_b.sublist(2, _b.length - 2));
    print('cs $cs');
    if (cs != _b[receiveLength - 2]) {
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

    // Uint8List freq =
    //     Uint8List.fromList(_b).sublist(startDataIdx, startDataIdx += 4);
    // Uint8List p_div =
    //     Uint8List.fromList(_b).sublist(startDataIdx, startDataIdx += 4);
    // Uint8List v =
    //     Uint8List.fromList(_b).sublist(startDataIdx, startDataIdx += 4);
    // Uint8List i =
    //     Uint8List.fromList(_b).sublist(startDataIdx, startDataIdx += 4);
    // Uint8List r =
    //     Uint8List.fromList(_b).sublist(startDataIdx, startDataIdx += 4);
    // Uint8List x =
    //     Uint8List.fromList(_b).sublist(startDataIdx, startDataIdx += 4);
    // Uint8List phase =
    //     Uint8List.fromList(_b).sublist(startDataIdx, startDataIdx += 4);
    // double freq_val = freq.buffer.asByteData().getFloat32(0, Endian.little);
    // double p_div_val = p_div.buffer.asByteData().getFloat32(0, Endian.little);
    // double v_val = v.buffer.asByteData().getFloat32(0, Endian.little);
    // double i_val = i.buffer.asByteData().getFloat32(0, Endian.little);
    // double r_val = r.buffer.asByteData().getFloat32(0, Endian.little);
    // double x_val = x.buffer.asByteData().getFloat32(0, Endian.little);
    // double phase_val = phase.buffer.asByteData().getFloat32(0, Endian.little);
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
    print('===끝===');
    print('$receiveLength자와 같아 $_b');

    buffer = _bb;
  }

  //유효성 검사
  validity(Uint8List data) async {
    // buffer.clear();
    print('되고있나 ? ');
    if (data.isNotEmpty) {
      //1. 87
      if (data.length == 87) {
        if (data[0] == 22 && data[86] == 26) {
          for (var i = 0; i < 87; i++) {
            buffer.add(data[i]);
          }
        } else {
          buffer.clear();
        }
      }
      //2. 데이터 짧을 때
      else if (data.length < 87) {
        for (var i = 0; i < 87 - data.length; i++) {
          buffer.add(data[i]);
        }

        if (buffer[0] == 22) {
          for (var i = 0; i < data.length; i++) {
            buffer.add(data[i]);
          }
          if (buffer.length < 87) {}
          return validity(Uint8List.fromList(buffer));
        }
        if (buffer[0] != 22) {
          buffer.clear();
        }
      }
      //3. 길 때
      else {}
    } else {
      print('비었음');
    }
  }

  // lessLength(Uint8List data) {
  //   for (var i = data.length - 1; i <= 87; i++) {
  //     buffer.add(data[data.length - 1]);
  //   }
  //   return validity(Uint8List.fromList(buffer));
  // }

  Future<void> readSerial(Timer timer) async {
    //final reader = SerialPortReader(vizChannel[0].port);
    if (vizChannel[0].port.isOpen) await sendRead(); // 측정한 data 값 요구

    // Uint8List data = vizChannel[0].port.read(200, timeout: 1);
    // await validity2(data);
    // await reader.stream.listen((data) async {
    //   await validity2(data);
    // });
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

class VizChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          VizCtrl.to.buffer.clear();
          Uint8List aa = Uint8List.fromList([0x17, 0x16, 0x16, 0x16]);
          VizCtrl.to.validity2(aa);
          print('buffer1 ${VizCtrl.to.buffer}');
          Uint8List aa2 = Uint8List.fromList([0x16, 0x16, 0x30, 0x03]);
          VizCtrl.to.validity2(aa2);
          print('buffer2 ${VizCtrl.to.buffer}');
          // Uint8List aa3 = Uint8List.fromList([0x02, 0x01, 0x02, 0x35, 0x1a]);
          // VizCtrl.to.validity2(aa3);
          // print('buffer3 ${VizCtrl.to.buffer}');
          Uint8List aa4 = Uint8List.fromList([
            // 0x16,
            // 0x16,
            // 0x30,
            // 0x03,
            0x48,
            0x48,
            0x48,
            0x48,
            0x48,
            0x48,
            0x16,
            0x16,
            0x30,
            0x03,
            0x48,
            0x48,
            0x48,
            0x48,
            0x48,
            0x48,
            0x16,
            0x16,
            0x30,
            0x03,
            0x48,
            0x48,
            0x48,
            0x48,
            0x48,
            0x48,
            0x16,
            0x16,
            0x30,
            0x03,
            0x48,
            0x48,
            0x48,
            0x48,
            0x48,
            0x48,
            0x16,
            0x16,
            0x30,
            0x03,
            0x48,
            0x48,
            0x48,
            0x48,
            0x48,
            0x48,
            0x16,
            0x16,
            0x30,
            0x03,
            0x48,
            0x48,
            0x48,
            0x48,
            0x48,
            0x48,
            0x16,
            0x16,
            0x30,
            0x03,
            0x48,
            0x48,
            0x48,
            0x48,
            0x48,
            0x48,
            0x48,
            0x16,
            0x16,
            0x30,
            0x03,
            0x48,
            0x48,
            0x48,
            0x1a,
            0x16,
          ]);
          print('data length ${aa4.length}');
          VizCtrl.to.validity2(aa4);
          print('buffer4 ${VizCtrl.to.buffer}');
          Uint8List aa5 = Uint8List.fromList([
            // 0x16,
            0x16,
            0x30,
            0x03,
            0x48,
            0x48,
            0x48,
            0x48,
            0x48,
            0x48,
            0x16,
            0x16,
            0x30,
            0x03,
            0x48,
            0x48,
            0x48,
            0x48,
            0x48,
            0x16,
            0x16,
            0x30,
            0x03,
            0x48,
            0x48,
            0x48,
            0x48,
            0x48,
            0x48,
            0x16,
            0x16,
            0x30,
            0x03,
            0x48,
            0x48,
            0x48,
            0x48,
            0x48,
            0x48,
            0x16,
            0x16,
            0x30,
            0x03,
            0x48,
            0x48,
            0x48,
            0x48,
            0x48,
            0x48,
            0x16,
            0x16,
            0x30,
            0x03,
            0x48,
            0x48,
            0x48,
            0x48,
            0x48,
            0x48,
            0x16,
            0x16,
            0x30,
            0x03,
            0x48,
            0x48,
            0x48,
            0x48,
            0x48,
            0x48,
            0x16,
            0x16,
            0x30,
            0x03,
            0x30,
            0x03,
            0x48,
            0x48,
            0x48,
            0x1a,
            0x16
          ]);
          print('data length ${aa5.length}');
          VizCtrl.to.validity2(aa5);
          print('buffer5 ${VizCtrl.to.buffer}');
          Uint8List aa6 = Uint8List.fromList([0x16]);
          VizCtrl.to.validity2(aa6);
          print('buffer6 ${VizCtrl.to.buffer}');
          Uint8List aa7 = Uint8List.fromList([0x30, 0x03]);
          VizCtrl.to.validity2(aa7);
          print('buffer7 ${VizCtrl.to.buffer}');
          Uint8List aa8 = Uint8List.fromList([
            // 0x16,
            //0x16,
            //0x30,
            //0x03,
            0x48,
            0x48,
            0x48,
            0x48,
            0x48,
            0x48,
            0x16,
            0x16,
            0x30,
            0x03,
            0x48,
            0x48,
            0x48,
            0x48,
            0x48,
            0x16,
            0x16,
            0x30,
            0x03,
            0x48,
            0x48,
            0x48,
            0x48,
            0x48,
            0x48,
            0x16,
            0x16,
            0x30,
            0x03,
            0x48,
            0x48,
            0x48,
            0x48,
            0x48,
            0x48,
            0x16,
            0x16,
            0x30,
            0x03,
            0x48,
            0x48,
            0x48,
            0x48,
            0x48,
            0x48,
            0x16,
            0x16,
            0x30,
            0x03,
            0x48,
            0x48,
            0x48,
            0x48,
            0x48,
            0x48,
            0x16,
            0x16,
            0x16,
            0x16,
            0x30,
            0x03,
            0x48,
            0x48,
            0x48,
            0x48,
            0x48,
            0x48,
            0x16,
            0x16,
            0x30,
            0x03,
            0x48,
            0x48,
            0x48,
            0x1a,
            0x16
          ]);
          print('data length ${aa8.length}');
          VizCtrl.to.validity2(aa8);
          print('buffer8 ${VizCtrl.to.buffer}');
          Uint8List aa9 = Uint8List.fromList([
            0x16,
            0x16,
            0x30,
            0x3,
            0x48,
            0xAE,
            0x23,
            0x8A,
            0xB5,
            0x46,
            0x5A,
            0xDB,
            0xB6,
            0x2F,
            0xCA,
            0xB8,
            0x30,
            0xE0,
            0x8E,
            0x64,
            0xB6,
            0xF4,
            0x6E,
            0x80,
            0xB8,
            0x5E,
            0x23,
            0xA8,
            0x30,
            0x8D,
            0xFA,
            0x2F,
            0x2F,
            0xB6,
            0xC6,
            0x81,
            0x2F,
            0x9B,
            0x44,
            0x4E,
            0x4B,
            0xDD,
            0xB3,
            0x45,
            0x37,
            0x20,
            0xB5,
            0x8E,
            0x3D,
            0x42,
            0x9E,
            0xB1,
            0x3A,
            0xB6,
            0x58,
            0xCD,
            0x40,
            0x3,
            0x6F,
            0x17,
            0x41,
            0xDE,
            0xC3,
            0xC7,
            0x42,
            0x32,
            0x90,
            0x74,
            0x42,
            0x0,
            0x0,
            0x0,
            0x0,
            0x0,
            0x1B,
            0xB7,
            0x4B,
            0x3C,
            0x1A
          ]);
          VizCtrl.to.validity2(aa9);
          print('buffer9 ${VizCtrl.to.buffer}');
        },
        child: Text('16진수로 바꾸기'));
  }
}
