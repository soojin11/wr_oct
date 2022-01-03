import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:wr_ui/controller/viz_ctrl.dart';
import 'package:wr_ui/view/appbar/leading/recent_recipe_name.dart';
import 'package:wr_ui/view/chart/oes_chart.dart';
import 'package:wr_ui/view/chart/pages/hover_chart/oes_series.dart';
import 'package:wr_ui/view/chart/pages/hover_chart/hover.dart';
import 'package:wr_ui/view/chart/viz_chart.dart';
import 'package:wr_ui/view/right_side_menu/log_screen.dart';
import 'package:wr_ui/view/right_side_menu/save_ini.dart';

import '../../switch_chart.dart';

class HoverCtrl extends GetxController {
  // RxList<RxBool> vizHover =
  //     [false.obs, false.obs, false.obs, false.obs, false.obs].obs;
  RxBool viz1 = false.obs;
  RxBool viz2 = false.obs;
  RxBool viz3 = false.obs;
  RxBool viz4 = false.obs;
  RxBool viz5 = false.obs;
  RxBool isHover = false.obs;
  RxBool isHover2 = false.obs;
  RxBool isHover3 = false.obs;
  RxBool isHover4 = false.obs;
  RxBool isHover5 = false.obs;
  RxBool isHover6 = false.obs;
  RxBool isHover7 = false.obs;
  RxBool isHover8 = false.obs;

