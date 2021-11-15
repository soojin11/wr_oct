import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
<<<<<<< HEAD
import 'package:wr_ui/controller/splash_controller.dart';
import 'package:wr_ui/model/const/style/pallette.dart';
=======
import 'package:intl/intl.dart';
import 'package:wr_ui/chart/main_chart.dart';
>>>>>>> F20211029-007
import 'package:wr_ui/controller/drop_down_controller.dart';
import 'package:wr_ui/controller/home_controller.dart';
import 'package:wr_ui/service/dark_white_mode/mode.dart';
import 'package:wr_ui/service/routes/app_pages.dart';
import 'package:wr_ui/view/appbar/actions/minimize/window_btn.dart';
import 'package:wr_ui/view/appbar/actions/setting/device_setting_page.dart';
import 'package:wr_ui/view/appbar/actions/setting/recipe_menu_final.dart';
import 'package:wr_ui/view/appbar/actions/setting/setting_menu_final.dart';

<<<<<<< HEAD
import 'package:wr_ui/view/appbar/leading/clock.dart';
import 'package:wr_ui/view/appbar/leading/recent_recipe_name.dart';
import 'package:wr_ui/view/appbar/leading/run_error_status_mark.dart';
import 'package:wr_ui/view/chart/pages/ADDpage.dart';
import 'package:wr_ui/view/chart/pages/ALLpage.dart';
import 'package:wr_ui/view/chart/pages/CUSTOMpage.dart';
import 'package:wr_ui/view/chart/pages/OESpage.dart';
import 'package:wr_ui/view/chart/pages/VIpage.dart';
import 'package:wr_ui/view/right_side_menu/csv_creator.dart';
import 'package:wr_ui/view/right_side_menu/exit_btn.dart';
import 'package:wr_ui/view/right_side_menu/ini_creator.dart';
import 'package:wr_ui/view/right_side_menu/start_stop.dart';
=======
import 'package:wr_ui/ui/widgets/drop_down_chart.dart';
import 'package:wr_ui/ui/widgets/clock.dart';
import 'package:wr_ui/ui/widgets/exit_btn.dart';
import 'package:wr_ui/ui/widgets/log_screen.dart';
import 'package:wr_ui/ui/widgets/save_file.dart';
import 'package:wr_ui/ui/widgets/ini_creator.dart';
import 'package:wr_ui/ui/widgets/start_stop.dart';

import 'ui/widgets/log_save.dart';
// import 'package:wr_ui/wr_home_page.dart';
>>>>>>> F20211029-007

Future main() async {
  Get.put(ControllerWithReactive());
  Get.put(iniControllerWithReactive());
<<<<<<< HEAD
  Get.find<iniControllerWithReactive>().iniWriteSave();
  Get.find<iniControllerWithReactive>().fileSave;

=======
  Get.put(ChartController());
  Get.put(LogListController());
  Get.put(LogController());
  // Get.put(txtControllerWithReactive());
>>>>>>> F20211029-007
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
  bool _lighttwo = true;
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
        child: AppBar(
            automaticallyImplyLeading: true,
            // backgroundColor: Theme.of(context).backgroundColor,
            leading: TextButton(
              onPressed: () {
                Get.to(() => Home());
              },
              child: Image.asset(
                'assets/images/CI_nobg.png',
                scale: 10,
              ),
            ),
            actions: [
              Container(
                width: 600,
                child: Row(
                  children: [
                    SizedBox(
                      width: 100,
                    ),
                    Clock(),
                    SizedBox(
                      width: 20,
                    ),
<<<<<<< HEAD
                    SizedBox(
                      width: 20,
                    ),
                    RecentRecipeName(),
                    SizedBox(
                      width: 20,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    RunErrorStatus(),
=======
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Expanded(child: CahrtDropDown()),
                    Expanded(
                      flex: 2,
                      child: MainChart(),
                    ),
                    SizedBox(height: 20),
                    // Expanded(
                    //     flex: 1,
                    //     child: GridView.count(
                    //       crossAxisSpacing: 10,
                    //       crossAxisCount: 8,
                    //       shrinkWrap: true,
                    //       children: List.generate(8, (index) => MainChart()),
                    //     )
                    //     // ChartPage(),
                    //     ),
>>>>>>> F20211029-007
                  ],
                ),
              ),
              Spacer(),
              // ReturnHomePage(),

              SettingMenu(),
              SizedBox(
                width: 50,
              ),

              GestureDetector(
                onTap: () {
                  ThemeService().switchTheme();
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Icon(
                      Get.isDarkMode
                          ? Icons.toggle_off_outlined
                          : Icons.toggle_on_outlined,
                      size: 40),
                ),
              ),
              SizedBox(
                width: 20,
              ),
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
    return Row(
      children: [
        //////////////////////////차트공간

        Expanded(
          flex: 4,
          child: Padding(
            padding: const EdgeInsets.only(top: 10.0, bottom: 10, left: 10),
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2), //그림자 색
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 2), // 그림자위치 바꾸는거
                  ),
                ],
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10)),
                //////////////차트 컨테이너 내에 페이지 이동
                child: MaterialApp(
                  debugShowCheckedModeBanner: true,
                  theme: ThemeData(
                      textTheme: TextTheme(
                        bodyText2: TextStyle(color: Colors.black),
                      ),
                      scaffoldBackgroundColor: Colors.transparent),
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
                // CahrtDropDown(),
              ),
            ),
          ),
        ),

