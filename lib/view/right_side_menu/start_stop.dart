import 'dart:async';
import 'dart:ffi';
import 'dart:isolate';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:libserialport/libserialport.dart';

import 'package:wr_ui/controller/button.dart';
import 'package:wr_ui/controller/oes_ctrl.dart';
import 'package:wr_ui/controller/viz_ctrl.dart';
import 'package:wr_ui/main.dart';
import 'package:wr_ui/model/viz/viz_data.dart';
import 'package:wr_ui/view/appbar/leading/run_error_status_mark.dart';
import 'package:wr_ui/view/right_side_menu/log_save.dart';
import 'package:wr_ui/view/right_side_menu/save_ini.dart';
import 'dart:math' as math;
import 'csv_creator.dart';
import 'log_screen.dart';

int nChannelIdx = 0;
// int nChannelIdx = -1;//range error 나서 초기값 바꿈

class VizSerialData {
  int comPort;
  bool simulation;
  List<double> data;
  VizSerialData({
    required this.comPort,
    required this.simulation,
    required this.data,
  });
  factory VizSerialData.init() {
    return VizSerialData(
        comPort: 0, simulation: true, data: List.filled(7, 0.0));
  }
}

class IsolateSendData {
  SendPort sendPort;

  List<VizSerialData> vizSerialData;
  IsolateSendData({
    required this.sendPort,
    required this.vizSerialData,
  });
}

class IsolateReceiveData {
  SendPort sendPort;
  int idx;
  VizSerialData v;
  IsolateReceiveData({
    required this.sendPort,
    required this.idx,
    required this.v,
  });
}

List<double> showData = [];
checkValidity(Uint8List data) {
  if (data.isEmpty) {
    return;
  }
  List<int> listPrac = [];
  int startDataIdx = 37;
  int receiveLength = 79;
  List<int> b = [];
  List<int> bb = [];
  showData = [];

  if (listPrac.isNotEmpty) {
    b.addAll(listPrac);
    b.addAll(data.toList());
  } else {
    b = data.toList();
  }
  //debugPrint('receiveData : $b');
  if (b[0] != 0x16) {
    listPrac = [];
    //debugPrint('시작 틀림');
    return;
  }

  if (b.length < receiveLength) {
    if (b.length >= 4) {
      if (b[0] == 0x16 && b[1] == 0x16 && b[2] == 0x30 && b[3] == 0x03) {
        listPrac.addAll(data.toList());
        return;
      } else {
        listPrac = [];
        return;
      }
    } else {
      listPrac.addAll(data.toList());
      return;
    }
  } else if (b.length > receiveLength) {
    bb = b.sublist(receiveLength, b.length);
    b = b.sublist(0, receiveLength);
    //print('$receiveLength자보다 커서 잘랐어 $bb ${b.length}');
  } else {}

  if (!(b[0] == 0x16 && b[1] == 0x16 && b[2] == 0x30 && b[3] == 0x03)) {
    //print('헤더가 이상있어요');
    listPrac = [];
    return;
  }
  if (b[receiveLength - 1] != 0x1a) {
    //print('마지막이 이상있어요');
    listPrac = [];
    return;
  }
  final int cs = calcCheckSum(b.sublist(2, b.length - 2));
  //print('cs $cs');
  if (cs != b[receiveLength - 2]) {
    //print('체크섬이 이상있어요');
    listPrac = [];
    return;
  }

  //print('$receiveLength자와 같아 $b');
  showData.add(Uint8List.fromList(b)
      .sublist(startDataIdx, startDataIdx += 4)
      .buffer
      .asByteData()
      .getFloat32(0, Endian.little));
  showData.add(Uint8List.fromList(b)
      .sublist(startDataIdx, startDataIdx += 4)
      .buffer
      .asByteData()
      .getFloat32(0, Endian.little));
  showData.add(Uint8List.fromList(b)
      .sublist(startDataIdx, startDataIdx += 4)
      .buffer
      .asByteData()
      .getFloat32(0, Endian.little));
  showData.add(Uint8List.fromList(b)
      .sublist(startDataIdx, startDataIdx += 4)
      .buffer
      .asByteData()
      .getFloat32(0, Endian.little));
  showData.add(Uint8List.fromList(b)
      .sublist(startDataIdx, startDataIdx += 4)
      .buffer
      .asByteData()
      .getFloat32(0, Endian.little));
  showData.add(Uint8List.fromList(b)
      .sublist(startDataIdx, startDataIdx += 4)
      .buffer
      .asByteData()
      .getFloat32(0, Endian.little));
  showData.add(Uint8List.fromList(b)
      .sublist(startDataIdx, startDataIdx += 4)
      .buffer
      .asByteData()
      .getFloat32(0, Endian.little));

  listPrac = bb;
}

