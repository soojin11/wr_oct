import 'dart:async';
import 'dart:ffi';
import 'package:ffi/ffi.dart';
import 'dart:math' as math;
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wr_ui/main.dart';
import 'package:wr_ui/view/right_side_menu/csv_creator.dart';
import 'package:wr_ui/view/right_side_menu/ini_creator.dart';
import 'package:wr_ui/view/right_side_menu/log_screen.dart';

/////////////밑에 랜덤데이터 있음
class OesController extends GetxController {
  RxList<FlSpot> oneData = RxList.empty();
  RxList<FlSpot> twoData = RxList.empty();
  RxList<FlSpot> threeData = RxList.empty();
  RxList<FlSpot> fourData = RxList.empty();
  RxList<FlSpot> fiveData = RxList.empty();
  RxList<FlSpot> sixData = RxList.empty();
  RxList<FlSpot> sevenData = RxList.empty();
  RxList<FlSpot> eightData = RxList.empty();
  RxBool inactiveBtn = false.obs;

  RxBool checkVal1 = true.obs;
  RxBool checkVal2 = true.obs;
  RxBool checkVal3 = true.obs;
  RxBool checkVal4 = true.obs;
  RxBool checkVal5 = true.obs;
  RxBool checkVal6 = true.obs;
  RxBool checkVal7 = true.obs;
  RxBool checkVal8 = true.obs;

  late Timer timer;
  RxBool bRunning = false.obs;
  @override
  void onInit() {
    super.onInit();
  }

  double setRandom() {
    double yValue = math.Random().nextInt(50).toDouble();
    //여기
    return yValue;
  }

