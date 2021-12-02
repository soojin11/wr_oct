import 'package:get/get.dart';
import 'package:wr_ui/view/chart/oes_chart.dart';
import 'package:wr_ui/view/chart/pages/hover_chart/oes_series.dart';

class chooseChart extends GetxController {
  RxInt chartNum = 0.obs;
  choose() {
    if (chartNum <= 1 && chartNum > 0) {
      return oneHoverChart();
    } else if (chartNum <= 2 && chartNum > 1) {
      return twoHoverChart();
    } else if (chartNum <= 3 && chartNum > 2) {
      return threeHoverChart();
    } else if (chartNum <= 4 && chartNum > 3) {
      return fourHoverChart();
    } else if (chartNum <= 5 && chartNum > 4) {
      return fiveHoverChart();
    } else if (chartNum <= 6 && chartNum > 5) {
      return sixHoverChart();
    } else if (chartNum <= 7 && chartNum > 6) {
      return sevenHoverChart();
    } else if (chartNum <= 8 && chartNum > 7) {
      return eightHoverChart();
    }
    return OesChart();
  }
}
