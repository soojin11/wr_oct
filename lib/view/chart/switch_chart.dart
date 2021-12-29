import 'package:get/get.dart';
import 'package:wr_ui/controller/viz_ctrl.dart';
import 'package:wr_ui/view/chart/oes_chart.dart';
import 'package:wr_ui/view/chart/pages/hover_chart/oes_series.dart';
import 'package:wr_ui/view/chart/viz_chart.dart';

class chooseChart extends GetxController {
  RxInt chartNum = 0.obs;
  RxBool chartSide1 = false.obs;
  RxBool chartSide2 = false.obs;
  RxBool chartSide3 = false.obs;
  RxBool chartSide4 = false.obs;
  RxBool chartSide5 = false.obs;
  RxBool chartSide6 = false.obs;
  RxBool chartSide7 = false.obs;
  RxBool chartSide8 = false.obs;
  choose() {
    if (chartNum == 1) {
      chartSide1.value = true;
      chartSide2.value = false;
      chartSide3.value = false;
      chartSide4.value = false;
      chartSide5.value = false;
      chartSide6.value = false;
      chartSide7.value = false;
      chartSide8.value = false;
      return oneHoverChart();
    } else if (chartNum == 2) {
      chartSide1.value = false;
      chartSide2.value = true;
      chartSide3.value = false;
      chartSide4.value = false;
      chartSide5.value = false;
      chartSide6.value = false;
      chartSide7.value = false;
      chartSide8.value = false;
      return twoHoverChart();
    } else if (chartNum == 3) {
      chartSide1.value = false;
      chartSide2.value = false;
      chartSide3.value = true;
      chartSide4.value = false;
      chartSide5.value = false;
      chartSide6.value = false;
      chartSide7.value = false;
      chartSide8.value = false;
      return threeHoverChart();
    } else if (chartNum == 4) {
      chartSide1.value = false;
      chartSide2.value = false;
      chartSide3.value = false;
      chartSide4.value = true;
      chartSide5.value = false;
      chartSide6.value = false;
      chartSide7.value = false;
      chartSide8.value = false;
      return fourHoverChart();
    } else if (chartNum == 5) {
      chartSide1.value = false;
      chartSide2.value = false;
      chartSide3.value = false;
      chartSide4.value = false;
      chartSide5.value = true;
      chartSide6.value = false;
      chartSide7.value = false;
      chartSide8.value = false;
      return fiveHoverChart();
    } else if (chartNum == 6) {
      chartSide1.value = false;
      chartSide2.value = false;
      chartSide3.value = false;
      chartSide4.value = false;
      chartSide5.value = false;
      chartSide6.value = true;
      chartSide7.value = false;
      chartSide8.value = false;
      return sixHoverChart();
    } else if (chartNum == 7) {
      chartSide1.value = false;
      chartSide2.value = false;
      chartSide3.value = false;
      chartSide4.value = false;
      chartSide5.value = false;
      chartSide6.value = false;
      chartSide7.value = true;
      chartSide8.value = false;
      return sevenHoverChart();
    } else if (chartNum == 8) {
      chartSide1.value = false;
      chartSide2.value = false;
      chartSide3.value = false;
      chartSide4.value = false;
      chartSide5.value = false;
      chartSide6.value = false;
      chartSide7.value = false;
      chartSide8.value = true;
      return eightHoverChart();
    }
    return OesChart();
  }

  // choice() {
  //   if (VizCtrl.to.chartNum == 1) {
  //     return VizCtrl.to.vizFirst();
  //   } else if (VizCtrl.to.chartNum == 2) {
  //     return VizCtrl.to.vizSecond();
  //   } else if (VizCtrl.to.chartNum == 3) {
  //     return VizCtrl.to.vizThird();
  //   } else if (VizCtrl.to.chartNum == 4) {
  //     return VizCtrl.to.vizFourth();
  //   } else if (VizCtrl.to.chartNum == 5) {
  //     return VizCtrl.to.vizFifth();
  //   }
  //   return VizChart();
  // }
}
