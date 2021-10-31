// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:ini/ini.dart';
// import 'dart:io';

// import 'package:path_provider/path_provider.dart';

// class iniBtn extends StatelessWidget {
//   const iniBtn({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(onPressed: () {}, child: Text('to *.ini'));
//   }
// }

// ////파일저장
// class iniControllerWithReactive extends GetxController {
//   static iniControllerWithReactive get to => Get.find();
//   RxString path = ''.obs;
//   RxBool fileSave = false.obs;
//   RxBool ig = false.obs;
//   @override
//   void onInit() {
//     super.onInit();
//   }

//   Future<File>
// }

// ////파일저장
// ////////////////////////////
// Future<String> get _localPath async {
//   final directory = await getApplicationDocumentsDirectory();
// //
//   return directory.path;
// }

// Future<File> get _localGlobalsFile async {
//   final path = await _localPath;
//   return File('./$path/globals.ini');
// }

// File file = new File("./datafiles/config.ini");

// void doConfigThings(Config OES, String label) {
//   print("${label}: loaded config from ${file.path}");
//   print('');

//   print("${label}: Read some values...");
//   print("${label}: ${OES.hasOption('default', 'default')}");
//   print("${label}: ${OES.defaults()["default"]}");
//   print("${label}: ${OES.get("section", "section")}");
//   print('');

//   print("${label}: Write some values...");
//   OES.addSection("OES");
//   OES.set("OES", "IP", "192.168.0.1");
//   OES.set("OES", "PORT", "9000");
//   OES.set("OES", "NAME", "qqq");
//   print("${label}: Added a new section and entry");
//   print('');

//   print("${label}: Write out config (to screen)");
//   print("${label}: ${OES.toString()}");
// }

// void main() {
//   file
//       .readAsLines()
//       .then((lines) => new Config.fromStrings(lines))
//       .then((Config config) {
//     doConfigThings(config, "async");
//   });

//   Config config = new Config.fromStrings(file.readAsLinesSync());
// }
