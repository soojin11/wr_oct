import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OesData {
  RxBool oesToggle;
  Color oesColor;
  String fileName;
  AutoSave autoSave;
  OesData({
    required this.oesToggle,
    required this.oesColor,
    required this.fileName,
    required this.autoSave,
  });

  factory OesData.init() {
    return OesData(
        oesToggle: true.obs,
        oesColor: Color(0xFFEF5350),
        fileName: '',
        autoSave: AutoSave(autoSave: true, AutoSaveValue: 3000));
  }

  OesData copyWith({
    RxBool? oesToggle,
    Color? oesColor,
    String? fileName,
    AutoSave? autoSave,
  }) {
    return OesData(
      oesToggle: oesToggle ?? this.oesToggle,
      oesColor: oesColor ?? this.oesColor,
      fileName: fileName ?? this.fileName,
      autoSave: autoSave ?? this.autoSave,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'oesToggle': oesToggle,
      'oesColor': oesColor.value,
      'fileName': fileName,
      'autoSave': autoSave.toMap(),
    };
  }

  factory OesData.fromMap(Map<String, dynamic> map) {
    return OesData(
      oesToggle: map['oesToggle'] ?? false.obs,
      oesColor: Color(map['oesColor']),
      fileName: map['fileName'] ?? '',
      autoSave: AutoSave.fromMap(map['autoSave']),
    );
  }

  String toJson() => json.encode(toMap());

  factory OesData.fromJson(String source) =>
      OesData.fromMap(json.decode(source));

  @override
  String toString() {
    return 'OesData(oesToggle: $oesToggle, oesColor: $oesColor, fileName: $fileName, autoSave: $autoSave)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OesData &&
        other.oesToggle.value == oesToggle.value &&
        other.oesColor == oesColor &&
        other.fileName == fileName &&
        other.autoSave == autoSave;
  }

  @override
  int get hashCode {
    return oesToggle.hashCode ^
        oesColor.hashCode ^
        fileName.hashCode ^
        autoSave.hashCode;
  }
}

class AutoSave {
  bool autoSave;
  int AutoSaveValue;
  AutoSave({
    required this.autoSave,
    required this.AutoSaveValue,
  });

  AutoSave copyWith({
    bool? autoSave,
    int? AutoSaveValue,
  }) {
    return AutoSave(
      autoSave: autoSave ?? this.autoSave,
      AutoSaveValue: AutoSaveValue ?? this.AutoSaveValue,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'autoSave': autoSave,
      'AutoSaveValue': AutoSaveValue,
    };
  }

  factory AutoSave.fromMap(Map<String, dynamic> map) {
    return AutoSave(
      autoSave: map['autoSave'] ?? false,
      AutoSaveValue: map['AutoSaveValue']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory AutoSave.fromJson(String source) =>
      AutoSave.fromMap(json.decode(source));

  @override
  String toString() =>
      'AutoSave(autoSave: $autoSave, AutoSaveValue: $AutoSaveValue)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AutoSave &&
        other.autoSave == autoSave &&
        other.AutoSaveValue == AutoSaveValue;
  }

  @override
  int get hashCode => autoSave.hashCode ^ AutoSaveValue.hashCode;
}
