import 'package:wr_ui/service/database/setting/setting_model.dart';

class deviceSQL {
  static final CREATE_DATABASE =
      '''CREATE TABLE "devicesets"(`id`	INTEGER PRIMARY KEY AUTOINCREMENT,
`devicename` TEXT,
`interval` REAL,
`unit` TEXT);''';
  static String selectDevice() {
    return 'select * from devicesets;';
  }

  static String addDevice(Deviceset deviceset) {
    return '''insert into devicesets(devicename,interval,unit) values('${deviceset.devicename},'${deviceset.interval}','${deviceset.unit}');''';
  }

  static String updateDevice(Deviceset deviceset) {
    return '''
    update devicesets
    set devicename='${deviceset.devicename}',
    interval='${deviceset.interval}',
    unit='${deviceset.unit}',
    where id=${deviceset.id};
    ''';
  }

  static String deleteDevice(Deviceset deviceset) {
    return 'delete from devicesets where id = ${deviceset.id};';
  }
}
