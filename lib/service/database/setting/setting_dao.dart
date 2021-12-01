import 'package:sqflite/sqflite.dart';
import 'package:wr_ui/service/database/recipe/connection_sqlite_service.dart';
import 'package:wr_ui/service/database/setting/setting_model.dart';
import 'package:wr_ui/service/database/setting/setting_sql.dart';

class OESsetDAO {
  ConnectionSQLiteService _connection = ConnectionSQLiteService.instance;

  Future<Database> _getDatabase() async {
    return await _connection.db;
  }

  Future<OESSet> addNewOESsetDao(OESSet OESset) async {
    try {
      Database db = await _getDatabase();
      int id = await db.rawInsert(OESSQL.addOES(OESset));
      OESset.id = id;
      return OESset;
    } catch (error) {
      throw Exception();
    }
  }

  Future<bool> modifyOESsetDao(OESSet OESset) async {
    try {
      Database db = await _getDatabase();
      int ccc = await db.rawUpdate(OESSQL.updateOES(OESset));
      if (ccc > 0) {
        print('ccc??' + ccc.toString());
        return true;
      }
      return false;
    } catch (error) {
      throw Exception();
    }
  }

  Future<List<OESSet>> selectOESsetDao() async {
    try {
      Database db = await _getDatabase();
      List<Map> bbb = await db.rawQuery(OESSQL.selectOES());
      print('bbb??' + bbb.toString());
      List<OESSet> OESset = OESSet.fromSQLiteList(bbb);
      return OESset;
    } catch (error) {
      throw Exception();
    }
  }

  Future<bool> deleteOESsetDao(OESSet OESset) async {
    try {
      Database db = await _getDatabase();
      int ccc = await db.rawUpdate(OESSQL.deleteOES(OESset));
      if (ccc > 0) {
        return true;
      }
      return false;
    } catch (error) {
      throw Exception();
    }
  }
}