  hoverCard() {
    //ddd
    return VizCtrl.to.selected == "OES"
        ? Row(
            children: [
              FirstHover(),
              SecondHover(),
              ThirdHover(),
              FourthHover(),
              FifthHover(),
              SixthHover(),
              SeventhHover(),
              EightHover()
            ],
          )
        : VizCtrl.to.selected == "VIZ"
            ? Row(
                children: [
                  Obx(() => Hover(
                        onEnter: (PointerEnterEvent event) {
                          viz1(true);
                          // vizHover[0].value == true;
                          // print(vizHover[0].value);
                        },
                        onExit: (PointerExitEvent event) {
                          viz1(false);
                        },
                        onTap: () {
                          VizCtrl.to.chartNum.value == 1;
                          VizCtrl.to.vizCheck1.value = true;
                          VizCtrl.to.vizCheck2.value = false;
                          VizCtrl.to.vizCheck3.value = false;
                          VizCtrl.to.vizCheck4.value = false;
                          VizCtrl.to.vizCheck5.value = false;
                          Get.find<ChartName>().chartName.value = 'VIZ_1';
                        },
                        child: VizCtrl.to.vizFirst(),
                        width: viz1.value ? 200 : 170,
                        height: viz1.value ? 200 : 150,
                      )),
                  SizedBox(width: 50),
                  Obx(() => Hover(
                        onEnter: (PointerEnterEvent event) {
                          viz2(true);
                        },
                        onExit: (PointerExitEvent event) {
                          viz2(false);
                        },
                        onTap: () {
                          VizCtrl.to.chartNum.value == 2;
                          // VizCtrl.to.selectVizChannel.value = [
                          //   false,
                          //   true,
                          //   false,
                          //   false,
                          //   false
                          // ];
                          VizCtrl.to.vizCheck1.value = false;
                          VizCtrl.to.vizCheck2.value = true;
                          VizCtrl.to.vizCheck3.value = false;
                          VizCtrl.to.vizCheck4.value = false;
                          VizCtrl.to.vizCheck5.value = false;
                          Get.find<ChartName>().chartName.value = 'VIZ_2';
                        },
                        child: VizCtrl.to.vizSecond(),
                        width: viz2.value ? 200 : 170,
                        height: viz2.value ? 200 : 150,
                      )),
                  SizedBox(width: 50),
                  Obx(() => Hover(
                        onEnter: (PointerEnterEvent event) {
                          viz3(true);
                        },
                        onExit: (PointerExitEvent event) {
                          viz3(false);
                        },
                        onTap: () {
                          VizCtrl.to.chartNum.value == 3;
                          VizCtrl.to.vizCheck1.value = false;
                          VizCtrl.to.vizCheck2.value = false;
                          VizCtrl.to.vizCheck3.value = true;
                          VizCtrl.to.vizCheck4.value = false;
                          VizCtrl.to.vizCheck5.value = false;
                          Get.find<ChartName>().chartName.value = 'VIZ_3';
                          // VizCtrl.to.selectVizChannel.value = [
                          //   false,
                          //   false,
                          //   true,
                          //   false,
                          //   false
                          // ];
                        },
                        child: VizCtrl.to.vizThird(),
                        width: viz3.value ? 200 : 170,
                        height: viz3.value ? 200 : 150,
                      )),
                  SizedBox(width: 50),
                  Obx(() => Hover(
                        onEnter: (PointerEnterEvent event) {
                          viz4(true);
                        },
                        onExit: (PointerExitEvent event) {
                          viz4(false);
                        },
                        onTap: () {
                          VizCtrl.to.chartNum.value == 4;
                          VizCtrl.to.vizCheck1.value = false;
                          VizCtrl.to.vizCheck2.value = false;
                          VizCtrl.to.vizCheck3.value = false;
                          VizCtrl.to.vizCheck4.value = true;
                          VizCtrl.to.vizCheck5.value = false;
                          Get.find<ChartName>().chartName.value = 'VIZ_4';
                          // VizCtrl.to.selectVizChannel.value = [
                          //   false,
                          //   false,
                          //   false,
                          //   true,
                          //   false
                          // ];
                        },
                        child: VizCtrl.to.vizFourth(),
                        width: viz4.value ? 200 : 170,
                        height: viz4.value ? 200 : 150,
                      )),
                  SizedBox(width: 50),
                  Obx(() => Hover(
                        onEnter: (PointerEnterEvent event) {
                          viz5(true);
                        },
                        onExit: (PointerExitEvent event) {
                          viz5(false);
                        },
                        onTap: () {
                          VizCtrl.to.chartNum.value == 5;
                          VizCtrl.to.vizCheck1.value = false;
                          VizCtrl.to.vizCheck2.value = false;
                          VizCtrl.to.vizCheck3.value = false;
                          VizCtrl.to.vizCheck4.value = false;
                          VizCtrl.to.vizCheck5.value = true;
                          Get.find<ChartName>().chartName.value = 'VIZ_5';
                          // VizCtrl.to.selectVizChannel.value = [
                          //   false,
                          //   false,
                          //   false,
                          //   false,
                          //   true
                          // ];
                          print('5');
                        },
                        child: VizCtrl.to.vizFifth(),
                        width: viz5.value ? 200 : 170,
                        height: viz5.value ? 200 : 150,
                      )),
                  SizedBox(width: 50),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  children: [
                                    Text('Frequency'),
                                    Obx(
                                      () => Switch(
                                        value: VizCtrl.to.vizSeriesList[0],
                                        onChanged: (e) {
                                          VizCtrl.to.vizSeriesList[0] = e;
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text('P_dlv'),
                                    Obx(
                                      () => Switch(
                                        value: VizCtrl.to.vizSeriesList[1],
                                        onChanged: (e) {
                                          VizCtrl.to.vizSeriesList[1] = e;
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text('Phase'),
                                    Obx(
                                      () => Switch(
                                        value: VizCtrl.to.vizSeriesList[6],
                                        onChanged: (e) {
                                          VizCtrl.to.vizSeriesList[6] = e;
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  children: [
                                    Text('V'),
                                    Obx(
                                      () => Switch(
                                        value: VizCtrl.to.vizSeriesList[2],
                                        onChanged: (e) {
                                          VizCtrl.to.vizSeriesList[2] = e;
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text('I'),
                                    Obx(
                                      () => Switch(
                                        value: VizCtrl.to.vizSeriesList[3],
                                        onChanged: (e) {
                                          VizCtrl.to..vizSeriesList[3] = e;
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text('R'),
                                    Obx(
                                      () => Switch(
                                        value: VizCtrl.to.vizSeriesList[4],
                                        onChanged: (e) {
                                          VizCtrl.to.vizSeriesList[4] = e;
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text('X'),
                                    Obx(
                                      () => Switch(
                                        value: VizCtrl.to.vizSeriesList[5],
                                        onChanged: (e) {
                                          VizCtrl.to.vizSeriesList[5] = e;
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  )
                ],
              )
            : Container();
  }
}

class FirstHover extends GetView<HoverCtrl> {
  FirstHover({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (PointerEnterEvent event) {
        controller.isHover(true);
      },
      onExit: (PointerExitEvent event) {
        controller.isHover(false);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Obx(
          () => GestureDetector(
            onTap: () {
              print('1번째 차트 선택');
              Get.find<chooseChart>().chartNum.value = 1;
              Get.find<LogListController>().clickedHover();

              Get.find<OesController>().checkVal1.value = true;
              Get.find<OesController>().checkVal2.value = false;
              Get.find<OesController>().checkVal3.value = false;
              Get.find<OesController>().checkVal4.value = false;
              Get.find<OesController>().checkVal5.value = false;
              Get.find<OesController>().checkVal6.value = false;
              Get.find<OesController>().checkVal7.value = false;
              Get.find<OesController>().checkVal8.value = false;
              Get.find<ChartName>().chartName.value = 'OES_1';
            },
            child: AnimatedContainer(
              margin: EdgeInsets.symmetric(
                  vertical: controller.isHover.value ? 3 : 0),
              decoration: BoxDecoration(
                color: Theme.of(context).appBarTheme.foregroundColor,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: controller.isHover.value
                        ? Colors.cyan.withOpacity(0.2)
                        : Colors.grey, //그림자 색
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 2), // 그림자위치 바꾸는거
                  ),
                ],
              ),
              duration: Duration(milliseconds: 200),
              width: controller.isHover.value ? 200 : 170,
              height: controller.isHover.value ? 200 : 150,
              child: oneHoverChart(),
            ),
          ),
        ),
      ),
    );
  }
}

class SecondHover extends GetView<HoverCtrl> {
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (PointerEnterEvent event) {
        controller.isHover2(true);
      },
      onExit: (PointerExitEvent event) {
        controller.isHover2(false);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Obx(
          () => GestureDetector(
            onTap: () {
              print('2번째 차트 선택');
              Get.find<chooseChart>().chartNum.value = 2;
              Get.find<LogListController>().clickedHover();
              Get.find<OesController>().checkVal1.value = false;
              Get.find<OesController>().checkVal2.value = true;
              Get.find<OesController>().checkVal3.value = false;
              Get.find<OesController>().checkVal4.value = false;
              Get.find<OesController>().checkVal5.value = false;
              Get.find<OesController>().checkVal6.value = false;
              Get.find<OesController>().checkVal7.value = false;
              Get.find<OesController>().checkVal8.value = false;
              Get.find<ChartName>().chartName.value = 'OES_2';
            },
            child: AnimatedContainer(
              margin: EdgeInsets.symmetric(
                  vertical: controller.isHover2.value ? 3 : 0),
              decoration: BoxDecoration(
                color: Theme.of(context).appBarTheme.foregroundColor,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: controller.isHover.value
                        ? Colors.cyan.withOpacity(0.2)
                        : Colors.grey, //그림자 색
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 2), // 그림자위치 바꾸는거
                  ),
                ],
              ),
              duration: Duration(milliseconds: 200),
              width: controller.isHover2.value ? 200 : 170,
              height: controller.isHover2.value ? 200 : 150,
              child: twoHoverChart(),
            ),
          ),
        ),
      ),
    );
  }
}

class ThirdHover extends GetView<HoverCtrl> {
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (PointerEnterEvent event) {
        controller.isHover3(true);
      },
      onExit: (PointerExitEvent event) {
        controller.isHover3(false);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Obx(
          () => GestureDetector(
            onTap: () {
              print('3번째 차트 선택');
              Get.find<chooseChart>().chartNum.value = 3;
              Get.find<LogListController>().clickedHover();
              Get.find<OesController>().checkVal1.value = false;
              Get.find<OesController>().checkVal2.value = false;
              Get.find<OesController>().checkVal3.value = true;
              Get.find<OesController>().checkVal4.value = false;
              Get.find<OesController>().checkVal5.value = false;
              Get.find<OesController>().checkVal6.value = false;
              Get.find<OesController>().checkVal7.value = false;
              Get.find<OesController>().checkVal8.value = false;
              Get.find<ChartName>().chartName.value = 'OES_3';
            },
            child: AnimatedContainer(
              margin: EdgeInsets.symmetric(
                  vertical: controller.isHover3.value ? 3 : 0),
              decoration: BoxDecoration(
                color: Theme.of(context).appBarTheme.foregroundColor,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: controller.isHover.value
                        ? Colors.cyan.withOpacity(0.2)
                        : Colors.grey, //그림자 색
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 2), // 그림자위치 바꾸는거
                  ),
                ],
              ),
              duration: Duration(milliseconds: 200),
              width: controller.isHover3.value ? 200 : 170,
              height: controller.isHover3.value ? 200 : 150,
              child: threeHoverChart(),
            ),
          ),
        ),
      ),
    );
  }
}

class FourthHover extends GetView<HoverCtrl> {
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (PointerEnterEvent event) {
        controller.isHover4(true);
      },
      onExit: (PointerExitEvent event) {
        controller.isHover4(false);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Obx(
          () => GestureDetector(
            onTap: () {
              print('4번째 차트 선택');
              Get.find<chooseChart>().chartNum.value = 4;
              Get.find<LogListController>().clickedHover();
              Get.find<OesController>().checkVal1.value = false;
              Get.find<OesController>().checkVal2.value = false;
              Get.find<OesController>().checkVal3.value = false;
              Get.find<OesController>().checkVal4.value = true;
              Get.find<OesController>().checkVal5.value = false;
              Get.find<OesController>().checkVal6.value = false;
              Get.find<OesController>().checkVal7.value = false;
              Get.find<OesController>().checkVal8.value = false;
              Get.find<ChartName>().chartName.value = 'OES_4';
            },
            child: AnimatedContainer(
              margin: EdgeInsets.symmetric(
                  vertical: controller.isHover4.value ? 3 : 0),
              decoration: BoxDecoration(
                color: Theme.of(context).appBarTheme.foregroundColor,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: controller.isHover.value
                        ? Colors.cyan.withOpacity(0.2)
                        : Colors.grey, //그림자 색
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 2), // 그림자위치 바꾸는거
                  ),
                ],
              ),
              duration: Duration(milliseconds: 200),
              width: controller.isHover4.value ? 200 : 170,
              height: controller.isHover4.value ? 200 : 150,
              child: fourHoverChart(),
            ),
          ),
        ),
      ),
    );
  }
}

class FifthHover extends GetView<HoverCtrl> {
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (PointerEnterEvent event) {
        controller.isHover5(true);
      },
      onExit: (PointerExitEvent event) {
        controller.isHover5(false);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Obx(
          () => GestureDetector(
            onTap: () {
              print('5번째 차트 선택');
              Get.find<chooseChart>().chartNum.value = 5;
              Get.find<LogListController>().clickedHover();
              Get.find<OesController>().checkVal1.value = false;
              Get.find<OesController>().checkVal2.value = false;
              Get.find<OesController>().checkVal3.value = false;
              Get.find<OesController>().checkVal4.value = false;
              Get.find<OesController>().checkVal5.value = true;
              Get.find<OesController>().checkVal6.value = false;
              Get.find<OesController>().checkVal7.value = false;
              Get.find<OesController>().checkVal8.value = false;
              Get.find<ChartName>().chartName.value = 'OES_5';
            },
            child: AnimatedContainer(
              margin: EdgeInsets.symmetric(
                  vertical: controller.isHover5.value ? 3 : 0),
              decoration: BoxDecoration(
                color: Theme.of(context).appBarTheme.foregroundColor,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: controller.isHover.value
                        ? Colors.cyan.withOpacity(0.2)
                        : Colors.grey, //그림자 색
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 2), // 그림자위치 바꾸는거
                  ),
                ],
              ),
              duration: Duration(milliseconds: 200),
              width: controller.isHover5.value ? 200 : 170,
              height: controller.isHover5.value ? 200 : 150,
              child: fiveHoverChart(),
            ),
          ),
        ),
      ),
    );
  }
}

