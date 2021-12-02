import 'package:flutter/material.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:get/get.dart';
import 'package:ini/ini.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'dart:io';

import 'package:wr_ui/model/const/style/pallette.dart';
import 'package:wr_ui/view/right_side_menu/csv_creator.dart';

class DialogStorageCtrl extends GetxController {
  static DialogStorageCtrl get to => Get.find();
  RxString OES_Simulation = '1'.obs;
  RxString OES_Count = '0'.obs;
  RxBool bOESConnect = false.obs;
  RxInt VI_Simulation = 0.obs;
  RxInt VI_Count = 0.obs;
  RxBool bVIConnect = false.obs;
  RxString DataPath = './datafiles/'.obs;
  RxString SaveFromStartSignal = '1'.obs;
  RxString measureStartAtProgStart = '1'.obs;
  RxString ExposureTime = '100'.obs;
  RxString DelayTime = '200'.obs;
  RxString a = '0'.obs;
  RxString b = '2'.obs;
  RxString Series_Color_001 = 'red'.obs;
  RxString Series_Color_002 = 'blue'.obs;
  RxString Series_Color_003 = 'grey'.obs;
  RxString Series_Color_004 = 'orange'.obs;
  RxString Series_Color_005 = 'green'.obs;
  RxString Series_Color_006 = 'bluegrey'.obs;
  RxString Series_Color_007 = 'pink'.obs;
  RxString Series_Color_008 = 'purple'.obs;
  ////////////
  RxInt seriesColor = 0.obs;
  ////////////
  Rx<TextEditingController> _textField1 = new TextEditingController().obs;
  Rx<TextEditingController> _textField2 = new TextEditingController().obs;
  ///////////////밑에는 oes chart setting
  Rx<TextEditingController> _textField3 = new TextEditingController().obs;
  Rx<TextEditingController> _textField4 = new TextEditingController().obs;
  Rx<TextEditingController> _textField5 = new TextEditingController().obs;
  Rx<TextEditingController> _textField6 = new TextEditingController().obs;
  Rx<TextEditingController> _textField7 = new TextEditingController().obs;
  Rx<TextEditingController> _textField8 = new TextEditingController().obs;
  Rx<TextEditingController> _textField9 = new TextEditingController().obs;
  Rx<TextEditingController> _textField10 = new TextEditingController().obs;
  Future get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    print('파일이있는 경로=>${directory.path}');
    return directory.path;
  }

  Future get _localFile async {
    final path = await _localPath;
    return File('$path/FreqAI.ini');
  }

  Future readFile() async {
    try {
      final file = await _localFile;

      String content = await file.readAsString();
      print('파일을 읽음$content');
      return content;
    } catch (e) {
      print('파읽을 못읽어옴 : $e');
      return '';
    }
  }

  Future writeFile(String content) async {
    final file = await _localFile;

    return file.writeAsString('$content');
  }

  Future cleanFile() async {
    final file = await _localFile;
    return file.writeAsString('');
  }

  Future _writeStringToTextFile(
      String ExposureTime,
      String DelayTime,
      String Series_Color_001,
      String Series_Color_002,
      String Series_Color_003,
      String Series_Color_004,
      String Series_Color_005,
      String Series_Color_006,
      String Series_Color_007,
      String Series_Color_008) async {
    Config c = Config();
    /////////////////
    c.defaults()['OES_Simulation'] = '1';
    c.defaults()['OES_Count'] = '1';
    c.defaults()['bOESConnect'] = 'false';
    c.defaults()['VI_Simulation'] = '1';
    c.defaults()['VI_Count'] = '1';
    c.defaults()['bVIConnect'] = 'true';
    c.defaults()['DataPath'] = './datafiles/';
    c.defaults()['SaveFromStartSignal'] = '1';
    c.defaults()['measureStartAtProgStart'] = '1';
    /////////////
    c.addSection('OES_Setting');
    c.set('OES_Setting', 'ExposureTime', ExposureTime);
    c.set('OES_Setting', 'DelayTime', DelayTime);
    c.addSection('VI_Setting');
    c.set('VI_Setting', 'a', '0');
    c.set('VI_Setting', 'b', '0');
    c.addSection('OES_CHART_SETTING');
    c.set('OES_CHART_SETTING', 'Series_Color_001',
        Get.find<DialogStorageCtrl>().Series_Color_001.value);
    c.set('OES_CHART_SETTING', 'Series_Color_002', Series_Color_002);
    c.set('OES_CHART_SETTING', 'Series_Color_003', Series_Color_003);
    c.set('OES_CHART_SETTING', 'Series_Color_004', Series_Color_004);
    c.set('OES_CHART_SETTING', 'Series_Color_005', Series_Color_005);
    c.set('OES_CHART_SETTING', 'Series_Color_006', Series_Color_006);
    c.set('OES_CHART_SETTING', 'Series_Color_007', Series_Color_007);
    c.set('OES_CHART_SETTING', 'Series_Color_008', Series_Color_008);
    Config config = c;
    print('컨피그 => ${config.toString()}');

    return Get.find<DialogStorageCtrl>().writeFile(
      config.toString(),
    );
  }
}

