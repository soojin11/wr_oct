import 'package:sqflite/sqflite.dart';
import 'package:wr_ui/service/database/recipe/connection_sqlite_service.dart';
import 'package:wr_ui/service/database/recipe/sql.dart';
import 'package:wr_ui/service/database/setting/setting_model.dart';
import 'package:wr_ui/service/database/setting/setting_sql.dart';

class DevicesetDAO {
  ConnectionSQLiteService _connection = ConnectionSQLiteService.instance;

  Future<Database> _getDatabase() async {
    return await _connection.db;
  }

  Future<Deviceset> addNewDevicesetDao(Deviceset deviceset) async {
    try {
      Database db = await _getDatabase();
      int id = await db.rawInsert(deviceSQL.addDevice(deviceset));
      deviceset.id = id;
      return deviceset;
    } catch (error) {
      throw Exception();
    }
  }

  Future<bool> modifyDevicesetDao(Deviceset deviceset) async {
    try {
      Database db = await _getDatabase();
      int ccc = await db.rawUpdate(deviceSQL.updateDevice(deviceset));
      if (ccc > 0) {
        print('ccc??' + ccc.toString());
        return true;
      }
      return false;
    } catch (error) {
      throw Exception();
    }
  }

  Future<List<Deviceset>> selectDevicesetDao() async {
    try {
      Database db = await _getDatabase();
      List<Map> bbb = await db.rawQuery(deviceSQL.selectDevice());
      print('bbb??' + bbb.toString());
      List<Deviceset> deviceset = Deviceset.fromSQLiteList(bbb);
      return deviceset;
    } catch (error) {
      throw Exception();
    }
  }

  Future<bool> deleteDevicesetDao(Deviceset deviceset) async {
    try {
      Database db = await _getDatabase();
      int ccc = await db.rawUpdate(deviceSQL.deleteDevice(deviceset));
      if (ccc > 0) {
        return true;
      }
      return false;
    } catch (error) {
      throw Exception();
    }
  }
}
