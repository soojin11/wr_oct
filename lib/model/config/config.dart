import 'dart:convert';
import 'package:wr_ui/model/config/VIZconfig.dart';
import 'OESconfig.dart';

class ConfigWR {
  OesConfig oesConfig;
  VizConfig vizConfig;
  ConfigWR({
    required this.oesConfig,
    required this.vizConfig,
  });

  factory ConfigWR.init() {
    return ConfigWR(oesConfig: OesConfig.init(), vizConfig: VizConfig.init());
  }

  ConfigWR copyWith({
    OesConfig? oesConfig,
    VizConfig? vizConfig,
  }) {
    return ConfigWR(
      oesConfig: oesConfig ?? this.oesConfig,
      vizConfig: vizConfig ?? this.vizConfig,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'oesConfig': oesConfig.toMap(),
      'vizConfig': vizConfig.toMap(),
    };
  }

  factory ConfigWR.fromMap(Map<String, dynamic> map) {
    return ConfigWR(
      oesConfig: OesConfig.fromMap(map['oesConfig']),
      vizConfig: VizConfig.fromMap(map['vizConfig']),
    );
  }

  String toJson() => json.encode(toMap());

  factory ConfigWR.fromJson(String source) =>
      ConfigWR.fromMap(json.decode(source));

  @override
  String toString() => 'Config(oesConfig: $oesConfig, vizConfig: $vizConfig)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ConfigWR &&
        other.oesConfig == oesConfig &&
        other.vizConfig == vizConfig;
  }

  @override
  int get hashCode => oesConfig.hashCode ^ vizConfig.hashCode;
}
