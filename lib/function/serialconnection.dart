import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:libserialport/libserialport.dart';

class Serial extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}

void serialPort() {
  print("serial");
  String a = "COM4";
  final port = SerialPort(a);
  print("port $port");
  port.config.baudRate = 115200;
  print('serial status1 ${port.isOpen}');
  if (!port.openRead()) {
    print("open error");
    print(SerialPort.lastError);
    return;
  }

  print("reader");
  final reader = SerialPortReader(port);
  print('${port.isOpen}');
  print('${port.isOpen}');
  int nCnt = 0;
  reader.stream.listen((data) {
    try {
      print("data ${data.length}");
      print("data $data");
      print("listen");
      if (data[3] != 44 && data[3] != 46) {
        print("Invalid data entered");
        return;
      }

      Uint8List bytes = Uint8List.fromList(data);
      String s = String.fromCharCodes(bytes);

      if (s.indexOf('.') > 0) {
        print('=======================================');
        print('시간${DateTime.now()} $nCnt');
        nCnt = 0;
      }


    } catch (e) {
      print('문제발생');
      port.close();
    }
    return;
  });
}
