import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wr_ui/view/right_side_menu/save_ini.dart';
import '../../oes_chart.dart';

class oneHoverChart extends GetView<OesController> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(20),
        child: GetBuilder<OesController>(
          builder: (controller) => Obx(() => OesChart().LineChartForm(
              controller: controller,
              lineBarsData: [
                OesChart().lineChartBarData(controller.oesData[0],
                    Get.find<iniController>().Series_Color_001.value),
              ],
              leftTitles: SideTitles(showTitles: false),
              bottomTitles: SideTitles(showTitles: false))),
        ));
  }
}

class twoHoverChart extends GetView<OesController> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(20),
        child: GetBuilder<OesController>(
          builder: (controller) => Obx(() => OesChart().LineChartForm(
              controller: controller,
              lineBarsData: [
                OesChart().lineChartBarData(controller.oesData[1],
                    Get.find<iniController>().Series_Color_002.value),
              ],
              leftTitles: SideTitles(showTitles: false),
              bottomTitles: SideTitles(showTitles: false))),
        ));
  }
}

class threeHoverChart extends GetView<OesController> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(20),
        child: GetBuilder<OesController>(
          builder: (controller) => Obx(() => OesChart().LineChartForm(
              controller: controller,
              lineBarsData: [
                OesChart().lineChartBarData(controller.oesData[2],
                    Get.find<iniController>().Series_Color_003.value),
              ],
              leftTitles: SideTitles(showTitles: false),
              bottomTitles: SideTitles(showTitles: false))),
        ));
  }
}

class fourHoverChart extends GetView<OesController> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(20),
        child: GetBuilder<OesController>(
          builder: (controller) => Obx(() => OesChart().LineChartForm(
              controller: controller,
              lineBarsData: [
                OesChart().lineChartBarData(controller.oesData[3],
                    Get.find<iniController>().Series_Color_004.value),
              ],
              leftTitles: SideTitles(showTitles: false),
              bottomTitles: SideTitles(showTitles: false))),
        ));
  }
}

class fiveHoverChart extends GetView<OesController> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(20),
        child: GetBuilder<OesController>(
          builder: (controller) => Obx(() => OesChart().LineChartForm(
              controller: controller,
              lineBarsData: [
                OesChart().lineChartBarData(controller.oesData[4],
                    Get.find<iniController>().Series_Color_005.value),
              ],
              leftTitles: SideTitles(showTitles: false),
              bottomTitles: SideTitles(showTitles: false))),
        ));
  }
}

class sixHoverChart extends GetView<OesController> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(20),
        child: GetBuilder<OesController>(
          builder: (controller) => Obx(() => OesChart().LineChartForm(
              controller: controller,
              lineBarsData: [
                OesChart().lineChartBarData(controller.oesData[5],
                    Get.find<iniController>().Series_Color_006.value),
              ],
              leftTitles: SideTitles(showTitles: false),
              bottomTitles: SideTitles(showTitles: false))),
        ));
  }
}

class sevenHoverChart extends GetView<OesController> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(20),
        child: GetBuilder<OesController>(
          builder: (controller) => Obx(() => OesChart().LineChartForm(
              controller: controller,
              lineBarsData: [
                OesChart().lineChartBarData(controller.oesData[6],
                    Get.find<iniController>().Series_Color_007.value),
              ],
              leftTitles: SideTitles(showTitles: false),
              bottomTitles: SideTitles(showTitles: false))),
        ));
  }
}

class eightHoverChart extends GetView<OesController> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(20),
        child: GetBuilder<OesController>(
          builder: (controller) => Obx(() => OesChart().LineChartForm(
              controller: controller,
              lineBarsData: [
                OesChart().lineChartBarData(controller.oesData[7],
                    Get.find<iniController>().Series_Color_008.value),
              ],
              leftTitles: SideTitles(showTitles: false),
              bottomTitles: SideTitles(showTitles: false))),
        ));
  }
}
