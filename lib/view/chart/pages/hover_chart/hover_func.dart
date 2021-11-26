import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wr_ui/view/chart/pages/hover_chart/oes_series.dart';
import 'package:wr_ui/view/chart/pages/navigator_page/hover_page.dart';

class BtnHoverCtrl extends GetxController {
  RxBool isHover = false.obs;
  RxBool isHover2 = false.obs;
  RxBool isHover3 = false.obs;
  RxBool isHover4 = false.obs;
  RxBool isHover5 = false.obs;
  RxBool isHover6 = false.obs;
  RxBool isHover7 = false.obs;
  RxBool isHover8 = false.obs;

  @override
  void onClose(){
    BtnHoverCtrl;
    super.onClose();
  }
}

class FirstHover extends GetView<BtnHoverCtrl> {
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
              Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation1, animation2) =>
                          Hoverpage(),
                      transitionDuration: Duration.zero,
                    ));
            },
            child: AnimatedContainer(
              margin: EdgeInsets.symmetric(
                  vertical: controller.isHover.value ? 3 : 0),
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 7,
                        spreadRadius: 5,
                        color: controller.isHover.value
                            ? Colors.cyan.withOpacity(0.2)
                            : Colors.grey)
                  ],
                  color: Colors.white,
                  //Theme.of(context).appBarTheme.foregroundColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  )),
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

class SecondHover extends GetView<BtnHoverCtrl> {
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
              Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation1, animation2) =>
                          SecondHover(),
                      transitionDuration: Duration.zero,
                    ));
            },
            child: AnimatedContainer(
              margin: EdgeInsets.symmetric(
                  vertical: controller.isHover2.value ? 3 : 0),
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 7,
                        spreadRadius: 5,
                        color: controller.isHover2.value
                            ? Colors.cyan.withOpacity(0.2)
                            : Colors.grey)
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  )),
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
class ThirdHover extends GetView<BtnHoverCtrl> {
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
            },
            child: AnimatedContainer(
              margin: EdgeInsets.symmetric(
                  vertical: controller.isHover3.value ? 3 : 0),
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 7,
                        spreadRadius: 5,
                        color: controller.isHover3.value
                            ? Colors.cyan.withOpacity(0.2)
                            : Colors.grey)
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  )),
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
class FourthHover extends GetView<BtnHoverCtrl> {
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
            },
            child: AnimatedContainer(
              margin: EdgeInsets.symmetric(
                  vertical: controller.isHover4.value ? 3 : 0),
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 7,
                        spreadRadius: 5,
                        color: controller.isHover4.value
                            ? Colors.cyan.withOpacity(0.2)
                            : Colors.grey)
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  )),
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
class FifthHover extends GetView<BtnHoverCtrl> {
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
            },
            child: AnimatedContainer(
              margin: EdgeInsets.symmetric(
                  vertical: controller.isHover5.value ? 3 : 0),
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 7,
                        spreadRadius: 5,
                        color: controller.isHover5.value
                            ? Colors.cyan.withOpacity(0.2)
                            : Colors.grey)
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  )),
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
class SixthHover extends GetView<BtnHoverCtrl> {
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
            },
            child: AnimatedContainer(
              margin: EdgeInsets.symmetric(
                  vertical: controller.isHover6.value ? 3 : 0),
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 7,
                        spreadRadius: 5,
                        color: controller.isHover6.value
                            ? Colors.cyan.withOpacity(0.2)
                            : Colors.grey)
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  )),
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
class SeventhHover extends GetView<BtnHoverCtrl> {
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
            },
            child: AnimatedContainer(
              margin: EdgeInsets.symmetric(
                  vertical: controller.isHover7.value ? 3 : 0),
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 7,
                        spreadRadius: 5,
                        color: controller.isHover7.value
                            ? Colors.cyan.withOpacity(0.2)
                            : Colors.grey)
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  )),
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
class EightHover extends GetView<BtnHoverCtrl> {
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
            },
            child: AnimatedContainer(
              margin: EdgeInsets.symmetric(
                  vertical: controller.isHover8.value ? 3 : 0),
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 7,
                        spreadRadius: 5,
                        color: controller.isHover8.value
                            ? Colors.cyan.withOpacity(0.2)
                            : Colors.grey)
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  )),
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