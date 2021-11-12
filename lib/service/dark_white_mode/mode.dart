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
      backgroundColor: Colors.grey[50],
      appBarTheme: AppBarTheme(
        color: wrColors.wrPrimary,
        elevation: 0,
      ));
  static final dark = ThemeData(
    primaryColor: Colors.black,
    brightness: Brightness.dark,
    appBarTheme: AppBarTheme(
      color: wrColors.wrDarkPrimary,
      elevation: 0,

      actionsIconTheme: IconThemeData(color: Colors.black),
      titleTextStyle: TextStyle(color: Colors.amber),
      // toolbarTextStyle: TextStyle(color: Colors.black),
    ),
    textTheme: TextTheme(
      bodyText2: TextStyle(color: Colors.black),
    ),
    dividerTheme: DividerThemeData(
      color: Colors.black,
    ),

    // scaffoldBackgroundColor: Colors.amber
  );
}

//다크 화이트모드