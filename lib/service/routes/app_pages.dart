import 'package:get/get.dart';
import 'package:wr_ui/main.dart';
import 'package:wr_ui/view/chart/pages/ADDpage.dart';
import 'package:wr_ui/view/chart/pages/ALLpage.dart';
import 'package:wr_ui/view/chart/pages/CUSTOMpage.dart';
import 'package:wr_ui/view/chart/pages/OESpage.dart';
import 'package:wr_ui/view/chart/pages/VIpage.dart';
import 'package:wr_ui/view/splash/splash_binding.dart';
import 'package:wr_ui/view/splash/splash_view.dart';
part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;
  static final routes = [
    GetPage(
      name: _Paths.SPLASH,
      page: () => SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => Home(),
      binding: SplashBinding(),
    ),
  ];
  static const CHART_INITIAL = Routes.ALL;
  static final chart_routes = [
    GetPage(
      name: _Paths.ALL,
      page: () => ALLpage(),
    ),
    GetPage(
      name: _Paths.OES,
      page: () => OESpage(),
    ),
    GetPage(
      name: _Paths.VI,
      page: () => VIpage(),
    ),
    GetPage(
      name: _Paths.CUSTOM,
      page: () => CUSTOMpage(),
    ),
    GetPage(
      name: _Paths.ADD,
      page: () => ADDpage(),
    ),
  ];
}
