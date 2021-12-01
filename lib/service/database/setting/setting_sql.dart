import 'package:wr_ui/service/database/setting/setting_model.dart';

class OESSQL {
  static final CREATE_DATABASE =
      '''CREATE TABLE "OESsets"(`id`	INTEGER PRIMARY KEY AUTOINCREMENT,
`ExposureTime` TEXT,
`DelayTime` TEXT);''';
  static String selectOES() {
    return 'select * from OESsets;';
  }

  static String addOES(OESSet OESset) {
    return '''insert into OESsets(ExposureTime,DelayTime) values('${OESset.ExposureTime},'${OESset.DelayTime}');''';
  }

  static String updateOES(OESSet OESset) {
    return '''
    update OESsets
    set ExposureTime='${OESset.ExposureTime}',
    DelayTime='${OESset.DelayTime}',
    where id=${OESset.id};
    ''';
  }

  static String deleteOES(OESSet OESset) {
    return 'delete from OESsets where id = ${OESset.id};';
  }
}
