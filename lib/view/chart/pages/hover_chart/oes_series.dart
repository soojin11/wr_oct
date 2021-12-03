import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:wr_ui/view/appbar/actions/setting/setting_menu_final.dart';
import '../../oes_chart.dart';


class oneHoverChart extends GetView<OesController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: GetBuilder<OesController>(
            builder: (controller) =>OesChart().LineChartForm(controller: controller, lineBarsData: [
        OesChart().lineChartBarData(controller.oneData, Colors.red[400]),
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
        OesChart().lineChartBarData(controller.twoData, Colors.orange),
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
        OesChart().lineChartBarData(controller.threeData, Colors.amber),
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
        OesChart().lineChartBarData(controller.fourData, Colors.green[300]),
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
        OesChart().lineChartBarData(controller.fiveData, Colors.blue[300]),
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
        OesChart().lineChartBarData(controller.sixData, Colors.blue[700]),
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
        OesChart().lineChartBarData(controller.sevenData, Colors.purple[300]),
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
        OesChart().lineChartBarData(controller.eightData, Colors.pink[100]),
      ], leftTitles: SideTitles(showTitles: false), bottomTitles: SideTitles(showTitles: false))),
    );
  }
}
