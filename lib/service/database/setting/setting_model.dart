import 'package:get/get.dart';

class OESSet {
  int? id;
  String? ExposureTime;
  String? DelayTime;

  OESSet({
    this.id,
    required this.ExposureTime,
    required this.DelayTime,
  });

  factory OESSet.fromSQLite(Map map) {
    return OESSet(
      id: map['id'],
      ExposureTime: map['ExposureTime'],
      DelayTime: map['DelayTime'],
    );
  }

  static List<OESSet> fromSQLiteList(List<Map> listMap) {
    List<OESSet> OESsets = [];
    for (Map item in listMap) {
      OESsets.add(OESSet.fromSQLite(item));
    }
    return OESsets;
  }

  factory OESSet.empty() {
    return OESSet(ExposureTime: '', DelayTime: '');
  }
}
