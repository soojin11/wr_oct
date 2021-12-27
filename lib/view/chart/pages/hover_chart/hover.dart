import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:wr_ui/controller/viz_ctrl.dart';

class HoverChart extends GetView<VizCtrl> {
  HoverChart({Key? key, required this.chart}) : super(key: key);
  var chart;
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(top: 5, right: 5, bottom: 10), child: chart);
  }
}
