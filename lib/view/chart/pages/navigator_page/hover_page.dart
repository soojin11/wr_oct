import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wr_ui/model/const/style/pallette.dart';
import 'package:wr_ui/view/chart/chart_tabbar.dart';
import 'package:wr_ui/view/chart/pages/hover_chart/hover_func.dart';
import 'package:wr_ui/view/chart/pages/hover_chart/oes_series.dart';

// class Hoverpage extends StatelessWidget {
//   Hoverpage({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return BasePage(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           chartTabBar(),
//           FirstHover(),
//         ],
//       ),
//     );
//   }
// }

// BasePage({required Widget child}) {
//   return Scaffold(
//     body: Container(
//       decoration: BoxDecoration(
//         color: Get.isDarkMode ? wrColors.wrDarkAppBar : Colors.white,
//         boxShadow: [
//           BoxShadow(
//             color:
//                 Get.isDarkMode ? Colors.black26 : Colors.grey.withOpacity(0.2),
//             spreadRadius: 5,
//             blurRadius: 7,
//             offset: Offset(0, 2),
//           ),
//         ],
//         borderRadius: BorderRadius.circular(10),
//       ),
//     ),
//   );
// }

class Hoverpage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Get.isDarkMode ? wrColors.wrDarkAppBar : Colors.white,
          boxShadow: [
            BoxShadow(
              color: Get.isDarkMode
                  ? Colors.black26
                  : Colors.grey.withOpacity(0.2),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 2),
            ),
          ],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            chartTabBar(),
            Expanded(flex: 1, child: oneHoverChart()),
          ],
        ),
      ),
    );
  }
}