<<<<<<< HEAD
        //////////////////////////차트공간

        ///////////////////////////오른쪽메뉴부분
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              child: Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //////////로그
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
                                  'Log View',
                                  style: TextStyle(
                                    color: Colors.blueGrey[800],
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Divider(
                              indent: 10,
                              endIndent: 10,
                            ),
                            Text('Mylist 1'),
                            Text('Mylist 2'),
                            Text('Mylist 3'),
                            Text('Mylist 4'),
                            Text('Mylist 5'),
                          ],
                        ),
=======
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 200,
                  decoration: BoxDecoration(
                    color: Colors.grey[40]?.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2), //그림자 색
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 2), // 그림자위치 바꾸는거
                          ),
                        ],
                      ),
                      child: LogList()),
                ),
                Container(
                  width: 200,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.grey[40]?.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2), //그림자 색
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 2), // 그림자위치 바꾸는거
                          ),
                        ],
>>>>>>> F20211029-007
                      ),
                    ),
                    //////////로그
                    //////////스타트스탑리셋
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
<<<<<<< HEAD
                                Text(
                                  'Start / Stop / Reset',
                                  style: TextStyle(
                                    color: Colors.blueGrey[800],
                                    fontWeight: FontWeight.bold,
=======
                              ),
                            ],
                          ),
                          Divider(
                            indent: 10,
                            endIndent: 10,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              StartStop(),
                              TextButton.icon(
                                  onPressed: () {
                                    Get.find<LogListController>()
                                        .clickedReset();
                                    Get.find<LogController>().loglist.add(
                                        '[Event Trigger] ${DateTime.now()}  :  Reset button is pressed' +
                                            '\n');
                                    print('reset!!');
                                    // Get.toNamed('/');
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            super.widget,
                                      ),
                                    );
                                  } // super.dispose();
                                  ,
                                  icon: Icon(
                                    Icons.refresh,
                                    color: Colors.blueGrey[700],
>>>>>>> F20211029-007
                                  ),
                                ),
                              ],
                            ),
                            Divider(
                              indent: 10,
                              endIndent: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                StartStop(),
                                TextButton.icon(
                                    onPressed: () {
                                      print('reset!!');
                                      // Get.toNamed('/');
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              super.widget,
                                        ),
                                      );
                                    } // super.dispose();
                                    ,
                                    icon: Icon(
                                      Icons.refresh,
                                      color: Colors.blueGrey[700],
                                    ),
                                    label: Text(
                                      'Reset',
                                      style: TextStyle(
                                        color: wrColors.wrPrimary,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ))
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
                                Text(
                                  'File Manager',
                                  style: TextStyle(
                                    color: Colors.blueGrey[800],
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Divider(
                              indent: 10,
                              endIndent: 10,
                            ),
                            Center(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  CSVButton(),
                                  iniBtn(),
                                  // TxtBtn(),
                                ],
                              ),
                            ),
                          ],
                        ),
<<<<<<< HEAD
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
                                Text(
                                  'Recipe',
                                  style: TextStyle(
                                    color: Colors.blueGrey[800],
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Divider(
                              indent: 10,
                              endIndent: 10,
                            ),
                            RecipeMenu()
                          ],
=======
                        Divider(
                          indent: 10,
                          endIndent: 10,
                        ),
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CSVButton(),
                              iniBtn()
                              // TxtBtn(),
                            ],
                          ),
>>>>>>> F20211029-007
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
                                Text(
                                  'Exit',
                                  style: TextStyle(
                                    color: Colors.blueGrey[800],
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
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
                    )
                    ////////////나가기
                  ],
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2), //그림자 색
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 2), // 그림자위치 바꾸는거
                  ),
                ],
              ),
            ),
          ),
        ),
        ///////////////////////////오른쪽메뉴부분
      ],
    );
  }
}