class SetBtn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextButton.icon(
        onPressed: () {
          _showDialog(context);
        },
        icon: Icon(
          Icons.settings,
          color: wrColors.white,
        ),
        label: Text(
          'settings',
          style: TextStyle(color: wrColors.white),
        ),
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
              print(dd);
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
                  child: AlertDialog(
                    insetPadding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0)),
                    title: Text("setting"),
                    content: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Container(
                        height: 800,
                        width: 500,
                        padding: EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    'Exposure Time',
                                    style: TextStyle(fontSize: 10),
                                  ),
                                  Divider(
                                    indent: 400,
                                    endIndent: 400,
                                  ),
                                ],
                              ),
                            ),
                            TextField(
                              controller: Get.find<DialogStorageCtrl>()
                                  ._textField1
                                  .value,
                              decoration:
                                  InputDecoration(errorText: _errorText),
                            ),
                            SizedBox(
                              height: 50,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Text(
                                    'Delay Time',
                                    style: TextStyle(fontSize: 10),
                                  ),
                                  Divider(
                                    indent: 400,
                                    endIndent: 400,
                                  ),
                                ],
                              ),
                            ),
                            TextField(
                              controller: Get.find<DialogStorageCtrl>()
                                  ._textField2
                                  .value,
                            ),
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
                                    // Handle color changes
                                    print('series color 1 hexcode' + '$color');
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
                                    print('series color 2 hexcode' + '$color');
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
                                    print('series color 3 hexcode' + '$color');
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
                                    print('series color 4 hexcode' + '$color');
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
                            )

                            // TextField(
                            //   decoration: InputDecoration(
                            //     focusedBorder: OutlineInputBorder(
                            //       borderRadius:
                            //           BorderRadius.all(Radius.circular(10.0)),
                            //       borderSide: BorderSide(
                            //           width: 1, color: Colors.redAccent),
                            //     ),
                            //     enabledBorder: OutlineInputBorder(
                            //       borderRadius:
                            //           BorderRadius.all(Radius.circular(10.0)),
                            //       borderSide: BorderSide(
                            //           width: 1, color: Colors.redAccent),
                            //     ),
                            //     border: OutlineInputBorder(
                            //       borderRadius:
                            //           BorderRadius.all(Radius.circular(10.0)),
                            //     ),
                            //   ),
                            //   controller: Get.find<DialogStorageCtrl>()
                            //       ._textField6
                            //       .value,
                            // ),

                            // Padding(
                            //   padding: const EdgeInsets.all(8.0),
                            //   child: Column(
                            //     children: [
                            //       Text('series color 5'),
                            //       Divider(
                            //         indent: 400,
                            //         endIndent: 400,
                            //       ),
                            //     ],
                            //   ),
                            // ),
                            // TextField(
                            //   controller: Get.find<DialogStorageCtrl>()
                            //       ._textField7
                            //       .value,
                            // ),
                            // Padding(
                            //   padding: const EdgeInsets.all(8.0),
                            //   child: Column(
                            //     children: [
                            //       Text('series color 6'),
                            //       Divider(
                            //         indent: 400,
                            //         endIndent: 400,
                            //       ),
                            //     ],
                            //   ),
                            // ),
                            // TextField(
                            //   controller: Get.find<DialogStorageCtrl>()
                            //       ._textField8
                            //       .value,
                            // ),
                            // Padding(
                            //   padding: const EdgeInsets.all(8.0),
                            //   child: Column(
                            //     children: [
                            //       Text('series color 7'),
                            //       Divider(
                            //         indent: 400,
                            //         endIndent: 400,
                            //       ),
                            //     ],
                            //   ),
                            // ),
                            // TextField(
                            //   controller: Get.find<DialogStorageCtrl>()
                            //       ._textField9
                            //       .value,
                            // ),
                            // Padding(
                            //   padding: const EdgeInsets.all(8.0),
                            //   child: Column(
                            //     children: [
                            //       Text('series color 8'),
                            //       Divider(
                            //         indent: 400,
                            //         endIndent: 400,
                            //       ),
                            //     ],
                            //   ),
                            // ),
                            // TextField(
                            //   controller: Get.find<DialogStorageCtrl>()
                            //       ._textField10
                            //       .value,
                            // ),
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
                          if (Get.find<DialogStorageCtrl>()
                              ._textField1
                              .value
                              .text
                              .isNotEmpty) {
                            Get.find<DialogStorageCtrl>()
                                ._writeStringToTextFile(
                                    Get.find<DialogStorageCtrl>()
                                        ._textField1
                                        .value
                                        .text,
                                    Get.find<DialogStorageCtrl>()
                                        ._textField2
                                        .value
                                        .text,
                                    Get.find<DialogStorageCtrl>()
                                        ._textField3
                                        .value
                                        .text,
                                    Get.find<DialogStorageCtrl>()
                                        ._textField4
                                        .value
                                        .text,
                                    Get.find<DialogStorageCtrl>()
                                        ._textField5
                                        .value
                                        .text,
                                    Get.find<DialogStorageCtrl>()
                                        ._textField6
                                        .value
                                        .text,
                                    Get.find<DialogStorageCtrl>()
                                        ._textField7
                                        .value
                                        .text,
                                    Get.find<DialogStorageCtrl>()
                                        ._textField8
                                        .value
                                        .text,
                                    Get.find<DialogStorageCtrl>()
                                        ._textField9
                                        .value
                                        .text,
                                    Get.find<DialogStorageCtrl>()
                                        ._textField10
                                        .value
                                        .text);
                            Get.find<DialogStorageCtrl>()
                                ._textField1
                                .value
                                .text = '';
                            Get.find<DialogStorageCtrl>()
                                ._textField2
                                .value
                                .text = '';
                            Get.find<DialogStorageCtrl>()
                                ._textField3
                                .value
                                .text = '';
                            Get.find<DialogStorageCtrl>()
                                ._textField4
                                .value
                                .text = '';
                            Get.find<DialogStorageCtrl>()
                                ._textField5
                                .value
                                .text = '';
                            Get.find<DialogStorageCtrl>()
                                ._textField6
                                .value
                                .text = '';
                            Get.find<DialogStorageCtrl>()
                                ._textField7
                                .value
                                .text = '';
                            Get.find<DialogStorageCtrl>()
                                ._textField8
                                .value
                                .text = '';
                            Get.find<DialogStorageCtrl>()
                                ._textField9
                                .value
                                .text = '';
                            Get.find<DialogStorageCtrl>()
                                ._textField10
                                .value
                                .text = '';
                            // _textField1.clear();
                            // _textField2.clear();
                          } else {
                            print('세팅창 채워요');
                          }
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
                )
              ],
            ),
          );
        },
      );
    },
  );
}