  Future<void> updateDataSource(Timer timer) async {
    print("in compute");
    //채널 위치이동 1->3->5->7->8->6->4->2->1->3...(ini에 고정)
    // if (false == Get.find<OesController>().bRunning.value) {
    //   //if문에서 비교할때는 const를 앞에
    //   return updateDataSource(timer);
    // }
    var channelNuminINI =
        Get.find<iniControllerWithReactive>().channelFlow.value;
    // var aaa = int.parse(channelNuminINI[6]);
    // var aaaaaaaaaa = int.parse(channelNuminINI[7]);
    // print('channelNuminINI : $channelNuminINI');
    // print('channelNuminINI 를 parse : $aaa   $aaaaaaaaaa  ');
    // Pointer<Double> fmtSpec = nullptr;
    for (var nChCnt = 0; nChCnt < channelNuminINI.length; nChCnt++) {
      //초기 채널 1
      print('nChCnt??  $nChCnt');
      print('${screenTime()}');
      // await Future.delayed(Duration(milliseconds: 50));
      //test용 ,,타이머를 몇으로 돌릴지 integration time
      //(움직이는시간+빛모으는시간)*8???
      //최대시간이 150millisecond안에는 무조건 움직인다.(두칸 300미리//인티그레이션 100->400*8=3.2초..?)
      int nChannel = int.parse(channelNuminINI[nChCnt]) - 1;
      mpmSetChannel(nChannel);

      //데이터 수집준비 -분광기Integration&channel값
      // fmtSpec = getformatSpec(0);
      List<double> fmtSpec = await readData(0);

      double dTemp = 0.0;
      switch (nChannel) {
        case 0:
          Get.find<OesController>().oneData.clear();
          for (var i = 0; i < listWavelength.length; i++) {
            dTemp = fmtSpec[i].toDouble();
            // print('fmtSpec?????   ${dTemp}');
            Get.find<OesController>()
                .oneData
                .add(FlSpot(listWavelength[i], fmtSpec[i]));
            //print('fmtSpec?????   ${fmtSpec[i]}');
          }
          //calloc.free(fmtSpec);
          break;

        case 1:
          Get.find<OesController>().twoData.clear();
          for (var i = 0; i < listWavelength.length; i++) {
            Get.find<OesController>()
                .twoData
                .add(FlSpot(listWavelength[i], fmtSpec[i]));
          }
          break;
        case 2:
          Get.find<OesController>().threeData.clear();
          for (var i = 0; i < listWavelength.length; i++) {
            Get.find<OesController>()
                .threeData
                .add(FlSpot(listWavelength[i], fmtSpec[i]));
          }
          break;
        case 3:
          Get.find<OesController>().fourData.clear();
          for (var i = 0; i < listWavelength.length; i++) {
            Get.find<OesController>()
                .fourData
                .add(FlSpot(listWavelength[i], fmtSpec[i]));
          }
          break;
        case 4:
          Get.find<OesController>().fiveData.clear();
          for (var i = 0; i < listWavelength.length; i++) {
            Get.find<OesController>()
                .fiveData
                .add(FlSpot(listWavelength[i], fmtSpec[i]));
          }
          break;
        case 5:
          Get.find<OesController>().sixData.clear();
          for (var i = 0; i < listWavelength.length; i++) {
            Get.find<OesController>()
                .sixData
                .add(FlSpot(listWavelength[i], fmtSpec[i]));
          }
          break;
        case 6:
          Get.find<OesController>().sevenData.clear();
          for (var i = 0; i < listWavelength.length; i++) {
            Get.find<OesController>()
                .sevenData
                .add(FlSpot(listWavelength[i], fmtSpec[i]));
          }
          break;

        case 7:
          Get.find<OesController>().eightData.clear();
          for (var i = 0; i < listWavelength.length; i++) {
            Get.find<OesController>()
                .eightData
                .add(FlSpot(listWavelength[i], fmtSpec[i]));
          }
          break;
      }

      // for (var i = 0; i < int.parse(channelNuminINI[i]); i++) {
      //   print('mpmSetChannel(ii) ${mpmSetChannel(ii)}');
      //   oneData.add(FlSpot(getwveLength[i], fmtSpec[i]));
      //   twoData.add(FlSpot(getwveLength[i], fmtSpec[i]));
      //   threeData.add(FlSpot(getwveLength[i], fmtSpec[i]));
      //   fourData.add(FlSpot(getwveLength[i], fmtSpec[i]));
      //   fiveData.add(FlSpot(getwveLength[i], fmtSpec[i]));
      //   sixData.add(FlSpot(getwveLength[i], fmtSpec[i]));
      //   sevenData.add(FlSpot(getwveLength[i], fmtSpec[i]));
      //   eightData.add(FlSpot(getwveLength[i], fmtSpec[i]));
      // }

    }

    if (Get.find<CsvController>().fileSave.value)
      await Get.find<CsvController>().csvSave();
    if (Get.find<CsvController>().fileSave2.value)
      await Get.find<CsvController>().SecondcsvSave();
    if (Get.find<CsvController>().fileSave3.value)
      await Get.find<CsvController>().ThirdcsvSave();
    if (Get.find<CsvController>().fileSave4.value)
      await Get.find<CsvController>().FourthcsvSave();
    if (Get.find<CsvController>().fileSave5.value)
      await Get.find<CsvController>().FifthcsvSave();
    if (Get.find<CsvController>().fileSave6.value)
      await Get.find<CsvController>().SixthcsvSave();
    if (Get.find<CsvController>().fileSave7.value)
      await Get.find<CsvController>().SeventhcsvSave();
    if (Get.find<CsvController>().fileSave8.value)
      await Get.find<CsvController>().EightcsvSave();

    update();
  }
}

// Future<bool> getOesData(Timer timer) async {
//   return await compute(Get.find<OesController>().updateDataSource, timer);
// }

// Future<void> getOesData(Timer timer) async {
//   Get.put(OesController());
//   await Get.find<OesController>().updateDataSource(timer);
//   // compute(Get.find<OesController>().updateDataSource, timer);

//   // .then((value) => (value) {});
// }
///////////
Future<List<FlSpot>> createDoubleFunction() async {
  int value = 760;
  List<FlSpot> val = await compute(doubleFunction, value);
  return val;
}

List<FlSpot> doubleFunction(int value) {
  List<FlSpot> oneData = [];
  for (var i = 0; i < value; i++) {
    oneData.add(FlSpot(i.toDouble(), math.Random().nextInt(50).toDouble()));
  }
  return oneData;
}

