import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wr_ui/controller/setting_controller.dart';

class RecentRecipeName extends StatelessWidget {
  const RecentRecipeName({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 5, left: 70, right: 70),
      child: Center(
        child: Text(
          '${Get.find<SettingController>().chartName.value}',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
