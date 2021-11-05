import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wr_ui/main.dart';
import 'package:wr_ui/style/pallette.dart';
import 'package:wr_ui/ui/appbar/device_setting_page.dart';

class ReturnHomePage extends StatelessWidget {
  const ReturnHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ElevatedButton.icon(
        onPressed: () {
          Get.to(() => Home());
        },
        icon: Icon(Icons.home),
        label: Text('Home'),
        style: ElevatedButton.styleFrom(primary: WrColors.wrPrimary),
      ),
    );
  }
}
