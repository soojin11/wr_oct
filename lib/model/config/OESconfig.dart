import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:wr_ui/view/right_side_menu/save_ini.dart';

class OesConfig {
  int integrationTime;
  bool autoSave;
  int autoSaveVal;
  List channelFlow;
  int oesComPort;
  OesConfig({
    required this.integrationTime,
    required this.autoSave,
    required this.autoSaveVal,
    required this.channelFlow,
    required this.oesComPort,
  });
  factory OesConfig.init() {
    return OesConfig(
        integrationTime: iniController.to.integrationTime.value,
        autoSave: iniController.to.checkAuto.value,
        autoSaveVal: iniController.to.oesAutoSaveVal.value,
        channelFlow: iniController.to.channelFlow,
        oesComPort: iniController.to.oes_comport.value);
  }

  OesConfig copyWith({
    int? integrationTime,
    bool? autoSave,
    int? autoSaveVal,
    List? channelFlow,
    int? oesComPort,
  }) {
    return OesConfig(
      integrationTime: integrationTime ?? this.integrationTime,
      autoSave: autoSave ?? this.autoSave,
      autoSaveVal: autoSaveVal ?? this.autoSaveVal,
      channelFlow: channelFlow ?? this.channelFlow,
      oesComPort: oesComPort ?? this.oesComPort,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'integrationTime': integrationTime,
      'autoSave': autoSave,
      'autoSaveVal': autoSaveVal,
      'channelFlow': channelFlow,
      'oesComPort': oesComPort,
    };
  }

  factory OesConfig.fromMap(Map<String, dynamic> map) {
    return OesConfig(
      integrationTime: map['integrationTime']?.toInt() ?? 0,
      autoSave: map['autoSave'] ?? false,
      autoSaveVal: map['autoSaveVal']?.toInt() ?? 0,
      channelFlow: List.from(map['channelFlow']),
      oesComPort: map['oesComPort']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory OesConfig.fromJson(String source) =>
      OesConfig.fromMap(json.decode(source));

  @override
  String toString() {
    return 'OesConfig(integrationTime: $integrationTime, autoSave: $autoSave, autoSaveVal: $autoSaveVal, channelFlow: $channelFlow, oesComPort: $oesComPort)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OesConfig &&
        other.integrationTime == integrationTime &&
        other.autoSave == autoSave &&
        other.autoSaveVal == autoSaveVal &&
        listEquals(other.channelFlow, channelFlow) &&
        other.oesComPort == oesComPort;
  }

  @override
  int get hashCode {
    return integrationTime.hashCode ^
        autoSave.hashCode ^
        autoSaveVal.hashCode ^
        channelFlow.hashCode ^
        oesComPort.hashCode;
  }
}
