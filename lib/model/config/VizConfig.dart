import 'dart:convert';
import 'package:wr_ui/view/right_side_menu/save_ini.dart';
import 'package:flutter/foundation.dart';

class VizConfig {
  int interval;
  List VizComPort;
  VizConfig({
    required this.interval,
    required this.VizComPort,
  });

  factory VizConfig.init() {
    return VizConfig(
        interval: iniController.to.viz_Interval.value,
        VizComPort: iniController.to.vizComport);
  }

  VizConfig copyWith({
    int? interval,
    bool? simulation,
    List? VizComPort,
  }) {
    return VizConfig(
      interval: interval ?? this.interval,
      VizComPort: VizComPort ?? this.VizComPort,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'interval': interval,
      'VizComPort': VizComPort,
    };
  }

  factory VizConfig.fromMap(Map<String, dynamic> map) {
    return VizConfig(
      interval: map['interval']?.toInt() ?? 0,
      VizComPort: List.from(map['VizComPort']),
    );
  }

  String toJson() => json.encode(toMap());

  factory VizConfig.fromJson(String source) =>
      VizConfig.fromMap(json.decode(source));

  @override
  String toString() =>
      'VizConfig(interval: $interval,  VizComPort: $VizComPort)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is VizConfig &&
        other.interval == interval &&
        listEquals(other.VizComPort, VizComPort);
  }

  @override
  int get hashCode => interval.hashCode ^ VizComPort.hashCode;
}
