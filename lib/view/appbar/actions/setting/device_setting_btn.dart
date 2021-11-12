import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wr_ui/model/const/style/pallette.dart';
import 'package:wr_ui/view/appbar/actions/setting/device_setting_page.dart';

class DeviceSettingBtn extends StatelessWidget {
  const DeviceSettingBtn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ElevatedButton.icon(
        onPressed: () {
          Get.to(() => Settings());
        },
        icon: Icon(Icons.settings),
        label: Text('Device Setting'),
        style: ElevatedButton.styleFrom(primary: wrColors.wrPrimary),
      ),
    );
  }
}
