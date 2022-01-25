import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:libserialport/libserialport.dart';

class VizChannel {
  double xValue;
  // viz 정보
  VizData vizData;
  //SerialPort port;
  RxBool toggle;
  VizChannel({
    //required this.port,
    required this.xValue,
    required this.vizData,
    required this.toggle,
  });

  VizChannel copyWith({
    double? xValue,
    VizData? vizData,
    RxBool? toggle,
  }) {
    return VizChannel(
      xValue: xValue ?? this.xValue,
      vizData: vizData ?? this.vizData,
      toggle: toggle ?? this.toggle,
    );
  }

  @override
  String toString() =>
      'VizChannel(xValue: $xValue, vizData: $vizData, toggle: $toggle)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is VizChannel &&
        other.xValue == xValue &&
        other.vizData == vizData &&
        other.toggle == toggle;
  }

  @override
  int get hashCode => xValue.hashCode ^ vizData.hashCode ^ toggle.hashCode;
}

class VizData {
  // Channel1개에서 나오는 Data
  double freq;
  double p_dlv;
  double v;
  double i;
  double r;
  double x;
  double phase;
  VizSeries vizSeries;
  VizData({
    required this.freq,
    required this.p_dlv,
    required this.v,
    required this.i,
    required this.r,
    required this.x,
    required this.phase,
    required this.vizSeries,
  });

  factory VizData.init() {
    return VizData(
        freq: 0.0,
        p_dlv: 0.0,
        v: 0.0,
        i: 0.0,
        r: 0.0,
        x: 0.0,
        phase: 0.0,
        vizSeries: VizSeries.init());
  }
  VizData copyWith({
    double? freq,
    double? p_dlv,
    double? v,
    double? i,
    double? r,
    double? x,
    double? phase,
    VizSeries? vizSeries,
  }) {
    return VizData(
      freq: freq ?? this.freq,
      p_dlv: p_dlv ?? this.p_dlv,
      v: v ?? this.v,
      i: i ?? this.i,
      r: r ?? this.r,
      x: x ?? this.x,
      phase: phase ?? this.phase,
      vizSeries: vizSeries ?? this.vizSeries,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'freq': freq,
      'p_dlv': p_dlv,
      'v': v,
      'i': i,
      'r': r,
      'x': x,
      'phase': phase,
      'vizSeries': vizSeries.toMap(),
    };
  }

  factory VizData.fromMap(Map<String, dynamic> map) {
    return VizData(
      freq: map['freq']?.toDouble() ?? 0.0,
      p_dlv: map['p_dlv']?.toDouble() ?? 0.0,
      v: map['v']?.toDouble() ?? 0.0,
      i: map['i']?.toDouble() ?? 0.0,
      r: map['r']?.toDouble() ?? 0.0,
      x: map['x']?.toDouble() ?? 0.0,
      phase: map['phase']?.toDouble() ?? 0.0,
      vizSeries: VizSeries.fromMap(map['vizSeries']),
    );
  }

  String toJson() => json.encode(toMap());

  factory VizData.fromJson(String source) =>
      VizData.fromMap(json.decode(source));

  @override
  String toString() {
    return 'VizData(freq: $freq, p_dlv: $p_dlv, v: $v, i: $i, r: $r, x: $x, phase: $phase, vizSeries: $vizSeries)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is VizData &&
        other.freq == freq &&
        other.p_dlv == p_dlv &&
        other.v == v &&
        other.i == i &&
        other.r == r &&
        other.x == x &&
        other.phase == phase &&
        other.vizSeries == vizSeries;
  }

  @override
  int get hashCode {
    return freq.hashCode ^
        p_dlv.hashCode ^
        v.hashCode ^
        i.hashCode ^
        r.hashCode ^
        x.hashCode ^
        phase.hashCode ^
        vizSeries.hashCode;
  }
}

class VizSeries {
  RxBool toggle = true.obs;
  Color seriesColor = Color(0xFFEF5350);
  VizSeries({
    required this.toggle,
  });

  factory VizSeries.init() {
    return VizSeries(toggle: true.obs);
  }

  VizSeries copyWith({
    RxBool? toggle,
  }) {
    return VizSeries(
      toggle: toggle ?? this.toggle,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'toggle': toggle,
    };
  }

  factory VizSeries.fromMap(Map<String, dynamic> map) {
    return VizSeries(
      toggle: map['toggle'] ?? false.obs,
    );
  }

  String toJson() => json.encode(toMap());

  factory VizSeries.fromJson(String source) =>
      VizSeries.fromMap(json.decode(source));

  @override
  String toString() => 'VizSeries(toggle: $toggle)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is VizSeries && other.toggle.value == toggle.value;
  }

  @override
  int get hashCode => toggle.hashCode;
}
