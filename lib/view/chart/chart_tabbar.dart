import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wr_ui/model/const/style/pallette.dart';
import 'package:wr_ui/view/appbar/leading/recent_recipe_name.dart';
import 'package:wr_ui/view/chart/switch_chart.dart';

import 'oes_chart.dart';
// import 'package:wr_ui/view/chart/pages/navigator_page/ADDpage.dart';
// import 'package:wr_ui/view/chart/pages/navigator_page/ALLpage.dart';
// import 'package:wr_ui/view/chart/pages/navigator_page/CUSTOMpage.dart';
// import 'package:wr_ui/view/chart/pages/navigator_page/OESpage.dart';
// import 'package:wr_ui/view/chart/pages/navigator_page/VIpage.dart';

class chartTabBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Obx(() => Get.find<OesController>().isOes.value
        ? Container(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      Get.find<chooseChart>().chartNum.value = 0;
                      Get.find<OesController>().checkVal1.value = true;
                      Get.find<OesController>().checkVal2.value = true;
                      Get.find<OesController>().checkVal3.value = true;
                      Get.find<OesController>().checkVal4.value = true;
                      Get.find<OesController>().checkVal5.value = true;
                      Get.find<OesController>().checkVal6.value = true;
                      Get.find<OesController>().checkVal7.value = true;
                      Get.find<OesController>().checkVal8.value = true;
                      Get.find<ChartName>().chartName.value = 'ALL';
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.blueGrey,
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 6.0, right: 6.0, top: 4, bottom: 4),
                        child: Text(
                          '  Show ALL  ',
                          style: TextStyle(
                              fontSize: 20,
                              color: wrColors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
                Column(
                  children: [
                    Text('Oes_1'),
                    Obx(
                      () => Switch(
                        value: Get.find<OesController>().checkVal1.value,
                        onChanged: (e) {
                          Get.find<OesController>().checkVal1.value = e;
                        },
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text('Oes_2'),
                    Obx(
                      () => Switch(
                        value: Get.find<OesController>().checkVal2.value,
                        onChanged: (e) {
                          Get.find<OesController>().checkVal2.value = e;
                        },
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text('Oes_3'),
                    Obx(
                      () => Switch(
                        value: Get.find<OesController>().checkVal3.value,
                        onChanged: (e) {
                          Get.find<OesController>().checkVal3.value = e;
                        },
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text('Oes_4'),
                    Obx(
                      () => Switch(
                        value: Get.find<OesController>().checkVal4.value,
                        onChanged: (e) {
                          Get.find<OesController>().checkVal4.value = e;
                        },
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text('Oes_5'),
                    Obx(
                      () => Switch(
                        value: Get.find<OesController>().checkVal5.value,
                        onChanged: (e) {
                          Get.find<OesController>().checkVal5.value = e;
                        },
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text('Oes_6'),
                    Obx(
                      () => Switch(
                        value: Get.find<OesController>().checkVal6.value,
                        onChanged: (e) {
                          Get.find<OesController>().checkVal6.value = e;
                        },
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text('Oes_7'),
                    Obx(
                      () => Switch(
                        value: Get.find<OesController>().checkVal7.value,
                        onChanged: (e) {
                          Get.find<OesController>().checkVal7.value = e;
                        },
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text('Oes_8'),
                    Obx(
                      () => Switch(
                        value: Get.find<OesController>().checkVal8.value,
                        onChanged: (e) {
                          Get.find<OesController>().checkVal8.value = e;
                        },
                      ),
                    ),
                  ],
                ),
              ]))
        : Container(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                Column(
                  children: [
                    Text('VIZ_1'),
                    Obx(
                      () => Switch(
                        value: Get.find<OesController>().checkVal7.value,
                        onChanged: (e) {
                          Get.find<OesController>().checkVal7.value = e;
                        },
                      ),
                    ),
                  ],
                ),
              ])));
  }
}
