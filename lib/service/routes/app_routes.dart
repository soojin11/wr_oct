part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  static const HOME = _Paths.HOME;
  static const SPLASH = _Paths.SPLASH;
  static const ALL = _Paths.ALL;
  static const OES = _Paths.OES;
  static const VI = _Paths.VI;
  static const CUSTOM = _Paths.CUSTOM;
  static const ADD = _Paths.ADD;
}

abstract class _Paths {
  static const HOME = '/home';
  static const SPLASH = '/splash';
  static const ALL = '/all';
  static const OES = '/oes';
  static const VI = '/vi';
  static const CUSTOM = '/custom';
  static const ADD = '/add';
}