class SixthHover extends GetView<HoverCtrl> {
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (PointerEnterEvent event) {
        controller.isHover6(true);
      },
      onExit: (PointerExitEvent event) {
        controller.isHover6(false);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Obx(
          () => GestureDetector(
            onTap: () {
              print('6번째 차트 선택');
              Get.find<chooseChart>().chartNum.value = 6;
              Get.find<LogListController>().clickedHover();
              Get.find<OesController>().checkVal1.value = false;
              Get.find<OesController>().checkVal2.value = false;
              Get.find<OesController>().checkVal3.value = false;
              Get.find<OesController>().checkVal4.value = false;
              Get.find<OesController>().checkVal5.value = false;
              Get.find<OesController>().checkVal6.value = true;
              Get.find<OesController>().checkVal7.value = false;
              Get.find<OesController>().checkVal8.value = false;
              Get.find<ChartName>().chartName.value = 'OES_6';
            },
            child: AnimatedContainer(
              margin: EdgeInsets.symmetric(
                  vertical: controller.isHover6.value ? 3 : 0),
              decoration: BoxDecoration(
                color: Theme.of(context).appBarTheme.foregroundColor,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: controller.isHover.value
                        ? Colors.cyan.withOpacity(0.2)
                        : Colors.grey, //그림자 색
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 2), // 그림자위치 바꾸는거
                  ),
                ],
              ),
              duration: Duration(milliseconds: 200),
              width: controller.isHover6.value ? 200 : 170,
              height: controller.isHover6.value ? 200 : 150,
              child: sixHoverChart(),
            ),
          ),
        ),
      ),
    );
  }
}

