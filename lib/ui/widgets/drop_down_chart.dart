import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wr_ui/chart/pages/ADDpage.dart';
import 'package:wr_ui/chart/pages/ALLpage.dart';
import 'package:wr_ui/chart/pages/CUSTOMpage.dart';
import 'package:wr_ui/chart/pages/OESpage.dart';
import 'package:wr_ui/chart/pages/VIpage.dart';
import 'package:wr_ui/controller/drop_down_controller.dart';
import 'package:wr_ui/ui/widgets/drop_down_btn.dart';
import 'package:wr_ui/ui/widgets/pop_up_menu_btn.dart';

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
        Expanded(child: Center(child: Obx(() {
          switch (controller.currentItem.value) {
            // case 0:
            //   return Expanded(
            //     child: Center(
            //       child: Text('ALL '),
            //     ),
            //   );
            // case 1:
            //   return Expanded(
            //     child: Center(
            //       child: Text('OES '),
            //     ),
            //   );
            // case 2:
            //   return Expanded(
            //     child: Center(
            //       child: Text('VI '),
            //     ),
            //   );
            // case 3:
            //   return Expanded(
            //     child: Center(
            //       child: Text('CUSTOM '),
            //     ),
            //   );
            // case 4:
            //   return Expanded(
            //     child: Center(
            //       child: Text('ADD'),
            //     ),
            //   );

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
        })))
      ],
    );
  }
}
