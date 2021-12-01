import 'dart:async';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wr_ui/controller/drop_down_controller.dart';
import 'package:wr_ui/controller/home_controller.dart';
import 'package:wr_ui/ing/data_monitor_class.dart';
import 'package:wr_ui/service/dark_white_mode/mode.dart';
import 'package:wr_ui/service/routes/app_pages.dart';
import 'package:wr_ui/setting_content.dart';
import 'package:wr_ui/view/appbar/actions/minimize/window_btn.dart';
import 'package:wr_ui/view/appbar/actions/setting/recipe_menu_final.dart';
import 'package:wr_ui/view/appbar/actions/setting/setting_menu_final.dart';
import 'package:wr_ui/view/appbar/leading/clock.dart';
import 'package:wr_ui/view/appbar/leading/recent_recipe_name.dart';
import 'package:wr_ui/view/appbar/leading/run_error_status_mark.dart';
import 'package:wr_ui/view/chart/oes_chart.dart';
import 'package:wr_ui/view/chart/pages/hover_chart/hover_func.dart';
import 'package:wr_ui/view/chart/pages/hover_chart/hover_row.dart';
import 'package:wr_ui/view/chart/pages/navigator_page/ADDpage.dart';
import 'package:wr_ui/view/chart/pages/navigator_page/ALLpage.dart';
import 'package:wr_ui/view/chart/pages/navigator_page/CUSTOMpage.dart';
import 'package:wr_ui/view/chart/pages/navigator_page/OESpage.dart';
import 'package:wr_ui/view/chart/pages/navigator_page/VIpage.dart';
import 'package:wr_ui/view/right_side_menu/csv_creator.dart';
import 'package:wr_ui/view/right_side_menu/exit_btn.dart';
import 'package:wr_ui/view/right_side_menu/ini_creator.dart';
import 'package:wr_ui/view/right_side_menu/log_save.dart';
import 'package:wr_ui/view/right_side_menu/log_screen.dart';
import 'package:wr_ui/view/right_side_menu/start_stop.dart';

// @DllImport('OCR.dll')
// abstract class OCR {
//   int OpenAllSpectrometers();
// }

Future main() async {
  await Get.put(iniControllerWithReactive()).writeIni();
  Get.put(iniControllerWithReactive()).readIni();
  // Get.put(DataMonitor());
  // Get.find<DataMonitor>().init();

  // var ocr = FFIOCR();
  // var success = ocr.OpenAllSpectrometers() != 0;
  // if (!success) {
  //   print('ocr monitor fail==>' + '${ocr.OpenAllSpectrometers()}');
  // }
  Get.put(iniControllerWithReactive());
  Get.put(runErrorStatusController());
  Get.put(StartStopController());
  Get.put(CsvController());
  //Get.put(VizController());
  Get.put(OesController());
  Get.put(LogListController());
  Get.put(LogController());
  Get.put(SettingController());
  Get.put(SettingContnet());
  Get.put(BtnHoverCtrl());
  runApp(MyApp());
  doWhenWindowReady(() {
    final win = appWindow;
    final initialSize = Size(1920, 1080);
    win.minSize = initialSize;
    win.maxSize = initialSize;
    win.size = initialSize;
    win.alignment = Alignment.center;
    win.title = "WR";
    win.show();
  });

  if (Get.find<iniControllerWithReactive>().measureStartAtProgStart.value ==
      '1') {
    print('auto start');
    Get.find<OesController>().inactiveBtn.value = true;
    Get.find<OesController>().timer = Timer.periodic(
        Duration(milliseconds: 100),
        Get.find<OesController>().updateDataSource);
    Get.find<OesController>().oneData;
  } else {
    print('manual start');
  }
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: Themes.light,
      darkTheme: Themes.dark,
      themeMode: ThemeService().theme,
      debugShowCheckedModeBanner: false,
      title: 'WR',
      initialBinding: BindingsBuilder(() {
        Get.put(DropDownController());
      }),
      home: Home(),
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: WRappbar(),
      body: WRbody(widget: widget),
    );
  }
}

