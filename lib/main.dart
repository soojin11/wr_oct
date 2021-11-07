import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wr_ui/controller/drop_down_controller.dart';
import 'package:wr_ui/controller/setting_dialog_controller.dart';
import 'package:wr_ui/service/file_picker.dart';
import 'package:wr_ui/style/pallette.dart';
import 'package:wr_ui/ui/appbar/actions/chart_setting_btn.dart';
import 'package:wr_ui/ui/appbar/actions/device_setting_btn.dart';
import 'package:wr_ui/ui/appbar/drop_down/drop_down_chart.dart';
import 'package:wr_ui/ui/appbar/drop_down/setting_pop_up_menu_btn.dart';
import 'package:wr_ui/ui/appbar/leading/clock.dart';
import 'package:wr_ui/ui/appbar/leading/recent_recipe_name.dart';
import 'package:wr_ui/ui/appbar/return_homepage.dart';
import 'package:wr_ui/ui/appbar/leading/run_error_status_mark.dart';
import 'package:wr_ui/ui/radio_test.dart';
import 'package:wr_ui/ui/right_side_menu/exit_btn.dart';
import 'package:wr_ui/ui/right_side_menu/csv_creator.dart';
import 'package:wr_ui/ui/right_side_menu/ini_creator.dart';
import 'package:wr_ui/ui/appbar/actions/device_setting_page.dart';
import 'package:wr_ui/ui/right_side_menu/start_stop.dart';
import 'package:wr_ui/ui/setting_menu.dart';

Future main() async {
  Get.put(ControllerWithReactive());
  Get.put(iniControllerWithReactive());
  Get.put(SettingController());
  // Get.put(txtControllerWithReactive());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        backgroundColor: Colors.grey[50],
        appBarTheme: AppBarTheme(
          color: wrColors.wrPrimary,
          elevation: 0,
        ),
      ),
      debugShowCheckedModeBanner: false,
      title: 'WR',
      //initialBinding..?
      initialBinding: BindingsBuilder(() {
        Get.put(DropDownController());
      }),
      // theme: ThemeData(
      //   primarySwatch: Colors.blue,
      // ),
      home: Home(),
      initialRoute: '/',
      getPages: [
        GetPage(
          name: '/',
          page: () => Home(),
          transition: Transition.noTransition,
        ),
        GetPage(
          name: '/setting',
          page: () => Settings(),
        )
      ],
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
  const WRappbar({
    Key? key,
  }) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(60.0);
  @override
  Widget build(BuildContext context) {
    return AppBar(
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
              ],
            ),
          ),
          Spacer(),
          // ReturnHomePage(),
          SettingMenu(),
          SizedBox(
            width: 50,
          )
          // DeviceSettingBtn(),
          // ChartSettingBtn(),
        ] //
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
        SizedBox(width: 60),
        Expanded(
          flex: 2,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2), //그림자 색
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 2), // 그림자위치 바꾸는거
                ),
              ],
            ),
            child: CahrtDropDown(),
          ),
        ),

        //////////////////////////차트공간

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
                  child: Column(
                    children: [
                      Text('Mylist 1'),
                      Text('Mylist 2'),
                      Text('Mylist 3'),
                      Text('Mylist 4'),
                      Text('Mylist 5'),
                    ],
                  ),
                ),
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
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              'Start / Stop / Reset',
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
                                    color: Colors.blueGrey[700],
                                    fontWeight: FontWeight.bold,
                                  ),
                                ))
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                width: 200,
                height: 100,
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CSVButton(),
                            iniBtn(),
                            filePickerBtn()
                            // TxtBtn(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: 200,
                height: 150,
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
                child: Center(
                  child: Text('Recipe button'),
                ),
              ),
              ExitBtn()
            ],
          ),
        ),
      ],
    );
  }
  // class ResetBtn extends StatefulWidget {
  // const ResetBtn({Key? key}) : super(key: key);

  // @override
  // State<ResetBtn> createState() => _RefreshBtnState();
// }

// class _RefreshBtnState extends State<ResetBtn> {
  // @override
  // Widget build(BuildContext context) {
  // return Container(
  // child: TextButton.icon(
  // onPressed: () {
  // print('reset!!');
  // Get.toNamed('/');
  // Navigator.pushReplacement(
  // context,
  // MaterialPageRoute(
  // builder: (BuildContext context) => super.widget));
  // },
  // icon: Icon(Icons.refresh),
  // label: Text('Reset'),
  // ),
  // );
  // }
// }
}
