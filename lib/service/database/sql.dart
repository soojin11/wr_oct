import 'package:wr_ui/service/database/config_model.dart';

class ConnectionSQL {
  static final CREATE_DATABASE = '''
  CREATE TABLE "configs" (
    `id`	INTEGER PRIMARY KEY AUTOINCREMENT,
    `name`	TEXT,
    `config`	TEXT
  );
  ''';

  static String selectConfig() {
    return 'select * from configs;';
  }

  static String addNewConfig(Config config) {
    return '''
    insert into configs (name, config)
    values ('${config.name}', '${config.config}');
    ''';
  }

  static String modifyConfig(Config config) {
    return '''
    update configs
    set name = '${config.name}',
    config = '${config.config}'
    where id = ${config.id};
    ''';
  }

  static String deleteConfig(Config config) {
    return 'delete from configs where id = ${config.id};';
  }
}
