import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wr_ui/model/const/style/pallette.dart';
import 'package:wr_ui/view/appbar/actions/setting/setting_menu_final.dart';
import 'package:wr_ui/view/right_side_menu/ini_creator.dart';

Future settingsDialog(BuildContext context) async {
  return await showDialog(
    barrierColor: null,
    barrierDismissible: false,
    context: context,
    builder: (BuildContext ctx) {
      ////디바이스
      // String ExposureTime = settings['ExposureTime'].toString();
      // double DelayTime = settings['DelayTime'].toString();
      // String unit = settings['unit'].toString();
      // ////차트
      // String chartName = settings['chartName'].toString();
      // String chartColor = settings['chartColor'].toString();
      // String chartTheme = settings['chartTheme'].toString();
      // String seriesType = settings['seriesType'].toString();
      // double scaleValue = settings['scaleValue'] as double;
      // String ExposureTime = settings['ExposureTime'].toString();
      var top = 100.0;
      var left = 800.0;
      return StatefulBuilder(
        builder: (BuildContext ctx, StateSetter setState) {
          return GestureDetector(
            onVerticalDragUpdate: (DragUpdateDetails dd) {
              print(dd);
              setState(() {
                top = dd.localPosition.dy - 50;
                left = dd.localPosition.dx - 80;
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
                                  'OES Setting',
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
                              initialValue:
                                  Get.find<iniControllerWithReactive>()
                                      .ExposureTime
                                      .value,
                              decoration: InputDecoration(
                                icon: Icon(Icons.label),
                                labelText: 'Exposure Time',
                                hintText: 'milliseconds',
                              ),
                              onSaved: (val) {
                                // Get.find<SettingController>()
                                //     .ExposureTime
                                //     .value = savedValue.toString();
                                //val(텍스트폼에 친거)->
                                Get.find<iniControllerWithReactive>()
                                    .ExposureTime
                                    .value = val.toString();
                                // setState(() {
                                // ExposureTime = val;
                                // });
                              },
                              // onSaved: (savedValue) {
                              //   Get.find<SettingController>()
                              //       .ExposureTime
                              //       .value = savedValue.toString();

                              //   Get.find<iniControllerWithReactive>()
                              //       .ExposureTime
                              //       .value = savedValue.toString();
                              //   setState(() {
                              //     ExposureTime = savedValue.toString();
                              //   });
                              //   print(
                              //       ' Setting창에서 저장 된 ExposureTime=>"${Get.find<iniControllerWithReactive>().ExposureTime.value}"');
                              // },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: TextFormField(
                              initialValue:
                                  Get.find<iniControllerWithReactive>()
                                      .DelayTime
                                      .value,
                              decoration: const InputDecoration(
                                icon: Icon(Icons.label),
                                labelText: 'DelayTime',
                              ),
                              onSaved: (val) {
                                Get.find<iniControllerWithReactive>()
                                    .DelayTime
                                    .value = val.toString();
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
                                  'VI Setting',
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
                              initialValue:
                                  Get.find<iniControllerWithReactive>().a.value,
                              decoration: const InputDecoration(
                                icon: Icon(Icons.label),
                                labelText: 'a',
                              ),
                              onSaved: (val) {
                                Get.find<iniControllerWithReactive>().a.value =
                                    val.toString();
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: TextFormField(
                              initialValue:
                                  Get.find<iniControllerWithReactive>().b.value,
                              decoration: const InputDecoration(
                                icon: Icon(Icons.label),
                                labelText: 'b',
                              ),
                              onSaved: (val) {
                                Get.find<iniControllerWithReactive>().b.value =
                                    val.toString();
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: TextFormField(
                              initialValue:
                                  Get.find<iniControllerWithReactive>()
                                      .Series_Color_001
                                      .value,
                              decoration: InputDecoration(
                                icon: Icon(Icons.label),
                                labelText: 'First Series Color',
                                hintText: 'color',
                              ),
                              onSaved: (val) {
                                Get.find<iniControllerWithReactive>()
                                    .Series_Color_001
                                    .value = val.toString();
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: TextFormField(
                              initialValue:
                                  Get.find<iniControllerWithReactive>()
                                      .Series_Color_001
                                      .value,
                              decoration: InputDecoration(
                                icon: Icon(Icons.label),
                                labelText: 'Second Series Color',
                                hintText: 'color',
                              ),
                              onSaved: (val) {
                                Get.find<iniControllerWithReactive>()
                                    .Series_Color_002
                                    .value = val.toString();
                              },
                            ),
                          ),
                          ////////////////
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: TextFormField(
                              initialValue:
                                  Get.find<iniControllerWithReactive>()
                                      .ExposureTime
                                      .value,
                              decoration: InputDecoration(
                                  icon: Icon(Icons.label),
                                  labelText: 'Exposure Time',
                                  hintText: 'milliseconds',
                                  helperText: 'aaa'),
                              onSaved: (val) {
                                // Get.find<SettingController>()
                                //     .ExposureTime
                                //     .value = savedValue.toString();
                                //val(텍스트폼에 친거)->
                                Get.find<iniControllerWithReactive>()
                                    .ExposureTime
                                    .value = val.toString();
                                // setState(() {
                                // ExposureTime = val;
                                // });
                              },
                              // onSaved: (savedValue) {
                              //   Get.find<SettingController>()
                              //       .ExposureTime
                              //       .value = savedValue.toString();

                              //   Get.find<iniControllerWithReactive>()
                              //       .ExposureTime
                              //       .value = savedValue.toString();
                              //   setState(() {
                              //     ExposureTime = savedValue.toString();
                              //   });
                              //   print(
                              //       ' Setting창에서 저장 된 ExposureTime=>"${Get.find<iniControllerWithReactive>().ExposureTime.value}"');
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
                          ///차트세팅
                          // 'chartName': chartName,
                          // 'chartColor': chartColor,
                          // 'chartTheme': chartTheme,
                          // 'seriesType': seriesType,
                          // 'scaleValue': scaleValue,
                          // 'ExposureTime': ExposureTime
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

// Future<Map<String, dynamic>> settingsDialog(
//     BuildContext context, Map<String, dynamic> settings) async {
//   return await showDialog(
//     barrierColor: null,
//     barrierDismissible: false,
//     context: context,
//     builder: (BuildContext ctx) {
//       ////디바이스
//       String ExposureTime = settings['ExposureTime'].toString();
//       double DelayTime = settings['DelayTime'].toString();
//       String unit = settings['unit'].toString();
//       ////차트
//       String chartName = settings['chartName'].toString();
//       String chartColor = settings['chartColor'].toString();
//       String chartTheme = settings['chartTheme'].toString();
//       String seriesType = settings['seriesType'].toString();
//       double scaleValue = settings['scaleValue'] as double;
//       // String ExposureTime = settings['ExposureTime'].toString();
//       var top = 100.0;
//       var left = 800.0;
//       return StatefulBuilder(
//         builder: (BuildContext ctx, StateSetter setState) {
//           return GestureDetector(
//             onVerticalDragUpdate: (DragUpdateDetails dd) {
//               print(dd);
//               setState(() {
//                 top = dd.localPosition.dy - 50;
//                 left = dd.localPosition.dx - 80;
//               });
//             },
//             child: Stack(children: [
//               Positioned(
//                 top: top,
//                 left: left,
//                 child: SimpleDialog(
//                   contentPadding: EdgeInsets.zero,
//                   titlePadding: const EdgeInsets.fromLTRB(24, 10, 24, 0),
//                   title: Text('Settings'),
//                   children: [
//                     Form(
//                       key: Get.find<SettingController>().key,
//                       child: Column(
//                         children: [
//                           Divider(
//                             thickness: 0.3,
//                             color: Colors.grey[700],
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.only(left: 40),
//                             child: Row(
//                               children: [
//                                 Text(
//                                   'OES Setting',
//                                   style: TextStyle(
//                                     fontSize: 20,
//                                     color: wrColors.wrPrimary,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.all(8),
//                             child: TextFormField(
//                               initialValue:
//                                   Get.find<iniControllerWithReactive>()
//                                       .ExposureTime
//                                       .value,
//                               decoration: InputDecoration(
//                                 icon: Icon(Icons.label),
//                                 labelText: 'Exposure Time',
//                                 hintText: 'milliseconds',
//                               ),
//                               onSaved: (val) {
//                                 // Get.find<SettingController>()
//                                 //     .ExposureTime
//                                 //     .value = savedValue.toString();
//                                 //val(텍스트폼에 친거)->
//                                 Get.find<iniControllerWithReactive>()
//                                     .ExposureTime
//                                     .value = val.toString();
//                                 // setState(() {
//                                 // ExposureTime = val;
//                                 // });
//                                 print(
//                                     ' Setting창에서 저장 된 ExposureTime=>"${Get.find<iniControllerWithReactive>().ExposureTime.value}"  "${Get.find<SettingController>().ExposureTime.value}"');
//                               },
//                               // onSaved: (savedValue) {
//                               //   Get.find<SettingController>()
//                               //       .ExposureTime
//                               //       .value = savedValue.toString();

//                               //   Get.find<iniControllerWithReactive>()
//                               //       .ExposureTime
//                               //       .value = savedValue.toString();
//                               //   setState(() {
//                               //     ExposureTime = savedValue.toString();
//                               //   });
//                               //   print(
//                               //       ' Setting창에서 저장 된 ExposureTime=>"${Get.find<iniControllerWithReactive>().ExposureTime.value}"');
//                               // },
//                             ),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.all(8),
//                             child: TextFormField(
//                               initialValue: DelayTime.toString(),
//                               decoration: const InputDecoration(
//                                 icon: Icon(Icons.label),
//                                 labelText: 'DelayTime',
//                               ),
//                               onSaved: (val) {
//                                 Get.find<iniControllerWithReactive>()
//                                     .DelayTime
//                                     .value = val.toString();
//                               },
//                             ),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.all(8),
//                             child: TextFormField(
//                               initialValue: unit.toString(),
//                               decoration: const InputDecoration(
//                                 icon: Icon(Icons.label),
//                                 labelText: 'unit',
//                               ),
//                               onChanged: (String value) {
//                                 setState(() {
//                                   unit = value;
//                                 });
//                               },
//                             ),
//                           ),
//                           ///////////차트세팅
//                           Divider(
//                             thickness: 0.3,
//                             color: Colors.grey[700],
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.only(left: 40),
//                             child: Row(
//                               children: [
//                                 Text(
//                                   'Chart Setting',
//                                   style: TextStyle(
//                                     fontSize: 20,
//                                     color: wrColors.wrPrimary,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.all(8),
//                             child: TextFormField(
//                               initialValue: 'First Chart',
//                               decoration: InputDecoration(
//                                 icon: Icon(Icons.label),
//                                 labelText: 'Chart Name',
//                                 hintText: 'Write Chart Name',
//                               ),
//                               onSaved: (v) {
//                                 Get.find<SettingController>().chartName.value =
//                                     v.toString();
//                               },
//                             ),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.all(8),
//                             child: TextFormField(
//                               initialValue: chartColor.toString(),
//                               decoration: const InputDecoration(
//                                 icon: Icon(Icons.label),
//                                 labelText: 'Chart Color',
//                               ),
//                               onChanged: (String value) {
//                                 setState(() {
//                                   chartColor = value;
//                                 });
//                               },
//                             ),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.all(8),
//                             child: TextFormField(
//                               initialValue: chartTheme.toString(),
//                               decoration: const InputDecoration(
//                                 icon: Icon(Icons.label),
//                                 labelText: 'Chart Theme',
//                               ),
//                               onChanged: (String value) {
//                                 setState(() {
//                                   chartTheme = value;
//                                 });
//                               },
//                             ),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.all(8),
//                             child: TextFormField(
//                               initialValue: seriesType.toString(),
//                               decoration: const InputDecoration(
//                                 icon: Icon(Icons.label),
//                                 labelText: 'Series Type',
//                               ),
//                               onChanged: (String value) {
//                                 setState(() {
//                                   seriesType = value;
//                                 });
//                               },
//                             ),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.all(8),
//                             child: TextFormField(
//                               initialValue: scaleValue.toString(),
//                               decoration: const InputDecoration(
//                                 icon: Icon(Icons.label),
//                                 labelText: 'Scale Value',
//                               ),
//                               onChanged: (String value) {
//                                 setState(() {
//                                   scaleValue = double.parse(value);
//                                 });
//                               },
//                             ),
//                           ),
//                           ////////////////
//                           Padding(
//                             padding: const EdgeInsets.all(8),
//                             child: TextFormField(
//                               initialValue:
//                                   Get.find<iniControllerWithReactive>()
//                                       .ExposureTime
//                                       .value,
//                               decoration: InputDecoration(
//                                 icon: Icon(Icons.label),
//                                 labelText: 'Exposure Time',
//                                 hintText: 'milliseconds',
//                               ),
//                               onSaved: (val) {
//                                 // Get.find<SettingController>()
//                                 //     .ExposureTime
//                                 //     .value = savedValue.toString();
//                                 //val(텍스트폼에 친거)->
//                                 Get.find<iniControllerWithReactive>()
//                                     .ExposureTime
//                                     .value = val.toString();
//                                 // setState(() {
//                                 // ExposureTime = val;
//                                 // });
//                                 print(
//                                     ' Setting창에서 저장 된 ExposureTime=>"${Get.find<iniControllerWithReactive>().ExposureTime.value}"  "${Get.find<SettingController>().ExposureTime.value}"');
//                               },
//                               // onSaved: (savedValue) {
//                               //   Get.find<SettingController>()
//                               //       .ExposureTime
//                               //       .value = savedValue.toString();

//                               //   Get.find<iniControllerWithReactive>()
//                               //       .ExposureTime
//                               //       .value = savedValue.toString();
//                               //   setState(() {
//                               //     ExposureTime = savedValue.toString();
//                               //   });
//                               //   print(
//                               //       ' Setting창에서 저장 된 ExposureTime=>"${Get.find<iniControllerWithReactive>().ExposureTime.value}"');
//                               // },
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     ElevatedButton(
//                       onPressed: () {
//                         Navigator.of(context, rootNavigator: true)
//                             .pop(<String, dynamic>{
//                           ///차트세팅
//                           // 'chartName': chartName,
//                           // 'chartColor': chartColor,
//                           // 'chartTheme': chartTheme,
//                           // 'seriesType': seriesType,
//                           // 'scaleValue': scaleValue,
//                           'ExposureTime': ExposureTime
//                         });
//                         Get.find<SettingController>().key.currentState!.save();
//                       },
//                       child: Text('Save'),
//                       style:
//                           ElevatedButton.styleFrom(primary: wrColors.wrPrimary),
//                     ),
//                   ],
//                 ),
//               ),
//             ]),
//           );
//         },
//       );
//     },
//   );
// }