class SeventhHover extends GetView<HoverCtrl> {
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (PointerEnterEvent event) {
        controller.isHover7(true);
      },
      onExit: (PointerExitEvent event) {
        controller.isHover7(false);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Obx(
          () => GestureDetector(
            onTap: () {
              print('7번째 차트 선택');
              Get.find<chooseChart>().chartNum.value = 7;
              Get.find<LogListController>().clickedHover();
              Get.find<OesController>().checkVal1.value = false;
              Get.find<OesController>().checkVal2.value = false;
              Get.find<OesController>().checkVal3.value = false;
              Get.find<OesController>().checkVal4.value = false;
              Get.find<OesController>().checkVal5.value = false;
              Get.find<OesController>().checkVal6.value = false;
              Get.find<OesController>().checkVal7.value = true;
              Get.find<OesController>().checkVal8.value = false;
              Get.find<ChartName>().chartName.value = 'OES_7';
            },
            child: AnimatedContainer(
              margin: EdgeInsets.symmetric(
                  vertical: controller.isHover7.value ? 3 : 0),
              decoration: BoxDecoration(
                color: Theme.of(context).appBarTheme.foregroundColor,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: controller.isHover.value
                        ? Colors.cyan.withOpacity(0.2)
                        : Colors.grey, //그림자 색
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 2), // 그림자위치 바꾸는거
                  ),
                ],
              ),
              duration: Duration(milliseconds: 200),
              width: controller.isHover7.value ? 200 : 170,
              height: controller.isHover7.value ? 200 : 150,
              child: sevenHoverChart(),
            ),
          ),
        ),
      ),
    );
  }
}

