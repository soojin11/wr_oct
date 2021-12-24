import 'package:get/get.dart';
import 'package:wr_ui/main.dart';
import 'package:wr_ui/view/splash/splash_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.SPLASH,
      page: () => SplashView(),
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => Home(),
    ),
  ];
}
