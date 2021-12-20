import 'package:flutter_libserialport/flutter_libserialport.dart';

class VizData // Channel1개에서 나오는 Data
{
  VizData({
    this.rf_freq = 0.0,
    this.p_del = 0.0,
    this.v = 0.0,
    this.i = 0.0,
    this.r = 0.0,
    this.x = 0.0,
    this.phase = 0.0,
  });
  double rf_freq;
  double p_del;
  double v;
  double i;
  double r;
  double x;
  double phase;

  factory VizData.init() {
    return VizData(
        rf_freq: 0.0, p_del: 0.0, v: 0.0, i: 0.0, r: 0.0, x: 0.0, phase: 0.0);
  }
  // factory VizData.fromMap(Map<String, dynamic>? map) {
  //     return VizData(
  //       rf_freq: map['rf_freq'],
  //       p_del: map['rf_freq'] ?? 0.0,
  //     );
  //   }
  // }

  //생성자
  //tojson
  //tomap
  //frommap

}

class VizChannel // Viz 정보들
{
  VizChannel({
    required this.vizData,
    required this.port,
  });
  VizData vizData;
  SerialPort port;
  // factory VizChannel.init() {
  //   return VizChannel(vizData: VizData.init(), port: 'COM1');
  // }
  //생성자
  //tojson
  //tomap
  //frommap

}
