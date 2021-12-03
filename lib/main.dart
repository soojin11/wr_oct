import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wr_ui/controller/drop_down_controller.dart';
import 'package:wr_ui/controller/home_controller.dart';
import 'package:wr_ui/ing/data%20monitor.dart';
import 'package:wr_ui/service/dark_white_mode/mode.dart';
import 'package:wr_ui/service/routes/app_pages.dart';
import 'package:wr_ui/setting_content.dart';
import 'package:wr_ui/view/appbar/actions/minimize/window_btn.dart';
import 'package:wr_ui/view/appbar/actions/setting/ini_and_setting_final_final.dart';
import 'package:wr_ui/view/appbar/actions/setting/recipe_menu_final.dart';
import 'package:wr_ui/view/appbar/actions/setting/setting_menu_final.dart';
import 'package:wr_ui/view/appbar/leading/clock.dart';
import 'package:wr_ui/view/appbar/leading/recent_recipe_name.dart';
import 'package:wr_ui/view/appbar/leading/run_error_status_mark.dart';
import 'package:wr_ui/view/chart/chart_tabbar.dart';
import 'package:wr_ui/view/chart/oes_chart.dart';
import 'package:wr_ui/view/chart/pages/hover_chart/hover_func.dart';
import 'package:wr_ui/view/chart/pages/hover_chart/hover_row.dart';
import 'package:wr_ui/view/chart/switch_chart.dart';
import 'package:wr_ui/view/right_side_menu/csv_creator.dart';
import 'package:wr_ui/view/right_side_menu/exit_btn.dart';
import 'package:wr_ui/view/right_side_menu/ini_creator.dart';
import 'package:wr_ui/view/right_side_menu/log_save.dart';
import 'package:wr_ui/view/right_side_menu/log_screen.dart';
import 'package:wr_ui/view/right_side_menu/start_stop.dart';

//final DynamicLibrary wgsFunction = DynamicLibrary.open("WGSFunction.dll");
late int Function() ocrStart;
late int Function(int a) getBoxcarWidth;
late void Function(int a) testtest;
late void Function(int a) setmsg;
late void Function(int a) test;
late void Function() getMPM2000Component;
late void Function() SetIntegrationTime;
String portName = 'RS-232';
late int Function() OpenAllSpectrometers;
late int Function(int spectrometerIndex, int slot, double val)
    setNonlinearityCofficient;
late void Function() closeAll;
//bool은 Int8
Future main() async {
  ///////////app start
  // ocrStart = wgsFunction
  //     .lookup<NativeFunction<Int8 Function()>>('OCR_Start')
  //     .asFunction();
  // int ocrs = ocrStart();
  // print('ocrStart??' + '${ocrs}');

  // OpenAllSpectrometers = wgsFunction
  //     .lookup<NativeFunction<Int8 Function()>>('OpenAllSpectrometers')
  //     .asFunction();
  // int openallspectro = OpenAllSpectrometers();
  // print('openallspectro??' + '$openallspectro');

  //////////app start
  Get.put(OesController(), permanent: true);
  Get.put(DialogStorageCtrl(), permanent: true);
  Get.put(DialogStorageCtrl());
  Get.put(runErrorStatusController());
  Get.put(StartStopController());
  Get.put(CsvController());

  Get.put(LogListController());
  Get.put(LogController());
  Get.put(SettingController());
  Get.put(SettingContnet());
  Get.put(BtnHoverCtrl());
  Get.put(iniControllerWithReactive()).writeIni();
  
  Get.put(chooseChart());
  runApp(MyApp());
  //OES Check [begin]
  // if (Get.find<DialogStorageCtrl>().OES_Simulation.value == 1) {
  //   Get.find<DialogStorageCtrl>().bOESConnect.value = true;
  //   print('bOESConnect = true');
  // } else if (Get.find<DialogStorageCtrl>().OES_Count.value <= 0) {
  //   Get.find<DialogStorageCtrl>().bOESConnect.value = true;
  //   print('bOESConnect = true');
  // } else // oes simulation 상태가 아니고, 디바이스 카운트가 0보다 크다.
  // {
  //   print('bOESConnect = OES_Connect(); & c++ 접속 요청');
  // }
//OES Check [end]
//VI Check [begin]
  if (Get.find<DialogStorageCtrl>().VI_Simulation.value == 1) {
    Get.find<DialogStorageCtrl>().bVIConnect.value = true;
    print('bVIConnect = true');
  } else if (Get.find<DialogStorageCtrl>().VI_Count.value <= 0) {
    Get.find<DialogStorageCtrl>().bVIConnect.value = true;
    print('bVIConnect = true');
  } else // vi simulation 상태가 아니고, 디바이스 카운트가 0보다 크다.
  {
    print(' bVIConnect = VI_Connect(); // c++ 접속 요청');
  }
//VI Check [end]
// if (
//   Get.find<DialogStorageCtrl>().OES_Simulation.value==1 && Get.find<DialogStorageCtrl>().VI_Simulation.value==1

//   )
// {
//    print('Status = "SIM"');
// }
// else
// {
//    if (true == bOESConnect && true == bVIConnect)
//    {
//       Status = "RUN"
//    }
//    else
//    {
//       Status = "Error"
//    }
// }
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

  // ocrStart11 =
  //     wgsTest.lookup<NativeFunction<Int8 Function()>>('OCR_Start').asFunction();
  // int aa = ocrStart11();
  // print('ocrStart??' + '$aa');
  // setmsg = wgsTest
  //     .lookup<NativeFunction<Void Function(Int32)>>('setmsg')
  //     .asFunction();
  // setmsg(2);
  // print('setmsg??' + '${setmsg.toString()}');
  // test =
  //     wgsTest.lookup<NativeFunction<Void Function(Int32)>>('test').asFunction();
  // test(1);
  if (Get.find<DialogStorageCtrl>().measureStartAtProgStart == '1') {
    Get.find<OesController>().inactiveBtn.value = true;
    Get.find<OesController>().timer = Timer.periodic(
        Duration(milliseconds: 100),
        Get.find<OesController>().updateDataSource);
    Get.find<OesController>().oneData;
  } else {
    print('ini가 1이 아님');
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
            //width: 600,
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
                SetBtn(),
                // SettingMenu(),
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
                    
                    child: 
                    // MaterialApp(
                    //   debugShowCheckedModeBanner: false,
                    //   theme: Themes.light,
                    //   darkTheme: Themes.dark,
                    //   initialRoute: '/all',
                    //   routes: {
                    //     '/all': (context) => ALLpage(),
                    //     '/oes': (context) => OESpage(),
                    //     '/vi': (context) => VIpage(),
                    //     '/custom': (context) => CUSTOMpage(),
                    //     '/add': (context) => ADDpage(),
                    //   },
                    // ),
                    Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              chartTabBar(),
                              Expanded(
                                  flex: 1,
                                  child: OesChart())
                            ],
                  )),
                
              ),
            )),
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
                        //dll test
                        DataMonitorTest(),
                        //dll test
                        /////////////레시피버튼

                        Visibility(
                          visible: false,
                          child: Padding(
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
