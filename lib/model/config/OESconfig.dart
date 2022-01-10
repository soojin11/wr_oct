import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:wr_ui/view/right_side_menu/save_ini.dart';

class OesConfig {
  int integrationTime;
  bool autoSave;
  int autoSaveVal;
  bool simulation;
  List channelFlow;
  OesConfig({
    required this.integrationTime,
    required this.autoSave,
    required this.autoSaveVal,
    required this.simulation,
    required this.channelFlow,
  });

  factory OesConfig.init() {
    return OesConfig(
        integrationTime: iniController.to.integrationTime.value,
        autoSave: iniController.to.checkAuto.value,
        autoSaveVal: iniController.to.oesAutoSaveVal.value,
        simulation: iniController.to.oesSim.value,
        channelFlow: iniController.to.channelFlow);
  }

  OesConfig copyWith({
    int? integrationTime,
    bool? autoSave,
    int? autoSaveVal,
    bool? simulation,
    List? channelFlow,
  }) {
    return OesConfig(
      integrationTime: integrationTime ?? this.integrationTime,
      autoSave: autoSave ?? this.autoSave,
      autoSaveVal: autoSaveVal ?? this.autoSaveVal,
      simulation: simulation ?? this.simulation,
      channelFlow: channelFlow ?? this.channelFlow,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'integrationTime': integrationTime,
      'autoSave': autoSave,
      'autoSaveVal': autoSaveVal,
      'simulation': simulation,
      'channelFlow': channelFlow,
    };
  }

  factory OesConfig.fromMap(Map<String, dynamic> map) {
    return OesConfig(
      integrationTime: map['integrationTime']?.toInt() ?? 0.0,
      autoSave: map['autoSave'] ?? false,
      autoSaveVal: map['autoSaveVal']?.toInt() ?? 0.0,
      simulation: map['simulation'] ?? false,
      channelFlow: List.from(map['channelFlow']),
    );
  }

  String toJson() => json.encode(toMap());

  factory OesConfig.fromJson(String source) =>
      OesConfig.fromMap(json.decode(source));

  @override
  String toString() {
    return 'OesConfig(integrationTime: $integrationTime, autoSave: $autoSave, autoSaveVal: $autoSaveVal, simulation: $simulation, channelFlow: $channelFlow)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OesConfig &&
        other.integrationTime == integrationTime &&
        other.autoSave == autoSave &&
        other.autoSaveVal == autoSaveVal &&
        other.simulation == simulation &&
        listEquals(other.channelFlow, channelFlow);
  }

  @override
  int get hashCode {
    return integrationTime.hashCode ^
        autoSave.hashCode ^
        autoSaveVal.hashCode ^
        simulation.hashCode ^
        channelFlow.hashCode;
  }
}
