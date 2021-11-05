import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wr_ui/controller/setting_dialog_controller.dart';
import 'package:wr_ui/style/pallette.dart';
import 'package:wr_ui/style/text.dart';

class SettingMenu extends GetView<SettingController> {
  var radioButtonItem = 'ONE';
  var id = 1;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextButton.icon(
        onPressed: () {
          print('세팅다이얼로그창띄울곳');

          showDialog(
              //배경 안어둡게
              barrierDismissible: false,
              barrierColor: null,
              //배경 안어둡게
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  scrollable: true,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  title: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                              onPressed: () {
                                print('세팅창 닫음');

                                Navigator.of(context).pop();
                              },
                              icon: Icon(
                                Icons.close,
                                color: wrColors.wrPrimary,
                              ))
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('Setting'),
                        ],
                      ),
                    ],
                  ),
                  content: SingleChildScrollView(
                    child: ListBody(
                      children: [
                        Row(
                          children: [
                            Row(
                              children: [
                                //라디오가 커런트 아이템 보여주는거
                                Obx(() {
                                  return Radio(
                                    value: controller
                                        .currentRadioBtnItem.value.index,
                                    groupValue: id,
                                    onChanged: (int? val) {
                                      // setState(() {
                                      // print('왜 나중에 적용되냐');
                                      // id = 1;
                                      // radioButtonItem = 'ONE';
                                      // });
                                      controller.changeSettingRadio(val!);
                                    },
                                  );
                                }),
                                // Obx(() {
                                //   Text(radio);
                                // }),
                                // Radio(
                                //   value: 1,
                                //   groupValue: id,
                                //   onChanged: (val) {
                                //     // setState(() {
                                //       // print('왜 나중에 적용되냐');
                                //       // id = 1;
                                //       // radioButtonItem = 'ONE';
                                //     // });
                                //   },
                                // ),

                                Text('Device'),
                              ],
                            ),
                            // Row(
                            //   children: [
                            //     Radio(
                            //       focusColor: wrColors.wrPrimary,
                            //       value: 2,
                            //       groupValue: id,
                            //       onChanged: (val) {
                            //         setState(() {
                            //           print('왜 나중에 적용되냐');
                            //           id = 2;
                            //           radioButtonItem = 'TWO';
                            //           Container(
                            //             color: Colors.amber,
                            //           );
                            //         });
                            //       },
                            //     ),
                            //     Text('Chart'),
                            //   ],
                            // ),
                          ],
                        ),
                        Text('다이얼로그 컨텐츠 테스트2'),
                        Text('다이얼로그 컨텐츠 테스트3'),
                        Text('다이얼로그 컨텐츠 테스트4'),
                        Text('다이얼로그 컨텐츠 테스트1'),
                        Text('다이얼로그 컨텐츠 테스트2'),
                        Text('다이얼로그 컨텐츠 테스트3'),
                        Text('다이얼로그 컨텐츠 테스트4'),
                        Text('다이얼로그 컨텐츠 테스트1'),
                        Text('다이얼로그 컨텐츠 테스트2'),
                        Text('다이얼로그 컨텐츠 테스트3'),
                        Text('다이얼로그 컨텐츠 테스트4'),
                        Text('다이얼로그 컨텐츠 테스트1'),
                        Text('다이얼로그 컨텐츠 테스트2'),
                        Text('다이얼로그 컨텐츠 테스트3'),
                        Text('다이얼로그 컨텐츠 테스트4'),
                        Text('다이얼로그 컨텐츠 테스트1'),
                        Text('다이얼로그 컨텐츠 테스트2'),
                        Text('다이얼로그 컨텐츠 테스트3'),
                        Text('다이얼로그 컨텐츠 테스트4'),
                        Text('다이얼로그 컨텐츠 테스트1'),
                        Text('다이얼로그 컨텐츠 테스트2'),
                        Text('다이얼로그 컨텐츠 테스트3'),
                        Text('다이얼로그 컨텐츠 테스트4'),
                      ],
                    ),
                  ),
                  actions: [
                    ElevatedButton(
                      style:
                          ElevatedButton.styleFrom(primary: wrColors.wrPrimary),
                      onPressed: () {
                        print('세팅적용');
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'Apply',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    OutlinedButton(
                      style:
                          OutlinedButton.styleFrom(primary: wrColors.wrPrimary),
                      onPressed: () {
                        print('세팅창 닫음');
                        Navigator.of(context).pop();
                      },
                      child: Text('Cancel'),
                    )
                  ],
                );
              });
        },
        icon: Icon(
          Icons.settings,
          color: Colors.white,
        ),
        label: Text(
          'Setting',
          style: WrText.WrLeadingFont,
        ),
      ),
    );
  }
}
