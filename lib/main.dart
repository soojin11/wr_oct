import 'dart:async';
import 'dart:ffi';
import 'dart:io';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wr_ui/controller/drop_down_controller.dart';
import 'package:wr_ui/controller/home_controller.dart';
import 'package:wr_ui/service/dark_white_mode/mode.dart';
import 'package:wr_ui/service/routes/app_pages.dart';
import 'package:wr_ui/setting_content.dart';
import 'package:wr_ui/view/appbar/actions/minimize/window_btn.dart';
import 'package:wr_ui/view/appbar/actions/setting/ini_and_setting.dart';
import 'package:wr_ui/view/appbar/actions/setting/recipe_menu_final.dart';
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
import 'package:wr_ui/view/right_side_menu/log_save.dart';
import 'package:wr_ui/view/right_side_menu/log_screen.dart';
import 'package:wr_ui/view/right_side_menu/save_ini.dart';
import 'package:wr_ui/view/right_side_menu/start_stop.dart';
import 'dart:math' as math;

import 'model/const/style/text.dart';

Future main() async {
  Get.put(OesController());
  Get.put(DialogStorageCtrl());
  Get.put(runErrorStatusController());
  Get.put(StartStopController());
  Get.put(iniController());
  Get.put(CsvController());
  

  Get.put(LogListController());
  Get.put(LogController());
  //Get.put(SettingController());
  Get.put(SettingContnet());
  Get.put(BtnHoverCtrl());
  Get.put(StartStopController());
  // Pointer<Double> getWavelength = calloc<Double>(8);
  //Get.put(iniControllerWithReactive()).writeIni();

  Get.put(chooseChart());
  Get.put(ChartName());

  Get.find<LogListController>().programStart();

   for (var i = 0; i < Get.find<iniController>().OES_Count.value; i++) {
    Get.find<OesController>().chartData.add([]);
  }
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
//  double[] GetWavelength(int spectrometerIndex);

//bool은 Int8
final DynamicLibrary wgsFunction = DynamicLibrary.open("WGSFunction.dll");
late int Function() ocrStart;
late int Function(int a) getBoxcarWidth;
late void Function(int a) testtest;
late void Function(int a) setmsg;
late void Function(int a) test;
late void Function() getMPM2000Component;
late int Function() openAllSpectrometers;
late int Function(int spectrometerIndex, int slot, double val)
    setNonlinearityCofficient;
late void Function() closeAll;
late void Function(int portName) mpmStart;
late int Function() mpmOpen;
late void Function() mpmClose;
late int Function(int spectrometerIndex, int integrationTime)
    setIntegrationTime;
late int Function(int spectrometerIndex, int val) setScansToAverage;
late int Function(int spectrometerIndex, int val) setBoxcarWidth;
late int Function(int spectrometerIndex, int val) setElectricDarkEnable;
late int Function(int spectrometerIndex, int val)
    setNonlinearityCorrectionEnabled;
late int Function(int spectrometerIndex, int val) setTriggerMode;
late int Function(int channelIndex) mpmSetChannel;
late Pointer<Double> Function(int a) getformatSpec;
late Pointer<Double> Function(int a) getWavelength;
List listWavelength = [];
//bool은 Int8

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
  Size get preferredSize => Size.fromHeight(75);
  final themeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Container(
        child: AppBar(automaticallyImplyLeading: false, actions: [
          Container(
            //width: 600,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(width: 10),
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
                appContainer(width: 180, child: Clock()),
                SizedBox(width: 80),
                appContainer(
                  width: 170,
                  child: Text('WR-FreqAI', style: WrText.WrLeadingFont),
                ),
                SizedBox(width: 80),
                appContainer(width: 170, child: RecentRecipeName()),
                SizedBox(width: 100),
                RunErrorStatus(),
                SizedBox(width: 160),
                SetBtn(),
                SizedBox(width: 70),
                GestureDetector(
                  onTap: () {
                    ThemeService().switchTheme();
                    Get.find<LogListController>().cModeChage();
                  },
                  child: Icon(
                    Get.isDarkMode
                        ? Icons.toggle_on_outlined
                        : Icons.toggle_off_outlined,
                    size: 38,
                    color: Get.isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
              ],
            ),
          ),
          Spacer(),
          SizedBox(
            width: 50,
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
  void initState() {
    readConfig();
    Get.find<LogController>().logSave();

    super.initState();
  }

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
                    child: Obx(
                      () => Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10)),
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
                                  child: Get.find<chooseChart>().choose())
                            ],
                          )),
                    ),
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

                  Expanded(
                    flex: 1,
                    child: Container(
                      // color: Colors.amber,
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
                                    style:
                                        Theme.of(context).textTheme.bodyText2),
                              ],
                            ),
                            Divider(
                              indent: 10,
                              endIndent: 10,
                            ),
                            Expanded(
                              child: Container(
                                child: LogList(),
                              ),
                            )
                          ],
                        ),
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
                                ElevatedButton(
                                    onPressed: () {
                                      createDoubleFunction();
                                      printText;
                                    },
                                    child: Text('compute연습'))
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
                        // DataMonitorTest(),
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
                                ExitBtn(),
                                SizedBox(height: 20)
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

appContainer({required double width, required Widget child}) {
  return Container(
      child: Center(child: child),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.blueGrey[600]),
      width: width);
}

// double parseval(double setRandom){
//   double setRandom = math.Random().nextInt(50).toDouble();
//   return setRandom;
// }

// Future<double> fetchVal(double val) async{
//   final random = await val;
//   return compute(parseval, random);
// }
// void runsth(){
//   return print('연습용 ${fetchVal}');
// }

// Future<void> createComputeFunction()async{
//   await compute(computeFunction, "aaaaa");
// }

// static String computeFunction(String url){
//   return
// }

Future<List<FlSpot>> createDoubleFunction() async {
  int value = 760;
  List<FlSpot> val = await compute(doubleFunction, value);
  return val;
}

List<FlSpot> doubleFunction(int value) {
  List<FlSpot> oneData = [];
  for (var i = 0; i < value; i++) {
    oneData.add(FlSpot(i.toDouble(), math.Random().nextInt(50).toDouble()));
  }
  return oneData;
}

void printText() {
  return print('제바라아아라아랑랄 ${createDoubleFunction}');
}