class EightHover extends GetView<HoverCtrl> {
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (PointerEnterEvent event) {
        controller.isHover8(true);
      },
      onExit: (PointerExitEvent event) {
        controller.isHover8(false);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Obx(
          () => GestureDetector(
            onTap: () {
              print('8번째 차트 선택');
              Get.find<chooseChart>().chartNum.value = 8;
              Get.find<LogListController>().clickedHover();
              Get.find<OesController>().checkVal1.value = false;
              Get.find<OesController>().checkVal2.value = false;
              Get.find<OesController>().checkVal3.value = false;
              Get.find<OesController>().checkVal4.value = false;
              Get.find<OesController>().checkVal5.value = false;
              Get.find<OesController>().checkVal6.value = false;
              Get.find<OesController>().checkVal7.value = false;
              Get.find<OesController>().checkVal8.value = true;
              Get.find<ChartName>().chartName.value = 'OES_8';
            },
            child: AnimatedContainer(
              margin: EdgeInsets.symmetric(
                  vertical: controller.isHover8.value ? 3 : 0),
              decoration: BoxDecoration(
                color: Theme.of(context).appBarTheme.foregroundColor,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: controller.isHover.value
                        ? Colors.cyan.withOpacity(0.2)
                        : Colors.grey, //그림자 색
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 2), // 그림자위치 바꾸는거
                  ),
                ],
              ),
              duration: Duration(milliseconds: 200),
              width: controller.isHover8.value ? 200 : 170,
              height: controller.isHover8.value ? 200 : 150,
              child: eightHoverChart(),
            ),
          ),
        ),
      ),
    );
  }
}

class Hover extends GetView<HoverCtrl> {
  Hover(
      {Key? key,
      required this.onEnter,
      required this.onExit,
      required this.onTap,
      required this.width,
      required this.height,
      required this.child})
      : super(key: key);

  PointerEnterEventListener onEnter;
  PointerExitEventListener onExit;
  GestureTapCallback onTap;
  double width;
  double height;
  Widget child;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HoverCtrl>(
        builder: (controller) => Obx(
              () => MouseRegion(
                onEnter: onEnter,
                // (PointerEnterEvent event) {
                //   controller.isHover(true);
                // },
                onExit: onExit,
                // (PointerExitEvent event) {
                //   controller.isHover(false);
                // },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: onTap,
                    child: AnimatedContainer(
                        margin: EdgeInsets.symmetric(
                            vertical: controller.isHover.value ? 3 : 0),
                        decoration: BoxDecoration(
                          color: Theme.of(context).appBarTheme.foregroundColor,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: controller.isHover.value
                                  ? Colors.cyan.withOpacity(0.2)
                                  : Colors.grey, //그림자 색
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: Offset(0, 2), // 그림자위치 바꾸는거
                            ),
                          ],
                        ),
                        duration: Duration(milliseconds: 200),
                        width: width,
                        //controller.isHover.value ? 200 : 170,
                        height: height,
                        // controller.isHover.value ? 200 : 150,
                        child: child),
                  ),
                ),
              ),
            ));
  }
}
