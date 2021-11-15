import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wr_ui/model/const/style/pallette.dart';
import 'package:wr_ui/view/appbar/actions/setting/chart_setting_page.dart';

class ChartSettingBtn extends StatelessWidget {
  const ChartSettingBtn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ElevatedButton.icon(
        onPressed: () {
          Get.to(() => ChartSettings());
        },
        icon: Icon(Icons.auto_graph_sharp),
        label: Text('Chart Setting'),
        style: ElevatedButton.styleFrom(primary: wrColors.wrPrimary),
      ),
    );
  }
}
