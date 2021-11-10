import 'package:sqflite/sqflite.dart';
import 'package:wr_ui/service/database/config_model.dart';
import 'package:wr_ui/service/database/connection_sqlite_service.dart';
import 'package:wr_ui/service/database/sql.dart';

class ConfigDAO {
  ConnectionSQLiteService _connection = ConnectionSQLiteService.instance;

  Future<Database> _getDatabase() async {
    return await _connection.db;
  }

  Future<Config> addNewConfigDao(Config config) async {
    try {
      Database db = await _getDatabase();
      int id = await db.rawInsert(ConnectionSQL.addNewConfig(config));
      config.id = id;
      return config;
    } catch (error) {
      throw Exception();
    }
  }

  Future<bool> modifyConfigDao(Config config) async {
    try {
      Database db = await _getDatabase();
      int linhasAfetadas =
          await db.rawUpdate(ConnectionSQL.modifyConfig(config));
      if (linhasAfetadas > 0) {
        print('linhasAfetadas??' + linhasAfetadas.toString());
        return true;
      }
      return false;
    } catch (error) {
      throw Exception();
    }
  }

  Future<List<Config>> selectConfigDao() async {
    try {
      Database db = await _getDatabase();
      List<Map> linhas = await db.rawQuery(ConnectionSQL.selectConfig());
      print('linhas??' + linhas.toString());
      List<Config> config = Config.fromSQLiteList(linhas);
      return config;
    } catch (error) {
      throw Exception();
    }
  }

  Future<bool> deleteConfigDao(Config config) async {
    try {
      Database db = await _getDatabase();
      int linhasAfetadas =
          await db.rawUpdate(ConnectionSQL.deleteConfig(config));
      if (linhasAfetadas > 0) {
        return true;
      }
      return false;
    } catch (error) {
      throw Exception();
    }
  }
}
