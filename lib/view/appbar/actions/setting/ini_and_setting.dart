import 'package:flutter/material.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:get/get.dart';
import 'package:wr_ui/main.dart';
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
                    title: Text("setting"),
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
                                key: Get.find<iniController>().key,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Container(
                                          height: 40,
                                          width: 80,
                                          child: TextFormField(
                                            initialValue: 'COM3',
                                            decoration: InputDecoration(
                                              fillColor: Colors.red,
                                              border: OutlineInputBorder(),
                                              labelText: 'OES',
                                              hintText: 'COM',
                                            ),
                                            onSaved: (v) {
                                              Get.find<iniController>()
                                                      .oes_comport =
                                                  v.toString() as RxInt;
                                            },
                                          ),
                                        ),
                                        Container(
                                          height: 40,
                                          width: 80,
                                          child: TextFormField(
                                            initialValue: 'COM4',
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(),
                                              labelText: 'VIZ1',
                                              hintText: 'COM',
                                            ),
                                            onSaved: (v) {
                                              Get.find<iniController>()
                                                      .viz_comport[0] =
                                                  v.toString();
                                            },
                                          ),
                                        ),
                                        Container(
                                          height: 40,
                                          width: 80,
                                          child: TextFormField(
                                            initialValue: 'COM1',
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(),
                                              labelText: 'VIZ2',
                                              hintText: 'COM',
                                            ),
                                            onSaved: (v) {
                                              Get.find<iniController>()
                                                      .viz_comport[1] =
                                                  v.toString();
                                            },
                                          ),
                                        ),
                                        Container(
                                            height: 40,
                                            width: 80,
                                            child: TextFormField(
                                              initialValue: 'COM2',
                                              decoration: InputDecoration(
                                                border: OutlineInputBorder(),
                                                labelText: 'VIZ3',
                                                hintText: 'COM',
                                              ),
                                              onSaved: (v) {
                                                Get.find<iniController>()
                                                        .viz_comport[2] =
                                                    v.toString();
                                              },
                                            )),
                                        Container(
                                            height: 40,
                                            width: 80,
                                            child: TextFormField(
                                              initialValue: 'COM6',
                                              decoration: InputDecoration(
                                                border: OutlineInputBorder(),
                                                labelText: 'VIZ4',
                                                hintText: 'COM',
                                              ),
                                              onSaved: (v) {
                                                Get.find<iniController>()
                                                        .viz_comport[3] =
                                                    v.toString();
                                              },
                                            )),
                                        Container(
                                            height: 40,
                                            width: 80,
                                            child: TextFormField(
                                              initialValue: 'COM5',
                                              decoration: InputDecoration(
                                                border: OutlineInputBorder(),
                                                labelText: 'VIZ5',
                                                hintText: 'COM',
                                              ),
                                              onSaved: (v) {
                                                Get.find<iniController>()
                                                        .viz_comport[4] =
                                                    v.toString();
                                              },
                                            )),
                                      ],
                                    ),
                                    TextFormField(
                                      initialValue: '2300',
                                      decoration: InputDecoration(
                                        labelText: 'Auto Save',
                                        hintText: 'Value',
                                      ),
                                      onSaved: (v) {
                                        Get.find<iniController>()
                                            .oesMaxValue
                                            .value = double.parse(v.toString());
                                      },
                                    ),
                                    TextFormField(
                                      initialValue: '100',
                                      decoration: InputDecoration(
                                        labelText: 'Viz Interval',
                                        hintText: 'milliseconds',
                                      ),
                                      onSaved: (v) {
                                        Get.find<iniController>()
                                            .viz_Interval
                                            .value = v.toString();
                                      },
                                    ),
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
                                      },
                                    ),
                                    TextFormField(
                                      initialValue: (Get.find<iniController>()
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
                                            int.parse(v.toString()) * 1000;
                                      },
                                    ),

                                    TextFormField(
                                      initialValue: Get.find<iniController>()
                                          .waitSwitchingTime
                                          .value
                                          .toString(),
                                      decoration: InputDecoration(
                                        labelText: 'Wait Switching Time',
                                        hintText: 'milliseconds',
                                      ),
                                      onSaved: (v) {
                                        Get.find<iniController>()
                                            .waitSwitchingTime
                                            .value = int.parse(v.toString());
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
                            padding: EdgeInsets.all(15)),
                        child: Center(
                          child: Text(
                            'save',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        onPressed: () {
                          Get.find<iniController>().key.currentState!.save();
                          writeConfig2();
                          Get.find<LogListController>().cConfigSave();
                          Navigator.pop(context);
                        },
                      ),
                      // ElevatedButton(
                      //   child: Text("close"),
                      //   onPressed: () {},
                      //   style: ElevatedButton.styleFrom(
                      //     primary: wrColors.wrPrimary,
                      //   ),
                      // ),
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
            // Get.find<CsvController>().inactiveBtn.value = false;
            Get.find<OesController>().timer?.cancel();
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
