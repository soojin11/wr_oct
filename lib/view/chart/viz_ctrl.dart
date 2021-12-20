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

  Future<void> init() async {
    vizChannel.clear();
    // for (var i = 0; i < 5; i++) {
    //   vizChannel.add(VizChannel(vizData: VizData.init(),port: SerialPort('COM2'));
    // }
    vizChannel
        .add(VizChannel(vizData: VizData.init(), port: SerialPort('COM4')));
  }

  Future<void> updateViz(Timer timer) async {}
  Future<int> startSerial() async {
    vizChannel[0].port.config.baudRate = 115200;
    if (!vizChannel[0].port.openRead()) {
      print('오픈 에러 ?? ${SerialPort.lastError}');
    } else {
      print('오픈 성공');
    }
    return 1;
  }

  Future readSerial() async {
    final reader = SerialPortReader(vizChannel[0].port);
    reader.stream.listen((data) {
      print('received: $data');
      Uint8List bytes = Uint8List.fromList(data);
      String s = String.fromCharCodes(bytes);
      print('데이터는 $s');
    });
  }

  Future<int> startSerial2() async {
    String name = 'COM4';
    final port = SerialPort(name);
    port.config.baudRate = 115200;
    port.config.bits = 8;
    port.config.parity = 0;
    port.config.stopBits = 1;
    print('포트 열렸나 ?? ${port.isOpen}');
    if (!port.openRead()) {
      print('오픈 에러 ?? ${SerialPort.lastError}');
    }
    print('\tDescription: ${port.description}');
    print('\tManufacturer: ${port.manufacturer}');
    print('\tSerial Number: ${port.serialNumber}');
    final reader = SerialPortReader(port);
    reader.stream.listen((data) {
      print('received: $data');
      Uint8List bytes = Uint8List.fromList(data);
      String s = String.fromCharCodes(bytes);
      print('데이터는 $s');
    });

    return 0;
  }
}

class VizChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: OutlinedButton(
          onPressed: () async {
            VizCtrl.to.readSerial();
          },
          child: Text('viz')),
    );
  }
}