// ignore: must_be_immutable
class StartStop extends StatelessWidget {
  StartStop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(height: 30),
        Obx(() => IgnorePointer(
            ignoring: Get.find<OesController>().inactiveBtn.value,
            child: RightButton(
                text: 'Start',
                icon: Icons.play_arrow,
                primary: Get.find<OesController>().inactiveBtn.value
                    ? Colors.grey
                    : Colors.green,
                onPressed: () async {
                  await VizCtrl.to.chartInit();

                  VizCtrl.to.isolateStart(VizCtrl.to, iniController.to);

                  DataStartBtn();
                }))),
        SizedBox(height: 30),
        Obx(
          () => IgnorePointer(
              ignoring: !Get.find<OesController>().inactiveBtn.value,
              child: RightButton(
                  text: 'Stop',
                  primary: Get.find<OesController>().inactiveBtn.value
                      ? Colors.red
                      : Colors.grey,
                  icon: Icons.pause,
                  onPressed: () {
                    Get.find<OesController>().timer?.cancel();
                    //VizCtrl.to.timer.cancel();
                    VizCtrl.to.isolateStop();
                    Get.find<runErrorStatusController>().statusColor.value =
                        Colors.red;
                    Get.find<OesController>().inactiveBtn.value = false;
                    Get.find<CsvController>().csvSaveInit.value = false;
                    Get.find<CsvController>().csvSaveData.value = false;
                    Get.find<OesController>().startBtn.value = false;
                    if (iniController.to.oes_comport.value != 0 &&
                        iniController.to.oes_comport.value != -1) {
                      mpmSetChannel(0);
                    }
                    Get.find<LogListController>().clickedStop();
                    Get.find<runErrorStatusController>().connect.value = false;
                    Get.find<runErrorStatusController>().textmsg.value =
                        'S T O P';
                  })),
        ),
        // Obx(() => RightButton(
        //     text: 'isolate Start',
        //     icon: Icons.play_arrow,
        //     primary: Get.find<OesController>().inactiveBtn.value
        //         ? Colors.grey
        //         : Colors.green,
        //     onPressed: () async {
        //       isolateStart(VizCtrl.to, iniController.to);
        //     })),
        // SizedBox(height: 30),
        // Obx(
        //   () => RightButton(
        //       text: 'isolate Stop',
        //       primary: Get.find<OesController>().inactiveBtn.value
        //           ? Colors.red
        //           : Colors.grey,
        //       icon: Icons.pause,
        //       onPressed: () {
        //         isolateStop();
        //       }),
        // ),
      ],
    );
  }
}

DataStartBtn() async {
  if (iniController.to.oes_comport.value != 0 &&
      iniController.to.oes_comport.value != -1) {
    if (ocrs != 0) await oesClose();
    await oesInit();
  }

  Get.find<runErrorStatusController>().connect.value = true;
  Get.find<LogListController>().clickedStart();
  Get.find<OesController>().inactiveBtn.value = true;
  try {
    int time1 = Get.find<iniController>().channelMovingTime.value.toInt();
    double doubletime2 = Get.find<iniController>().integrationTime.value / 1000;
    int inttime2 = doubletime2.toInt();
    int time3 = Get.find<iniController>().plusTime.value;
    time3 = 150;
    Get.find<iniController>().waitSwitchingTime.value = 400;
    int allTime =
        inttime2 + Get.find<iniController>().waitSwitchingTime.value + time3;
    if (doubletime2 <= Get.find<iniController>().waitSwitchingTime.value) {
      allTime =
          inttime2 + Get.find<iniController>().waitSwitchingTime.value + time3;
    } else
      allTime = (inttime2 * 2) + time3;
    print('time1?? $time1');
    print('time2?? $inttime2');
    print('time3?? $time3');
    print('allTime??? $allTime');
    Get.find<OesController>().startBtn.value = true;
    if (iniController.to.oes_comport.value != 0 &&
        iniController.to.oes_comport.value != -1) {
      setIntegrationTime(0, Get.find<iniController>().integrationTime.value);
      Get.find<runErrorStatusController>().statusColor.value =
          Color(0xFF2CA732);
      Get.find<runErrorStatusController>().textmsg.value = 'R U N';
    } else if (iniController.to.oes_comport.value != -1) {
      Get.find<runErrorStatusController>().textmsg.value =
          'S I M U L A T I O N';
      Get.find<runErrorStatusController>().statusColor.value =
          Color(0xFFE9DF50);
    }

    nChannelIdx = 0;

    Get.find<OesController>().timer = Timer.periodic(
      Duration(milliseconds: allTime),
      Get.find<OesController>().updateDataSource,
    );
    // VizCtrl.to.timer = Timer.periodic(
    //   Duration(milliseconds: iniController.to.viz_Interval.value),
    //   VizCtrl.to.readSerial,
    // );
    Get.find<LogController>()
        .loglist
        .add('${logfileTime()} channle moving t $time1');
    Get.find<LogController>().loglist.add('${logfileTime()} all t $allTime');
  } on FormatException {
    print('format error');
  }
}