String? get _errorText {
  final text1 = Get.find<DialogStorageCtrl>()._textField1.value.text;
  final text2 = Get.find<DialogStorageCtrl>()._textField2.value.text;
  if (text1.isEmpty && text2.isEmpty) {
    return 'ExposureTime을 수정해주세요.';
  }
  if (text1.isNumericOnly) {
    return '숫자만 입력 가능';
  } else {
    return '유효한 값';
  }
  // return null if the text is valid
}

/////////위에가 원래있던거
String? get seriesColorPick {
  final seriesColor1 = Get.find<DialogStorageCtrl>()._textField3.value.text;
  if (seriesColor1 == 1) {
    return 'red';
    // Color(Colors.red);
  } else if (seriesColor1 == 2) {
    // Color(Colors.p)
    return 'blue';
  } else if (seriesColor1 == 3) {
    return 'amber';
    // Color(Colors.red);
  } else if (seriesColor1 == 4) {
    return 'pink';
    // Color(Colors.red);
  } else if (seriesColor1 == 5) {
    return 'yellow';
    // Color(Colors.red);
  } else if (seriesColor1 == 6) {
    return 'purple';
    // Color(Colors.red);
  } else if (seriesColor1 == 7) {
    return 'lightBlue';
    // Color(Colors.red);
  } else if (seriesColor1 == 8) {
    return 'green';
    // Color(Colors.red);
  } else if (seriesColor1 == 9) {
    return 'lightGreen';
    // Color(Colors.red);
  } else if (seriesColor1 == 10) {
    return 'redAccent';
    // Color(Colors.red);
  }
}
