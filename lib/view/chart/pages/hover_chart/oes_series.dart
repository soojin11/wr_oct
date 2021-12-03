import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wr_ui/view/right_side_menu/ini_creator.dart';
import '../../oes_chart.dart';


class oneHoverChart extends GetView<OesController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: GetBuilder<OesController>(
            builder: (controller) =>OesChart().LineChartForm(controller: controller, lineBarsData: [
        OesChart().lineChartBarData(controller.oneData, Get.find<iniControllerWithReactive>().Series_Color_001.value),
      ], leftTitles: SideTitles(showTitles: false), bottomTitles: SideTitles(showTitles: false))),
    );
  }
}

class twoHoverChart extends GetView<OesController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: GetBuilder<OesController>(
            builder: (controller) =>OesChart().LineChartForm(controller: controller, lineBarsData: [
        OesChart().lineChartBarData(controller.twoData, Get.find<iniControllerWithReactive>().Series_Color_002.value),
      ], leftTitles: SideTitles(showTitles: false), bottomTitles: SideTitles(showTitles: false))),
    );
  }
}

class threeHoverChart extends GetView<OesController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: GetBuilder<OesController>(
            builder: (controller) =>OesChart().LineChartForm(controller: controller, lineBarsData:[
        OesChart().lineChartBarData(controller.threeData, Get.find<iniControllerWithReactive>().Series_Color_003.value),
      ], leftTitles: SideTitles(showTitles: false), bottomTitles: SideTitles(showTitles: false))),
    );
  }
}

class fourHoverChart extends GetView<OesController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: GetBuilder<OesController>(
            builder: (controller) =>OesChart().LineChartForm(controller:controller, lineBarsData: [
        OesChart().lineChartBarData(controller.fourData, Get.find<iniControllerWithReactive>().Series_Color_004.value),
      ], leftTitles: SideTitles(showTitles: false), bottomTitles: SideTitles(showTitles: false))),
    );
  }
}

class fiveHoverChart extends GetView<OesController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: GetBuilder<OesController>(
            builder: (controller) =>OesChart().LineChartForm(controller: controller, lineBarsData: [
        OesChart().lineChartBarData(controller.fiveData, Get.find<iniControllerWithReactive>().Series_Color_005.value),
      ], leftTitles: SideTitles(showTitles: false), bottomTitles: SideTitles(showTitles: false))),
    );
  }
}
class sixHoverChart extends GetView<OesController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: GetBuilder<OesController>(
            builder: (controller) =>OesChart().LineChartForm(controller: controller, lineBarsData : [
        OesChart().lineChartBarData(controller.sixData, Get.find<iniControllerWithReactive>().Series_Color_006.value),
      ], leftTitles: SideTitles(showTitles: false), bottomTitles: SideTitles(showTitles: false))),
    );
  }
}
class sevenHoverChart extends GetView<OesController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: GetBuilder<OesController>(
            builder: (controller) =>OesChart().LineChartForm(controller: controller, lineBarsData: [
        OesChart().lineChartBarData(controller.sevenData, Get.find<iniControllerWithReactive>().Series_Color_007.value),
      ], leftTitles: SideTitles(showTitles: false), bottomTitles: SideTitles(showTitles: false))),
    );
  }
}
class eightHoverChart extends GetView<OesController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: GetBuilder<OesController>(
            builder: (controller) =>OesChart().LineChartForm(controller: controller, lineBarsData: [
        OesChart().lineChartBarData(controller.eightData, Get.find<iniControllerWithReactive>().Series_Color_008.value),
      ], leftTitles: SideTitles(showTitles: false), bottomTitles: SideTitles(showTitles: false))),
    );
  }
}
