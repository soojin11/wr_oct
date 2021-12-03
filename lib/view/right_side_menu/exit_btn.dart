import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
// ignore: unused_import
import 'package:webview_flutter/webview_flutter.dart';
import 'package:wr_ui/main.dart';
import 'package:wr_ui/model/const/style/pallette.dart';
import 'package:wr_ui/view/appbar/leading/run_error_status_mark.dart';
import 'package:wr_ui/view/chart/oes_chart.dart';
import 'package:wr_ui/view/right_side_menu/ini_creator.dart';
import 'package:wr_ui/view/right_side_menu/log_screen.dart';

// ignore: must_be_immutable
class ExitBtn extends StatelessWidget {
  ExitBtn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<bool?> showWarning(BuildContext context) async => showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
              title: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    '측정중입니다.\n',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Divider(
                    indent: 5,
                    endIndent: 5,
                  )
                ],
              ),
              content: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.check_circle_outlined,
                    color: Colors.red[400],
                    size: 12,
                  ),
                  SizedBox(
                    width: 6,
                  ),
                  Text(
                    '측정을 중지하시겠습니까?',
                    style: TextStyle(color: Colors.red[400], fontSize: 16),
                  ),
                ],
              ),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    ////////측정 종료
                    Get.find<OesController>().inactiveBtn.value = false;
                    // Get.find<VizController>().inactiveBtn.value = false;
                    // Get.find<VizController>().timer.cancel();
                    Get.find<OesController>().timer.cancel();
                    Get.find<LogListController>().clickedStop();
                    Get.find<runErrorStatusController>().connect.value = false;
                    Get.find<runErrorStatusController>().textmsg.value = 'STOP';
                    // Get.find<iniControllerWithReactive>().measureStartAtProgStart = '';
                    /////////////////측정 종료
                    ////////////프로그램 종료
                    // exit(0);
                    ////////////프로그램 종료
                    showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                              title: Column(
                                children: [
                                  Text('종료하시겠습니까?'),
                                  Divider(
                                    indent: 5,
                                    endIndent: 5,
                                  )
                                ],
                              ),
                              content: Row(
                                children: [
                                  Icon(Icons.warning),
                                  Text(
                                    '프로그램이 완전히 종료됩니다.',
                                    style: TextStyle(
                                        color: Colors.red[400], fontSize: 16),
                                  ),
                                ],
                              ),
                              actions: [
                                ElevatedButton(
                                  onPressed: () {
                                    // closeAll = wgsFunction
                                    //     .lookup<
                                    //         NativeFunction<
                                    //             Void Function()>>('CloseAll')
                                    //     .asFunction();
                                    // var closeall = closeAll();
                                    print('closeAll??' +
                                        '${closeAll.toString()}');
                                    exit(0);
                                  },
                                  child: Text(
                                    '예',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 12),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                      primary: wrColors.wrPrimary,
                                      onPrimary: Colors.blue[700],
                                      shadowColor: wrColors.wrPrimary),
                                ),
                                OutlinedButton(
                                  onPressed: () =>
                                      Navigator.pop(context, false),
                                  child: Text(
                                    '아니오',
                                    style: TextStyle(
                                      color: wrColors.wrPrimary,
                                      fontSize: 12,
                                    ),
                                  ),
                                  style: OutlinedButton.styleFrom(
                                    side: BorderSide(
                                      color: wrColors.wrPrimary,
                                    ),
                                  ),
                                ),
                              ],
                            ));
                  },

                  //////////////////////
                  // onPressed: () async {
                  //   Get.find<iniControllerWithReactive>()
                  //       .measureStartAtProgStart
                  //       .value = 0;
                  //   // exit(0);
                  //   // Navigator.pop(context, true);
                  //   // SystemNavigator.pop();
                  // },
                  ///////////////
                  child: Text(
                    '측정 종료',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                  style: ElevatedButton.styleFrom(
                      primary: wrColors.wrPrimary,
                      onPrimary: Colors.blue[700],
                      shadowColor: wrColors.wrPrimary),
                ),
                OutlinedButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: Text(
                    '아니오',
                    style: TextStyle(
                      color: wrColors.wrPrimary,
                      fontSize: 12,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(
                      color: wrColors.wrPrimary,
                    ),
                  ),
                ),
              ],
            ));
    return WillPopScope(
        onWillPop: () async {
          showWarning(context);
          final shouldPop = await showWarning(context);
          return shouldPop ?? false;
        },
        child: TextButton.icon(
          onPressed: () {
            print(
                '트라이캐치 ->${Get.find<iniControllerWithReactive>().measureStartAtProgStart}');
            if (Get.find<iniControllerWithReactive>().measureStartAtProgStart ==
                '') {
              print('바로닫기');
              showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: Column(
                    children: [
                      Text('종료하시겠습니까?'),
                      Divider(
                        indent: 5,
                        endIndent: 5,
                      )
                    ],
                  ),
                  content: Row(
                    children: [
                      Icon(
                        Icons.warning,
                        color: Colors.red,
                      ),
                      Text(
                        '프로그램이 완전히 종료됩니다',
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                  actions: [
                    ElevatedButton(
                      onPressed: () {
                        exit(0);
                      },
                      child: Text(
                        '예',
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                      style: ElevatedButton.styleFrom(
                          primary: wrColors.wrPrimary,
                          onPrimary: Colors.blue[700],
                          shadowColor: wrColors.wrPrimary),
                    ),
                    OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context, false);
                      },
                      child: Text(
                        '아니오',
                        style: TextStyle(
                          color: wrColors.wrPrimary,
                          fontSize: 12,
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(
                          color: wrColors.wrPrimary,
                        ),
                      ),
                    )
                  ],
                ),
              );
              // AlertDialog(
              //   title: Text('바로닫기'),
              //   content: Text('종료??????'),
              //   actions: [
              //     ElevatedButton(
              //       onPressed: () {},
              //       child: Text('예'),
              //     ),
              //     ElevatedButton(
              //       onPressed: () {},
              //       child: Text('아니요'),
              //     )
              //   ],
              // );
            } else {
              try {
                Get.find<iniControllerWithReactive>().measureStartAtProgStart ==
                        '0' ||
                    Get.find<iniControllerWithReactive>()
                            .measureStartAtProgStart ==
                        '1';
                print('에러발생');

                if (Get.find<iniControllerWithReactive>()
                            .measureStartAtProgStart ==
                        '0' ||
                    Get.find<iniControllerWithReactive>()
                            .measureStartAtProgStart ==
                        '1') {
                  throw new Exception("프로그램 실행중");
                }
              } catch (e) {
                showWarning(context);
                print('프로그램 실행중! 종료못함$e');
                // showWarning(context);
              }
            }
          },
          icon: Icon(
            Icons.exit_to_app,
            color: Colors.blueGrey,
          ),
          label: Text(
            'Exit',
            style:
                TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.bold),
          ),
        ));
  }
}
