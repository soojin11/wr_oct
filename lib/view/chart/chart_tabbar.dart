import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wr_ui/controller/viz_ctrl.dart';
import 'package:wr_ui/model/const/style/pallette.dart';
import 'package:wr_ui/view/appbar/leading/recent_recipe_name.dart';
import 'package:wr_ui/view/chart/switch_chart.dart';
import 'package:wr_ui/view/right_side_menu/save_ini.dart';
import 'oes_chart.dart';

class chartTabBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Obx(() => VizCtrl.to.selected == "OES"
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
                Container(
                    padding:
                        EdgeInsets.only(right: 40, left: 40, top: 5, bottom: 5),
                    width: 1200,
                    decoration: BoxDecoration(
                        color: Colors.blueGrey.withOpacity(0.1),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text('Oes_1'),
                              Obx(
                                () => Switch(
                                  value:
                                      Get.find<OesController>().checkVal1.value,
                                  onChanged: (e) {
                                    Get.find<OesController>().checkVal1.value =
                                        e;
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
                                  value:
                                      Get.find<OesController>().checkVal2.value,
                                  onChanged: (e) {
                                    Get.find<OesController>().checkVal2.value =
                                        e;
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
                                  value:
                                      Get.find<OesController>().checkVal3.value,
                                  onChanged: (e) {
                                    Get.find<OesController>().checkVal3.value =
                                        e;
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
                                  value:
                                      Get.find<OesController>().checkVal4.value,
                                  onChanged: (e) {
                                    Get.find<OesController>().checkVal4.value =
                                        e;
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
                                  value:
                                      Get.find<OesController>().checkVal5.value,
                                  onChanged: (e) {
                                    Get.find<OesController>().checkVal5.value =
                                        e;
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
                                  value:
                                      Get.find<OesController>().checkVal6.value,
                                  onChanged: (e) {
                                    Get.find<OesController>().checkVal6.value =
                                        e;
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
                                  value:
                                      Get.find<OesController>().checkVal7.value,
                                  onChanged: (e) {
                                    Get.find<OesController>().checkVal7.value =
                                        e;
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
                                  value:
                                      Get.find<OesController>().checkVal8.value,
                                  onChanged: (e) {
                                    Get.find<OesController>().checkVal8.value =
                                        e;
                                  },
                                ),
                              ),
                            ],
                          ),
                        ]))
              ]))
        : VizCtrl.to.selected == "VIZ"
            ? Container(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            VizCtrl.to.vizCheck1.value = true;
                            VizCtrl.to.vizCheck2.value = true;
                            VizCtrl.to.vizCheck3.value = true;
                            VizCtrl.to.vizCheck4.value = true;
                            VizCtrl.to.vizCheck5.value = true;
                            Get.find<ChartName>().chartName.value = 'ALL';

                            // VizCtrl.to.selectVizChannel.value = [
                            //   true,
                            //   true,
                            //   true,
                            //   true,
                            //   true,
                            // ];
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
                      Container(
                        padding: EdgeInsets.only(
                            right: 40, left: 40, top: 5, bottom: 5),
                        width: 500,
                        decoration: BoxDecoration(
                            color: Colors.blueGrey.withOpacity(0.1),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Text('VIZ_1'),
                                Obx(
                                  () => Switch(
                                    value: VizCtrl.to.vizCheck1.value,
                                    onChanged: (e) {
                                      VizCtrl.to.vizCheck1.value = e;
                                    },
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text('VIZ_2'),
                                Obx(
                                  () => Switch(
                                    value: VizCtrl.to.vizCheck2.value,
                                    onChanged: (e) {
                                      VizCtrl.to.vizCheck2.value = e;
                                    },
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text('VIZ_3'),
                                Obx(
                                  () => Switch(
                                    value: VizCtrl.to.vizCheck3.value,
                                    onChanged: (e) {
                                      VizCtrl.to.vizCheck3.value = e;
                                    },
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text('VIZ_4'),
                                Obx(
                                  () => Switch(
                                    value: VizCtrl.to.vizCheck4.value,
                                    onChanged: (e) {
                                      VizCtrl.to..vizCheck4.value = e;
                                    },
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text('VIZ_5'),
                                Obx(
                                  () => Switch(
                                    value: VizCtrl.to.vizCheck5.value,
                                    onChanged: (e) {
                                      VizCtrl.to.vizCheck5.value = e;
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                          padding: EdgeInsets.only(
                              right: 40, left: 40, top: 5, bottom: 5),
                          width: 700,
                          decoration: BoxDecoration(
                              color: Colors.blueGrey.withOpacity(0.1),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              )
                            ],
                          ))
                    ]),
              )
            : Container());
  }
}
