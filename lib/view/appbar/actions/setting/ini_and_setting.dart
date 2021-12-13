import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:get/get.dart';
import 'package:ini/ini.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wr_ui/controller/setting_controller.dart';
import 'package:wr_ui/main.dart';
import 'dart:async';
import 'dart:io';
import 'package:wr_ui/model/const/style/pallette.dart';
import 'package:wr_ui/model/const/style/text.dart';
import 'package:wr_ui/view/appbar/actions/setting/setting_menu_final.dart';
import 'package:wr_ui/view/appbar/leading/run_error_status_mark.dart';
import 'package:wr_ui/view/chart/oes_chart.dart';
import 'package:wr_ui/view/right_side_menu/csv_creator.dart';
import 'package:wr_ui/view/right_side_menu/ini_creator.dart';
import 'package:wr_ui/view/right_side_menu/log_screen.dart';
import 'package:wr_ui/view/right_side_menu/save_ini.dart';

class SetBtn extends StatefulWidget {
  @override
  State<SetBtn> createState() => _SetBtnState();
}

class _SetBtnState extends State<SetBtn> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextButton.icon(
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
        label: Text('settings', style: WrText.WrLeadingFont),
      ),
    );
  }
}

Future<void> _showDialog(context) async {
  await showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      var top = 100.0;
      var left = 800.0;
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return GestureDetector(
            onVerticalDragUpdate: (DragUpdateDetails dd) {
              // print(dd);
              setState(() {
                top = dd.localPosition.dy - 50;
                left = dd.localPosition.dx - 60;
              });
            },
            child: Stack(
              children: [
                Positioned(
                  top: top,
                  left: left,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: AlertDialog(
                      insetPadding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0)),
                      title: Text("setting"),
                      content: Container(
                        height: 800,
                        width: 500,
                        padding: EdgeInsets.all(10.0),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Form(
                                  key: Get.find<iniController>().key,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      TextFormField(
                                        initialValue: '100',
                                        decoration: InputDecoration(
                                          labelText: 'Exposure Time',
                                          hintText: 'milliseconds',
                                        ),
                                        onSaved: (v) {
                                          Get.find<iniController>()
                                              .exposureTime
                                              .value = v.toString();
                                          print(
                                              'Exposure time has been changed to $v');
                                        },
                                      ),
                                      /////delay time 필요 없어져서 지움
                                      // SizedBox(
                                      //   height: 30,
                                      // ),
                                      // TextFormField(
                                      //   initialValue: '100',
                                      //   decoration: InputDecoration(
                                      //     labelText: 'Delay Time',
                                      //     hintText: 'milliseconds',
                                      //   ),
                                      //   onSaved: (v) {
                                      //     Get.find<SettingController>()
                                      //         .delayTime
                                      //         .value = v.toString();
                                      //     print(
                                      //         'Delay time has been changed to $v');
                                      //   },
                                      // ),

                                      SizedBox(
                                        height: 30,
                                      ),
                                      // TextFormField(
                                      //   initialValue: '100',
                                      //   decoration: InputDecoration(
                                      //     labelText: 'Integration Time',
                                      //     hintText: 'milliseconds',
                                      //   ),
                                      //   onSaved: (v) {
                                      //     Get.find<iniControllerWithReactive>()
                                      //         .IntegrationTime
                                      //         .value = v.toString();
                                      //     Get.find<SettingController>()
                                      //         .integrationTime
                                      //         .value = Get.find<
                                      //             iniControllerWithReactive>()
                                      //         .IntegrationTime
                                      //         .value;
                                      //     var integrationTimetoInt = int.parse(
                                      //         Get.find<SettingController>()
                                      //             .integrationTime
                                      //             .value);
                                      //     assert(integrationTimetoInt is int);
                                      //     setIntegrationTime(
                                      //         0, integrationTimetoInt - 1);
                                      //     //////////////

                                      //     print(
                                      //         'Integration time has been changed to $v');
                                      //   },
                                      // ),
                                      // SizedBox(
                                      //   height: 30,
                                      // ),
                                      // TextFormField(
                                      //   initialValue:
                                      //       Get.find<SettingController>()
                                      //           .mosChannel
                                      //           .value
                                      //           .toString(),
                                      //   decoration: InputDecoration(
                                      //     labelText: 'MOS Channel',
                                      //     hintText: '0~7',
                                      //   ),
                                      //   onSaved: (v) {
                                      //     Get.find<iniControllerWithReactive>()
                                      //         .MOSChannel
                                      //         .value = v.toString();
                                      //     Get.find<SettingController>()
                                      //         .mosChannel
                                      //         .value = Get.find<
                                      //             iniControllerWithReactive>()
                                      //         .MOSChannel
                                      //         .value;
                                      //     var mosChanneltoInt = int.parse(
                                      //         Get.find<SettingController>()
                                      //             .mosChannel
                                      //             .value);
                                      //     assert(mosChanneltoInt is int);
                                      //     mpmSetChannel(mosChanneltoInt);
                                      //     print(
                                      //         'mosChannel has been changed to $v');
                                      //   },
                                      // ),
                                      SizedBox(
                                        height: 50,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            Text(
                                              'series color 1',
                                              style: TextStyle(fontSize: 10),
                                            ),
                                            Divider(
                                              indent: 400,
                                              endIndent: 400,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height: 65,
                                        child: Center(
                                          child: MaterialColorPicker(
                                            circleSize: 100,
                                            onColorChange: (Color color) {
                                              print('series color 1 hexcode=>' +
                                                  '${color}');
                                              Get.find<iniController>()
                                                  .Series_Color_001
                                                  .value = color;
                                              // setState(() {
                                              //   pickedColor1 = color;
                                              // });

                                              // Get.find<DialogStorageCtrl>()
                                              //     .Series_Color_001
                                              //     .value = color.toString();
                                            },
                                            selectedColor: Colors.red,
                                            colors: [
                                              Colors.red,
                                              Colors.deepOrange,
                                              Colors.yellow,
                                              Colors.lightGreen
                                            ],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            Text(
                                              'series color 2',
                                              style: TextStyle(fontSize: 10),
                                            ),
                                            Divider(
                                              indent: 400,
                                              endIndent: 400,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height: 65,
                                        child: Center(
                                          child: MaterialColorPicker(
                                            circleSize: 100,
                                            // circleSize: 100,
                                            onColorChange: (Color color) {
                                              // Handle color changes
                                              print('series color 2 hexcode=>' +
                                                  '$color');
                                              Get.find<iniController>()
                                                  .Series_Color_002
                                                  .value = color;
                                            },
                                            selectedColor: Colors.red,
                                            colors: [
                                              Colors.red,
                                              Colors.deepOrange,
                                              Colors.yellow,
                                              Colors.lightGreen
                                            ],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            Text(
                                              'series color 3',
                                              style: TextStyle(fontSize: 10),
                                            ),
                                            Divider(
                                              indent: 400,
                                              endIndent: 400,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height: 65,
                                        child: Center(
                                          child: MaterialColorPicker(
                                            circleSize: 100,
                                            onColorChange: (Color color) {
                                              // Handle color changes
                                              print('series color 3 hexcode=>' +
                                                  '$color');
                                              Get.find<iniController>()
                                                  .Series_Color_003
                                                  .value = color;
                                            },
                                            selectedColor: Colors.red,
                                            colors: [
                                              Colors.red,
                                              Colors.deepOrange,
                                              Colors.yellow,
                                              Colors.lightGreen
                                            ],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            Text(
                                              'series color 4',
                                              style: TextStyle(fontSize: 10),
                                            ),
                                            Divider(
                                              indent: 400,
                                              endIndent: 400,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height: 65,
                                        child: Center(
                                          child: MaterialColorPicker(
                                            circleSize: 100,
                                            onColorChange: (Color color) {
                                              // Handle color changes
                                              print('series color 4 hexcode=>' +
                                                  '$color');
                                              Get.find<iniController>()
                                                  .Series_Color_004
                                                  .value = color;
                                            },
                                            selectedColor: Colors.red,
                                            colors: [
                                              Colors.red,
                                              Colors.deepOrange,
                                              Colors.yellow,
                                              Colors.lightGreen
                                            ],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            Text(
                                              'series color 5',
                                              style: TextStyle(fontSize: 10),
                                            ),
                                            Divider(
                                              indent: 400,
                                              endIndent: 400,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height: 65,
                                        child: Center(
                                          child: MaterialColorPicker(
                                            circleSize: 100,
                                            onColorChange: (Color color) {
                                              // Handle color changes
                                              print('series color 5 hexcode=>' +
                                                  '$color');
                                              Get.find<iniController>()
                                                  .Series_Color_005
                                                  .value = color;
                                            },
                                            selectedColor: Colors.red,
                                            colors: [
                                              Colors.red,
                                              Colors.deepOrange,
                                              Colors.yellow,
                                              Colors.lightGreen
                                            ],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            Text(
                                              'series color 6',
                                              style: TextStyle(fontSize: 10),
                                            ),
                                            Divider(
                                              indent: 400,
                                              endIndent: 400,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height: 65,
                                        child: Center(
                                          child: MaterialColorPicker(
                                            circleSize: 100,
                                            onColorChange: (Color color) {
                                              // Handle color changes
                                              print('series color 6 hexcode=>' +
                                                  '$color');
                                              Get.find<iniController>()
                                                  .Series_Color_006
                                                  .value = color;
                                            },
                                            selectedColor: Colors.red,
                                            colors: [
                                              Colors.red,
                                              Colors.deepOrange,
                                              Colors.yellow,
                                              Colors.lightGreen
                                            ],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            Text(
                                              'series color 7',
                                              style: TextStyle(fontSize: 10),
                                            ),
                                            Divider(
                                              indent: 400,
                                              endIndent: 400,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height: 65,
                                        child: Center(
                                          child: MaterialColorPicker(
                                            circleSize: 100,
                                            onColorChange: (Color color) {
                                              // Handle color changes
                                              print('series color 7 hexcode=>' +
                                                  '$color');
                                              Get.find<iniController>()
                                                  .Series_Color_007
                                                  .value = color;
                                            },
                                            selectedColor: Colors.red,
                                            colors: [
                                              Colors.red,
                                              Colors.deepOrange,
                                              Colors.yellow,
                                              Colors.lightGreen
                                            ],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            Text(
                                              'series color 8',
                                              style: TextStyle(fontSize: 10),
                                            ),
                                            Divider(
                                              indent: 400,
                                              endIndent: 400,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height: 65,
                                        child: Center(
                                          child: MaterialColorPicker(
                                            circleSize: 100,
                                            onColorChange: (Color color) {
                                              // Handle color changes
                                              print('series color 8 hexcode=>' +
                                                  '$color');
                                              Get.find<iniController>()
                                                  .Series_Color_008
                                                  .value = color;
                                            },
                                            selectedColor: Colors.red,
                                            colors: [
                                              Colors.red,
                                              Colors.deepOrange,
                                              Colors.yellow,
                                              Colors.lightGreen
                                            ],
                                          ),
                                        ),
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
                          ),
                          child: Text('save'),
                          onPressed: () {
                            Get.find<iniController>().key.currentState!.save();
                            Get.find<LogListController>().cConfigSave();
                          },
                        ),
                        ElevatedButton(
                          child: Text("close"),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            primary: wrColors.wrPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
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
            Get.find<CsvController>().inactiveBtn.value = false;
            if (Get.find<iniController>().sim.value == 1) {
              Get.find<OesController>().timer?.cancel();
            } else if (Get.find<iniController>().sim.value == 0) {
              Get.find<OesController>().simTimer?.cancel();
            }
            Get.find<LogListController>().clickedStop();
            Get.find<CsvController>().fileSave.value = false;
            Get.find<runErrorStatusController>().connect.value = false;
            Get.find<runErrorStatusController>().textmsg.value = 'STOP';
            Get.offAll(Home(), transition: Transition.noTransition);
          },
        ),
      ],
    ),
  );
}
