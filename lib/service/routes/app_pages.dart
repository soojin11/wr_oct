import 'package:get/get.dart';
import 'package:wr_ui/main.dart';
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
}
