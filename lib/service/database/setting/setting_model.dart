class Deviceset {
  int? id;
  String devicename;
  double interval;
  String unit;

  Deviceset(
      {this.id,
      required this.devicename,
      required this.interval,
      required this.unit});

  factory Deviceset.fromSQLite(Map map) {
    return Deviceset(
      id: map['id'],
      devicename: map['devicename'],
      interval: map['interval'],
      unit: map['unit'],
    );
  }

  static List<Deviceset> fromSQLiteList(List<Map> listMap) {
    List<Deviceset> devicesets = [];
    for (Map item in listMap) {
      devicesets.add(Deviceset.fromSQLite(item));
    }
    return devicesets;
  }

  factory Deviceset.empty() {
    return Deviceset(devicename: '', interval: 0.0, unit: '');
  }
}
