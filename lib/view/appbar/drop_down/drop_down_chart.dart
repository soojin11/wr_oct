import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wr_ui/controller/drop_down_controller.dart';
import 'package:wr_ui/view/appbar/drop_down/pop_up_menu_btn.dart';
import 'package:wr_ui/view/chart/main_chart.dart';
import 'package:wr_ui/view/chart/pages/ADDpage.dart';
import 'package:wr_ui/view/chart/pages/ALLpage.dart';
import 'package:wr_ui/view/chart/pages/CUSTOMpage.dart';
import 'package:wr_ui/view/chart/pages/OESpage.dart';
import 'package:wr_ui/view/chart/pages/VIpage.dart';

class CahrtDropDown extends GetView<DropDownController> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // DropDownBtn(),
            PopUpMenu(),
            SizedBox(
              width: 20,
            )
          ],
        ),
        Expanded(
          child: Center(
            child: Column(
              children: [
                Obx(
                  () {
                    switch (controller.currentItem.value) {
                      case DropDown.ALL:
                        return ALLpage();
                      case DropDown.OES:
                        return OESpage();

                      case DropDown.VI:
                        return VIpage();

                      case DropDown.CUSTOM:
                        return CUSTOMpage();

                      case DropDown.ADD:
                        return ADDpage();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
