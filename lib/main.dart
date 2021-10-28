import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wr_ui/home.dart';
import 'package:wr_ui/ui/widgets/save_file.dart';
import 'package:wr_ui/wr_home_page.dart';

Future main() async {
  Get.put(ControllerWithReactive());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'WR',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home(),
      getPages: [GetPage(name: '/', page: () => Home())],
    );
  }
}