class WRappbar extends StatelessWidget implements PreferredSizeWidget {
  WRappbar({
    Key? key,
  }) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(70);
  final themeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Container(
        child: AppBar(automaticallyImplyLeading: false, actions: [
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                    onTap: () {
                      () => Get.offAll(Home());
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Image.asset(
                        'assets/images/CI_nobg.png',
                        fit: BoxFit.fitHeight,
                      ),
                    )),
                SizedBox(width: 120),
                VerticalDivider(
                  color: Colors.black.withOpacity(0.5),
                ),
                Clock(),
                VerticalDivider(
                  color: Colors.black.withOpacity(0.5),
                ),
                SizedBox(width: 160),
                VerticalDivider(
                  color: Colors.black.withOpacity(0.5),
                ),
                RecentRecipeName(),
                VerticalDivider(
                  color: Colors.black.withOpacity(0.5),
                ),
                SizedBox(width: 160),
                VerticalDivider(
                  color: Colors.black.withOpacity(0.5),
                ),
                RunErrorStatus(),
                VerticalDivider(
                  color: Colors.black.withOpacity(0.5),
                ),
                SizedBox(width: 160),
                VerticalDivider(
                  color: Colors.black.withOpacity(0.5),
                ),
                SettingMenu(),
                VerticalDivider(
                  color: Colors.black.withOpacity(0.5),
                ),
                SizedBox(width: 160),
                VerticalDivider(
                  color: Colors.black.withOpacity(0.5),
                ),
                GestureDetector(
                  onTap: () {
                    ThemeService().switchTheme();
                  },
                  child: Icon(
                    Get.isDarkMode
                        ? Icons.toggle_on_outlined
                        : Icons.toggle_off_outlined,
                    size: 38,
                    color: Get.isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
                VerticalDivider(
                  color: Colors.black.withOpacity(0.5),
                ),
              ],
            ),
          ),
          Spacer(),
          // dialogBtn(),
          // SettingMenu(),
          // SizedBox(
          //   width: 50,
          // ),
          // GestureDetector(
          //   onTap: () {
          //     ThemeService().switchTheme();
          //   },
          //   child: Padding(
          //     padding: const EdgeInsets.only(left: 20),
          //     child: Icon(
          //       Get.isDarkMode
          //           ? Icons.toggle_on_outlined
          //           : Icons.toggle_off_outlined,
          //       size: 38,
          //       color: Get.isDarkMode ? Colors.white : Colors.black,
          //     ),
          //   ),
          // ),
          // SizedBox(
          //   width: 20,
          // ),

          WindowButtons(),
        ]),
      ),
    );
  }
}

class WRbody extends StatefulWidget {
  const WRbody({
    Key? key,
    required this.widget,
  }) : super(key: key);

  final Home widget;

  @override
  State<WRbody> createState() => _WRbodyState();
}

class _WRbodyState extends State<WRbody> {
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      //////////////////////////차트공간
      Expanded(
        flex: 4,
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  child: Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(10)),
                    //////////////차트 컨테이너 내에 페이지 이동
                    child: MaterialApp(
                      debugShowCheckedModeBanner: false,
                      theme: Themes.light,
                      darkTheme: Themes.dark,
                      initialRoute: '/all',
                      routes: {
                        '/all': (context) => ALLpage(),
                        '/oes': (context) => OESpage(),
                        '/vi': (context) => VIpage(),
                        '/custom': (context) => CUSTOMpage(),
                        '/add': (context) => ADDpage(),
                      },
                    ),
                    //////////////차트 컨테이너 내에 페이지 이동
                  ),
                ),
              ),
            ),
            Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ArrangeHover(),
                ))
          ],
        ),
      ),

      Expanded(
          flex: 1,
          child: Container(
            height: 992,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //////////로그

                  Container(
                    // color: Colors.amber,
                    height: 450,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: 20,
                              ),
                              Text('Log View',
                                  style: Theme.of(context).textTheme.bodyText2),
                            ],
                          ),
                          Divider(
                            indent: 10,
                            endIndent: 10,
                          ),
                          Container(
                            height: 395,
                            child: LogList(),
                          )
                        ],
                      ),
                    ),
                  ),
                  //////////로그
                  //////////스타트스탑리셋
                  Container(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Text(
                                      'Chart Start / Stop',
                                      style:
                                          Theme.of(context).textTheme.bodyText2,
                                    ),
                                  ],
                                ),
                                Divider(
                                  indent: 10,
                                  endIndent: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    StartStop(),
                                  ],
                                ),
                                //////////////스타트스탑리셋
                              ],
                            ),
                          ),
                        ), //////////////파일매니저
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Text('Save File',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2),
                                  ],
                                ),
                                Divider(
                                  indent: 10,
                                  endIndent: 10,
                                ),
                                Center(
                                  child: CSVButton(),
                                ),
                              ],
                            ),
                          ),
                        ),
                        /////////////파일매니저
                        /////////////레시피버튼
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Text('Recipe',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2),
                                  ],
                                ),
                                Divider(
                                  indent: 10,
                                  endIndent: 10,
                                ),
                                RecipeMenu()
                              ],
                            ),
                          ),
                        ),
                        /////////////레시피버튼
                        ////////////나가기
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Text('Exit',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2),
                                  ],
                                ),
                                Divider(
                                  indent: 10,
                                  endIndent: 10,
                                ),
                                ExitBtn()
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                  ////////////나가기
                ],
              ),
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).appBarTheme.foregroundColor,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).shadowColor, //그림자 색
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 2), // 그림자위치 바꾸는거
                ),
              ],
            ),
          ))
    ]);
  }
}