////////////////////
Future<bool> func(Timer arg) async {
  print("in compute");
  return true;
}

class OesChart extends GetView<OesController> {
  OesChart({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    //final controller = Get.put(OesController());
    return Container(
      padding: EdgeInsets.only(top: 20),
      child: GetBuilder<OesController>(
        builder: (controller) => InteractiveViewer(
          child: Container(
            padding: EdgeInsets.only(left: 20, right: 20, top: 10),
            child: LineChartForm(
              controller: controller,
              lineBarsData: [
                if (controller.checkVal1.value)
                  lineChartBarData(
                      controller.oneData,
                      Get.find<iniControllerWithReactive>()
                          .Series_Color_001
                          .value),
                if (controller.checkVal2.value)
                  lineChartBarData(
                      controller.twoData,
                      Get.find<iniControllerWithReactive>()
                          .Series_Color_002
                          .value),
                if (controller.checkVal3.value)
                  lineChartBarData(
                      controller.threeData,
                      Get.find<iniControllerWithReactive>()
                          .Series_Color_003
                          .value),
                if (controller.checkVal4.value)
                  lineChartBarData(
                      controller.fourData,
                      Get.find<iniControllerWithReactive>()
                          .Series_Color_004
                          .value),
                if (controller.checkVal5.value)
                  lineChartBarData(
                      controller.fiveData,
                      Get.find<iniControllerWithReactive>()
                          .Series_Color_005
                          .value),
                if (controller.checkVal6.value)
                  lineChartBarData(
                      controller.sixData,
                      Get.find<iniControllerWithReactive>()
                          .Series_Color_006
                          .value),
                if (controller.checkVal7.value)
                  lineChartBarData(
                      controller.sevenData,
                      Get.find<iniControllerWithReactive>()
                          .Series_Color_007
                          .value),
                if (controller.checkVal8.value)
                  lineChartBarData(
                      controller.eightData,
                      Get.find<iniControllerWithReactive>()
                          .Series_Color_008
                          .value),
              ],
              bottomTitles: SideTitles(
                showTitles: true,
                reservedSize: 20, //글씨 밑에 margin 주기
                getTextStyles: (BuildContext, double) => const TextStyle(
                  color: Color(0xff68737d),
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
                getTitles: (value) {
                  return '${value.round()}';
                },
                margin: 8, //스캐일에 쓴 글씨와 그래프의 margin
              ),
              leftTitles: SideTitles(
                showTitles: true,
                getTextStyles: (BuildContext, double) => const TextStyle(
                  color: Color(0xff67727d),
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
                getTitles: (value) {
                  switch (value.toInt()) {
                    case 0:
                      return '10k';
                    case 250:
                      return '30k';
                    case 500:
                      return '50k';
                  }
                  return '';
                },
                reservedSize: 10,
                margin: 12,
              ),
            ),
          ),
        ),
      ),
    );
  }

  LineChart LineChartForm(
      {required OesController controller,
      required List<LineChartBarData> lineBarsData,
      SideTitles? leftTitles,
      SideTitles? bottomTitles}) {
    return LineChart(
      LineChartData(
          minX: 190,
          maxX: 760,
          minY: 0,
          maxY: 3000, //데이터를 몇개 넣을 것인지~~
          lineTouchData: LineTouchData(
              touchTooltipData: LineTouchTooltipData(
            fitInsideHorizontally: true,
            fitInsideVertically: true,
          )),
          clipData: FlClipData.all(),
          titlesData: FlTitlesData(
              show: true,
              bottomTitles: bottomTitles,
              leftTitles: leftTitles,
              topTitles: SideTitles(showTitles: false),
              rightTitles: SideTitles(showTitles: false)),
          borderData: FlBorderData(
            show: true,
            border: Border.all(
                color: const Color(0xff37434d), width: 1), //border만들어서 값 넣기
          ),
          lineBarsData: lineBarsData),
      swapAnimationDuration: Duration.zero,
    );
  }

  LineChartBarData lineChartBarData(List<FlSpot> points, color) {
    return LineChartBarData(
        spots: points,
        dotData: FlDotData(
          show: false,
        ),
        colors: [color],
        barWidth: 1);
  }
}
/////////////밑에 랜덤데이터 있음

// import 'dart:async';
// import 'dart:math' as math;
// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:wr_ui/main.dart';
// import 'package:wr_ui/view/right_side_menu/csv_creator.dart';
// import 'package:wr_ui/view/right_side_menu/ini_creator.dart';

// class OesController extends GetxController {
//   RxList<FlSpot> oneData = RxList.empty();
//   RxList<FlSpot> twoData = RxList.empty();
//   RxList<FlSpot> threeData = RxList.empty();
//   RxList<FlSpot> fourData = RxList.empty();
//   RxList<FlSpot> fiveData = RxList.empty();
//   RxList<FlSpot> sixData = RxList.empty();
//   RxList<FlSpot> sevenData = RxList.empty();
//   RxList<FlSpot> eightData = RxList.empty();
//   RxBool inactiveBtn = false.obs;

//   RxBool checkVal1 = true.obs;
//   RxBool checkVal2 = true.obs;
//   RxBool checkVal3 = true.obs;
//   RxBool checkVal4 = true.obs;
//   RxBool checkVal5 = true.obs;
//   RxBool checkVal6 = true.obs;
//   RxBool checkVal7 = true.obs;
//   RxBool checkVal8 = true.obs;

//   late Timer timer;
//   RxBool bRunning = false.obs;
//   @override
//   void onInit() {
//     super.onInit();
//   }

//   double setRandom() {
//     double yValue = math.Random().nextInt(50).toDouble();
//     //여기
//     return yValue;
//   }

//   void updateDataSource(Timer timer) async {
//     if (oneData.isNotEmpty) {
//       oneData.clear();
//       twoData.clear();
//       threeData.clear();
//       fourData.clear();
//       fiveData.clear();
//       sixData.clear();
//       sevenData.clear();
//       eightData.clear();
//     }
//     for (double i = 190; i < 760; i++) {
//       oneData.add(FlSpot(i, setRandom()));
//       twoData.add(FlSpot(i, setRandom()));
//       threeData.add(FlSpot(i, setRandom()));
//       fourData.add(FlSpot(i, setRandom()));
//       fiveData.add(FlSpot(i, setRandom()));
//       sixData.add(FlSpot(i, setRandom()));
//       sevenData.add(FlSpot(i, setRandom()));
//       eightData.add(FlSpot(i, setRandom()));
//     }
//     if (Get.find<CsvController>().fileSave.value)
//       await Get.find<CsvController>().csvSave();
//     if (Get.find<CsvController>().fileSave2.value)
//       await Get.find<CsvController>().SecondcsvSave();
//     if (Get.find<CsvController>().fileSave3.value)
//       await Get.find<CsvController>().ThirdcsvSave();
//     if (Get.find<CsvController>().fileSave4.value)
//       await Get.find<CsvController>().FourthcsvSave();
//     if (Get.find<CsvController>().fileSave5.value)
//       await Get.find<CsvController>().FifthcsvSave();
//     if (Get.find<CsvController>().fileSave6.value)
//       await Get.find<CsvController>().SixthcsvSave();
//     if (Get.find<CsvController>().fileSave7.value)
//       await Get.find<CsvController>().SeventhcsvSave();
//     if (Get.find<CsvController>().fileSave8.value)
//       await Get.find<CsvController>().EightcsvSave();
//     update();
//   }
// }

// class OesChart extends GetView<OesController> {
//   OesChart({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     //final controller = Get.put(OesController());
//     return Container(
//       padding: EdgeInsets.only(top: 20),
//       child: GetBuilder<OesController>(
//         builder: (controller) => InteractiveViewer(
//           child: Container(
//             padding: EdgeInsets.only(left: 20, right: 20, top: 10),
//             child: LineChartForm(
//               controller: controller,
//               lineBarsData: [
//                 if (controller.checkVal1.value)
//                   lineChartBarData(
//                       controller.oneData,
//                       Get.find<iniControllerWithReactive>()
//                           .Series_Color_001
//                           .value),
//                 if (controller.checkVal2.value)
//                   lineChartBarData(
//                       controller.twoData,
//                       Get.find<iniControllerWithReactive>()
//                           .Series_Color_002
//                           .value),
//                 if (controller.checkVal3.value)
//                   lineChartBarData(
//                       controller.threeData,
//                       Get.find<iniControllerWithReactive>()
//                           .Series_Color_003
//                           .value),
//                 if (controller.checkVal4.value)
//                   lineChartBarData(
//                       controller.fourData,
//                       Get.find<iniControllerWithReactive>()
//                           .Series_Color_004
//                           .value),
//                 if (controller.checkVal5.value)
//                   lineChartBarData(
//                       controller.fiveData,
//                       Get.find<iniControllerWithReactive>()
//                           .Series_Color_005
//                           .value),
//                 if (controller.checkVal6.value)
//                   lineChartBarData(
//                       controller.sixData,
//                       Get.find<iniControllerWithReactive>()
//                           .Series_Color_006
//                           .value),
//                 if (controller.checkVal7.value)
//                   lineChartBarData(
//                       controller.sevenData,
//                       Get.find<iniControllerWithReactive>()
//                           .Series_Color_007
//                           .value),
//                 if (controller.checkVal8.value)
//                   lineChartBarData(
//                       controller.eightData,
//                       Get.find<iniControllerWithReactive>()
//                           .Series_Color_008
//                           .value),
//               ],
//               bottomTitles: SideTitles(
//                 showTitles: true,
//                 reservedSize: 20, //글씨 밑에 margin 주기
//                 getTextStyles: (BuildContext, double) => const TextStyle(
//                   color: Color(0xff68737d),
//                   fontWeight: FontWeight.bold,
//                   fontSize: 13,
//                 ),
//                 getTitles: (value) {
//                   return '${value.round()}';
//                 },
//                 margin: 8, //스캐일에 쓴 글씨와 그래프의 margin
//               ),
//               leftTitles: SideTitles(
//                 showTitles: true,
//                 getTextStyles: (BuildContext, double) => const TextStyle(
//                   color: Color(0xff67727d),
//                   fontWeight: FontWeight.bold,
//                   fontSize: 15,
//                 ),
//                 getTitles: (value) {
//                   switch (value.toInt()) {
//                     case 0:
//                       return '10k';
//                     case 250:
//                       return '30k';
//                     case 500:
//                       return '50k';
//                   }
//                   return '';
//                 },
//                 reservedSize: 10,
//                 margin: 12,
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   LineChart LineChartForm(
//       {required OesController controller,
//       required List<LineChartBarData> lineBarsData,
//       SideTitles? leftTitles,
//       SideTitles? bottomTitles}) {
//     return LineChart(
//       LineChartData(
//           minX: 190,
//           maxX: 760,
//           minY: 0,
//           maxY: 3000, //데이터를 몇개 넣을 것인지~~
//           lineTouchData: LineTouchData(
//               touchTooltipData: LineTouchTooltipData(
//             fitInsideHorizontally: true,
//             fitInsideVertically: true,
//           )),
//           clipData: FlClipData.all(),
//           titlesData: FlTitlesData(
//               show: true,
//               bottomTitles: bottomTitles,
//               leftTitles: leftTitles,
//               topTitles: SideTitles(showTitles: false),
//               rightTitles: SideTitles(showTitles: false)),
//           borderData: FlBorderData(
//             show: true,
//             border: Border.all(
//                 color: const Color(0xff37434d), width: 1), //border만들어서 값 넣기
//           ),
//           lineBarsData: lineBarsData),
//       swapAnimationDuration: Duration.zero,
//     );
//   }

//   LineChartBarData lineChartBarData(List<FlSpot> points, color) {
//     return LineChartBarData(
//         spots: points,
//         dotData: FlDotData(
//           show: false,
//         ),
//         colors: [color],
//         barWidth: 1);
//   }
// }
