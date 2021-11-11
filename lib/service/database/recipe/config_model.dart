class Config {
  int? id;
  String name;
  String config;

  Config({
    this.id,
    required this.name,
    required this.config,
  });
  factory Config.fromSQLite(Map map) {
    return Config(
      id: map['id'],
      name: map['name'],
      config: map['config'],
    );
  }
  static List<Config> fromSQLiteList(List<Map> listMap) {
    List<Config> configs = [];
    for (Map item in listMap) {
      configs.add(Config.fromSQLite(item));
    }
    return configs;
  }

  factory Config.empty() {
    return Config(name: '', config: '');
  }
}
