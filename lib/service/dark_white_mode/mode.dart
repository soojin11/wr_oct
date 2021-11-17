import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:wr_ui/model/const/style/pallette.dart';

class ThemeService {
  final _box = GetStorage();
  final _key = 'isDarkMode';
  _saveThemeToBox(bool isDarkMode) => _box.write(_key, isDarkMode);

  bool _loadThemeFromBox() => _box.read(_key) ?? false;
  ThemeMode get theme => _loadThemeFromBox() ? ThemeMode.dark : ThemeMode.light;
  void switchTheme() {
    Get.changeThemeMode(_loadThemeFromBox() ? ThemeMode.light : ThemeMode.dark);
    _saveThemeToBox(!_loadThemeFromBox());
  }
}

class Themes {
  static final light = ThemeData(
    scaffoldBackgroundColor: Colors.transparent,
    //컨테이너 색

    backgroundColor: Colors.grey[50],
    //컨테이너 색
    shadowColor: Colors.grey.withOpacity(0.2),
    appBarTheme: AppBarTheme(
      color: wrColors.wrPrimary,
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    textTheme: TextTheme(
      bodyText2: TextStyle(
        color: Colors.blueGrey[800],
        fontWeight: FontWeight.bold,
      ),
    ),
  );
  static final dark = ThemeData(
    scaffoldBackgroundColor: Colors.transparent,
    shadowColor: Colors.black26,
    backgroundColor: wrColors.wrDarkbg,
    brightness: Brightness.dark,
    appBarTheme: AppBarTheme(
      color: Colors.blueGrey[800],
      foregroundColor: wrColors.wrDarkAppBar,
      elevation: 0,

      actionsIconTheme: IconThemeData(color: Colors.black),
      titleTextStyle: TextStyle(color: Colors.amber),
      // toolbarTextStyle: TextStyle(color: Colors.black),
    ),
    textTheme: TextTheme(
      // subtitle1: TextStyle(color: Colors.white),
      // subtitle2: TextStyle(color: Colors.white),
      // overline: TextStyle(color: Colors.white),
      // bodyText1: TextStyle(color: Colors.white),
      bodyText2: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    ),
    dividerTheme: DividerThemeData(
      color: Color(0xff37383a),
    ),
    // cardTheme: CardTheme(color: Colors.amber),
  );
}

class NavThemes {}



//다크 화이트모드