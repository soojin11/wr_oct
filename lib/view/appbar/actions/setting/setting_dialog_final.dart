import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wr_ui/model/const/style/pallette.dart';
import 'package:wr_ui/view/appbar/actions/setting/setting_menu_final.dart';
import 'package:wr_ui/view/right_side_menu/ini_creator.dart';

Future<Map<String, dynamic>> settingsDialog(
    BuildContext context, Map<String, dynamic> settings) async {
  return await showDialog(
    barrierColor: null,
    barrierDismissible: false,
    context: context,
    builder: (BuildContext ctx) {
      ////디바이스
      String deviceName = settings['deviceName'].toString();
      double interval = settings['interval'] as double;
      String unit = settings['unit'].toString();
      ////차트
      String chartName = settings['chartName'].toString();
      String chartColor = settings['chartColor'].toString();
      String chartTheme = settings['chartTheme'].toString();
      String seriesType = settings['seriesType'].toString();
      double scaleValue = settings['scaleValue'] as double;
      String exposureTime = settings['exposureTime'].toString();
      var top = 100.0;
      var left = 800.0;
      return StatefulBuilder(
        builder: (BuildContext ctx, StateSetter setState) {
          return GestureDetector(
            onVerticalDragUpdate: (DragUpdateDetails dd) {
              print(dd);
              setState(() {
                top = dd.localPosition.dy;
                left = dd.localPosition.dx;
              });
            },
            child: Stack(children: [
              Positioned(
                top: top,
                left: left,
                child: SimpleDialog(
                  contentPadding: EdgeInsets.zero,
                  titlePadding: const EdgeInsets.fromLTRB(24, 10, 24, 0),
                  title: Text('Settings'),
                  children: [
                    Form(
                      key: Get.find<SettingController>().key,
                      child: Column(
                        children: [
                          Divider(
                            thickness: 0.3,
                            color: Colors.grey[700],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 40),
                            child: Row(
                              children: [
                                Text(
                                  'Device Setting',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: wrColors.wrPrimary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: TextFormField(
                              initialValue: deviceName,
                              decoration: const InputDecoration(
                                icon: Icon(Icons.label),
                                labelText: 'DeviceName',
                              ),
                              onChanged: (String value) {
                                setState(() {
                                  deviceName = value;
                                });
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: TextFormField(
                              initialValue: interval.toString(),
                              decoration: const InputDecoration(
                                icon: Icon(Icons.label),
                                labelText: 'interval',
                              ),
                              onChanged: (var value) {
                                setState(() {
                                  interval = double.parse(value);
                                });
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: TextFormField(
                              initialValue: unit.toString(),
                              decoration: const InputDecoration(
                                icon: Icon(Icons.label),
                                labelText: 'unit',
                              ),
                              onChanged: (String value) {
                                setState(() {
                                  unit = value;
                                });
                              },
                            ),
                          ),
                          ///////////차트세팅
                          Divider(
                            thickness: 0.3,
                            color: Colors.grey[700],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 40),
                            child: Row(
                              children: [
                                Text(
                                  'Chart Setting',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: wrColors.wrPrimary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: TextFormField(
                              initialValue: 'First Chart',
                              decoration: InputDecoration(
                                icon: Icon(Icons.label),
                                labelText: 'Chart Name',
                                hintText: 'Write Chart Name',
                              ),
                              onSaved: (v) {
                                Get.find<SettingController>().chartName.value =
                                    v.toString();
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: TextFormField(
                              initialValue: chartColor.toString(),
                              decoration: const InputDecoration(
                                icon: Icon(Icons.label),
                                labelText: 'Chart Color',
                              ),
                              onChanged: (String value) {
                                setState(() {
                                  chartColor = value;
                                });
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: TextFormField(
                              initialValue: chartTheme.toString(),
                              decoration: const InputDecoration(
                                icon: Icon(Icons.label),
                                labelText: 'Chart Theme',
                              ),
                               onChanged: (String value) {
                                setState(() {
                                  chartTheme = value;
                                });
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: TextFormField(
                              initialValue: seriesType.toString(),
                              decoration: const InputDecoration(
                                icon: Icon(Icons.label),
                                labelText: 'Series Type',
                              ),
                              onChanged: (String value) {
                                setState(() {
                                  seriesType = value;
                                });
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: TextFormField(
                              initialValue: scaleValue.toString(),
                              decoration: const InputDecoration(
                                icon: Icon(Icons.label),
                                labelText: 'Scale Value',
                              ),
                              onChanged: (String value) {
                                setState(() {
                                  scaleValue = double.parse(value);
                                });
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: TextFormField(
                              initialValue:
                                  Get.find<iniControllerWithReactive>()
                                      .exposureTime
                                      .value,
                              decoration: InputDecoration(
                                icon: Icon(Icons.label),
                                labelText: 'Exposure Time',
                                hintText: 'milliseconds',
                              ),
                              onSaved: (val) {
                                // Get.find<SettingController>()
                                //     .exposureTime
                                //     .value = savedValue.toString();
                                //val(텍스트폼에 친거)->
                                Get.find<iniControllerWithReactive>()
                                    .exposureTime
                                    .value = val.toString();
                                // setState(() {
                                // exposureTime = val;
                                // });
                                print(
                                    ' Setting창에서 저장 된 exposureTime=>"${Get.find<iniControllerWithReactive>().exposureTime.value}"  "${Get.find<SettingController>().exposureTime.value}"');
                              },
                              // onSaved: (savedValue) {
                              //   Get.find<SettingController>()
                              //       .exposureTime
                              //       .value = savedValue.toString();

                              //   Get.find<iniControllerWithReactive>()
                              //       .exposureTime
                              //       .value = savedValue.toString();
                              //   setState(() {
                              //     exposureTime = savedValue.toString();
                              //   });
                              //   print(
                              //       ' Setting창에서 저장 된 exposureTime=>"${Get.find<iniControllerWithReactive>().exposureTime.value}"');
                              // },
                            ),
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context, rootNavigator: true)
                            .pop(<String, dynamic>{
                          'deviceName': deviceName,
                          'interval': interval,
                          'unit': unit,

                          ///차트세팅
                          'chartName': chartName,
                          'chartColor': chartColor,
                          'chartTheme': chartTheme,
                          'seriesType': seriesType,
                          'scaleValue': scaleValue,
                          'exposureTime': exposureTime
                        });
                        Get.find<SettingController>().key.currentState!.save();
                      },
                      child: Text('Save'),
                      style:
                          ElevatedButton.styleFrom(primary: wrColors.wrPrimary),
                    ),
                  ],
                ),
              ),
            ]),
          );
        },
      );
    },
  );
}
