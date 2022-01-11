import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:wr_ui/controller/setting.dart';
import 'package:wr_ui/controller/viz_ctrl.dart';
import 'package:wr_ui/main.dart';
import 'package:wr_ui/model/config/config.dart';
import 'dart:async';
import 'package:wr_ui/model/const/style/pallette.dart';
import 'package:wr_ui/model/const/style/text.dart';
import 'package:wr_ui/view/appbar/leading/run_error_status_mark.dart';
import 'package:wr_ui/view/chart/oes_chart.dart';
import 'package:wr_ui/view/right_side_menu/csv_creator.dart';
import 'package:wr_ui/view/right_side_menu/log_screen.dart';
import 'package:wr_ui/view/right_side_menu/save_ini.dart';

class SetBtn extends StatefulWidget {
  @override
  State<SetBtn> createState() => _SetBtnState();
}

class _SetBtnState extends State<SetBtn> {
  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: () {
        Get.find<LogListController>().settingBtn();
        Get.find<runErrorStatusController>().connect.value
            ? runningSet(context)
            : _showDialog(context);
      },
      icon: Icon(
        Icons.settings,
        color: wrColors.white,
      ),
      label: Text(
        'settings',
        style: WrText.WrFont,
      ),
    );
  }
}

Future<void> _showDialog(context) async {
  await showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      var top = 65.0;
      var right = 0.0;
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Stack(
            children: [
              Positioned(
                top: top,
                right: right,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: AlertDialog(
                    insetPadding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0)),
                    content: Container(
                      height: 850,
                      width: 550,
                      padding: EdgeInsets.all(5.0),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Form(
                                autovalidateMode: AutovalidateMode.always,
                                key: Get.find<iniController>().key,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Comport Setting',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    SizedBox(height: 20),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        ComSet(
                                            onSaved: (v) {
                                              Get.find<iniController>()
                                                      .oes_comport
                                                      .value =
                                                  int.parse(v.toString());
                                            },
                                            initVal: iniController
                                                .to.oes_comport
                                                .toString(),
                                            label: 'OES'),
                                        ComSet(
                                            onSaved: (v) {
                                              Get.find<iniController>()
                                                      .vizComport[0] =
                                                  int.parse(v.toString());
                                            },
                                            initVal: iniController
                                                .to.vizComport[0]
                                                .toString(),
                                            label: 'VIZ 1'),
                                        ComSet(
                                            onSaved: (v) {
                                              Get.find<iniController>()
                                                      .vizComport[1] =
                                                  int.parse(v.toString());
                                            },
                                            initVal: iniController
                                                .to.vizComport[1]
                                                .toString(),
                                            label: 'VIZ 2'),
                                        ComSet(
                                            onSaved: (v) {
                                              Get.find<iniController>()
                                                      .vizComport[2] =
                                                  int.parse(v.toString());
                                            },
                                            initVal: iniController
                                                .to.vizComport[2]
                                                .toString(),
                                            label: 'VIZ 3'),
                                        ComSet(
                                            onSaved: (v) {
                                              Get.find<iniController>()
                                                      .vizComport[3] =
                                                  int.parse(v.toString());
                                            },
                                            initVal: iniController
                                                .to.vizComport[3]
                                                .toString(),
                                            label: 'VIZ 4'),
                                        ComSet(
                                            onSaved: (v) {
                                              Get.find<iniController>()
                                                      .vizComport[4] =
                                                  int.parse(v.toString());
                                            },
                                            initVal: iniController
                                                .to.vizComport[4]
                                                .toString(),
                                            label: 'VIZ 5'),
                                      ],
                                    ),
                                    Divider(height: 30, thickness: 2),
                                    Text(
                                      'OES Setting',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: 100,
                                            child: TextFormField(
                                              initialValue:
                                                  (Get.find<iniController>()
                                                              .integrationTime
                                                              .value ~/
                                                          1000)
                                                      .toString(),
                                              decoration: InputDecoration(
                                                labelText: 'Integration Time',
                                                hintText: 'milliseconds',
                                              ),
                                              onSaved: (v) {
                                                Get.find<iniController>()
                                                        .integrationTime
                                                        .value =
                                                    int.parse(v.toString()) *
                                                        1000;
                                              },
                                              inputFormatters: [
                                                FilteringTextInputFormatter
                                                    .digitsOnly
                                              ],
                                            ),
                                          ),
                                          SizedBox(height: 20),
                                          Row(
                                            children: [
                                              Obx(
                                                () => SizedBox(
                                                    height: 55,
                                                    child: Row(children: [
                                                      Text("Auto Save"),
                                                      Checkbox(
                                                          value: iniController
                                                              .to
                                                              .checkAuto
                                                              .value,
                                                          onChanged: (e) {
                                                            iniController
                                                                .to
                                                                .checkAuto
                                                                .value = e!;
                                                          }),
                                                    ])),
                                              ),
                                              SizedBox(width: 20),
                                              Container(
                                                  width: 100,
                                                  child: Obx(
                                                    () => Visibility(
                                                      visible: iniController
                                                          .to.checkAuto.value,
                                                      child: TextFormField(
                                                        initialValue:
                                                            iniController.to
                                                                .oesAutoSaveVal
                                                                .toString(),
                                                        decoration:
                                                            InputDecoration(
                                                          labelText:
                                                              'Auto Save Value',
                                                          hintText: 'Value',
                                                        ),
                                                        onSaved: (v) {
                                                          Get.find<iniController>()
                                                                  .oesAutoSaveVal
                                                                  .value =
                                                              int.parse(
                                                                  v.toString());
                                                        },
                                                        inputFormatters: [
                                                          FilteringTextInputFormatter
                                                              .digitsOnly
                                                        ],
                                                      ),
                                                    ),
                                                  )),
                                            ],
                                          ),
                                        ]),
                                    Divider(height: 30, thickness: 2),
                                    Text('VIZ Setting',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    Row(children: [
                                      Container(
                                        width: 100,
                                        child: TextFormField(
                                          initialValue: iniController
                                              .to.viz_Interval.value
                                              .toString(),
                                          decoration: InputDecoration(
                                            labelText: 'Viz Interval',
                                            hintText: 'milliseconds',
                                          ),
                                          onSaved: (v) {
                                            Get.find<iniController>()
                                                    .viz_Interval
                                                    .value =
                                                int.parse(v.toString());
                                          },
                                          validator: (String? v) {
                                            if (v!.isNotEmpty) {
                                              if (double.parse(v.toString()) <=
                                                  50) {
                                                return "Over 50";
                                              }
                                            }

                                            return null;
                                          },
                                          inputFormatters: [
                                            FilteringTextInputFormatter
                                                .digitsOnly
                                          ],
                                        ),
                                      ),
                                      SizedBox(width: 50),
                                      Column(
                                        children: [
                                          ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  primary: Colors.grey[700]),
                                              onPressed: () {
                                                VizCtrl.to.startSerial();
                                              },
                                              child: Text("Comport Open")),
                                          SizedBox(height: 20),
                                          ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  primary: Colors.grey[700]),
                                              onPressed: () {
                                                VizCtrl.to.vizChannel[0].port
                                                    .close();
                                              },
                                              child: Text("Comport Close")),
                                        ],
                                      ),
                                    ]),
                                    Divider(height: 30, thickness: 2),
                                    Text('Color Setting',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    SizedBox(height: 20),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              child: Text('OES Series Color'),
                                              padding: EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                  color: Colors.grey[300],
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(10))),
                                            ),
                                            SizedBox(height: 20),
                                            ColorSet(
                                                text: 'OES 1',
                                                onColorChanage: (Color color) {
                                                  iniController.to.oesColor[0] =
                                                      color;
                                                }),
                                            ColorSet(
                                                text: 'OES 2',
                                                onColorChanage: (Color color) {
                                                  iniController.to.oesColor[1] =
                                                      color;
                                                }),
                                            ColorSet(
                                                text: 'OES 3',
                                                onColorChanage: (Color color) {
                                                  iniController.to.oesColor[2] =
                                                      color;
                                                }),
                                            ColorSet(
                                                text: 'OES 4',
                                                onColorChanage: (Color color) {
                                                  iniController.to.oesColor[3] =
                                                      color;
                                                }),
                                            ColorSet(
                                                text: 'OES 5',
                                                onColorChanage: (Color color) {
                                                  iniController.to.oesColor[4] =
                                                      color;
                                                }),
                                            ColorSet(
                                                text: 'OES 6',
                                                onColorChanage: (Color color) {
                                                  iniController.to.oesColor[5] =
                                                      color;
                                                }),
                                            ColorSet(
                                                text: 'OES 7',
                                                onColorChanage: (Color color) {
                                                  iniController.to.oesColor[6] =
                                                      color;
                                                }),
                                            ColorSet(
                                                text: 'OES 8',
                                                onColorChanage: (Color color) {
                                                  iniController.to.oesColor[7] =
                                                      color;
                                                }),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              child: Text('VIZ Series Color'),
                                              padding: EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                  color: Colors.grey[300],
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(10))),
                                            ),
                                            SizedBox(height: 20),
                                            ColorSet(
                                                text: 'Frequency',
                                                onColorChanage: (Color color) {
                                                  Get.find<iniController>()
                                                      .vizColor[0] = color;
                                                }),
                                            ColorSet(
                                                text: 'P dlv',
                                                onColorChanage: (Color color) {
                                                  Get.find<iniController>()
                                                      .vizColor[1] = color;
                                                }),
                                            ColorSet(
                                                text: 'Phase',
                                                onColorChanage: (Color color) {
                                                  Get.find<iniController>()
                                                      .vizColor[2] = color;
                                                }),
                                            ColorSet(
                                                text: 'V',
                                                onColorChanage: (Color color) {
                                                  Get.find<iniController>()
                                                      .vizColor[3] = color;
                                                }),
                                            ColorSet(
                                                text: 'I',
                                                onColorChanage: (Color color) {
                                                  Get.find<iniController>()
                                                      .vizColor[4] = color;
                                                }),
                                            ColorSet(
                                                text: 'R',
                                                onColorChanage: (Color color) {
                                                  Get.find<iniController>()
                                                      .vizColor[5] = color;
                                                }),
                                            ColorSet(
                                                text: 'X',
                                                onColorChanage: (Color color) {
                                                  Get.find<iniController>()
                                                      .vizColor[6] = color;
                                                }),
                                          ],
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    actions: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: wrColors.wrPrimary,
                            padding: EdgeInsets.all(15)),
                        child: Center(
                          child: Text(
                            'save',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        onPressed: () async {
                          OesController.to.oesChartData.clear();
                          for (var i = 0;
                              i < Get.find<iniController>().OES_Count.value;
                              i++) {
                            Get.find<OesController>().oesChartData.add([]);
                          }
                          VizCtrl.to.vizPoints.clear();
                          for (var i = 0; i < 5; i++) {
                            VizCtrl.to.vizPoints.add(RxList.empty());
                            for (var ii = 0; ii < 7; ii++) {
                              VizCtrl.to.vizPoints[i].add(RxList.empty());
                            }
                          }
                          VizCtrl.to.xValue.value = 0;
                          Get.find<iniController>().key.currentState!.save();
                          for (var i = 0; i < 5; i++) {
                            VizCtrl.to.vizChannel[i].port.close();
                          }

                          VizCtrl.to.init();
                          VizCtrl.to.startSerial();
                          Get.find<LogListController>().cConfigSave();
                          ConfigWR writeConfig = ConfigWR.init();
                          File file = File("./setting.json");
                          debugPrint('writeConfig ${writeConfig.toJson()}');
                          await file.writeAsString(writeConfig.toJson(),
                              mode: FileMode.write);

                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ),
              )
            ],
          );
        },
      );
    },
  );
}

Future<String?> runningSet(BuildContext context) {
  return showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: const Text('측정 중 입니다.'),
      content: const Text('측정을 중지 하시겠습니까?'),
      actions: <Widget>[
        TextButton(
          child: const Text('취소'),
          onPressed: () => Navigator.pop(context, '취소'),
        ),
        TextButton(
          child: const Text('예'),
          onPressed: () {
            Get.find<OesController>().inactiveBtn.value = false;
            VizCtrl.to.timer.cancel();
            Get.find<OesController>().timer?.cancel();
            Get.find<LogListController>().clickedStop();
            Get.find<CsvController>().csvSaveInit.value = false;
            Get.find<CsvController>().csvSaveData.value = false;
            Get.find<runErrorStatusController>().connect.value = false;
            Get.find<runErrorStatusController>().textmsg.value = 'STOP';
            Get.offAll(Home(), transition: Transition.noTransition);
          },
        ),
      ],
    ),
  );
}
