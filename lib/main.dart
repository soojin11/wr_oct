import 'dart:async';
import 'dart:ffi';
import 'dart:io';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wr_ui/controller/home_controller.dart';
import 'package:wr_ui/model/config/config.dart';
import 'package:wr_ui/service/dark_white_mode/mode.dart';
import 'package:wr_ui/view/appbar/actions/minimize/window_btn.dart';
import 'package:wr_ui/view/appbar/actions/setting/ini_and_setting.dart';
import 'package:wr_ui/view/appbar/leading/clock.dart';
import 'package:wr_ui/view/appbar/leading/recent_recipe_name.dart';
import 'package:wr_ui/view/appbar/leading/run_error_status_mark.dart';
import 'package:wr_ui/view/chart/chart_tabbar.dart';
import 'package:wr_ui/view/chart/oes_chart.dart';
import 'package:wr_ui/view/chart/viz_chart.dart';
import 'package:wr_ui/controller/viz_ctrl.dart';
import 'package:wr_ui/view/right_side_menu/csv_creator.dart';
import 'package:wr_ui/view/right_side_menu/exit_btn.dart';
import 'package:wr_ui/view/right_side_menu/log_save.dart';
import 'package:wr_ui/view/right_side_menu/log_screen.dart';
import 'package:wr_ui/view/right_side_menu/save_ini.dart';
import 'package:wr_ui/view/right_side_menu/start_stop.dart';
import 'controller/oes_ctrl.dart';
import 'model/const/style/text.dart';

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
late int Function() mpmIsSwitching;

List<double> listWavelength = [];

bool runningSignal = false;
RxDouble addVal = 0.0.obs;
File file = File("./setting.json");
String data = file.readAsStringSync();
ConfigWR loadConfig = ConfigWR.fromJson(data);

late int Function(int a) serialConnect;

Future main() async {
  Get.lazyPut(() => iniController());
  Get.put(VizCtrl());
  Get.put(OesController());
  Get.put(runErrorStatusController());
  Get.put(ChartName());
  Get.put(CsvController());
  Get.put(LogListController());
  Get.put(LogController());
  Get.find<LogListController>().programStart();
  // VizCtrl.to.vizList.assignAll([]);
  VizCtrl.to.vizPoints.assignAll([]);
  for (var i = 0; i < 5; i++) {
    // VizCtrl.to.vizChannel[i];
    VizCtrl.to.vizPoints.add(RxList.empty());
    // VizCtrl.to.vizList.add(VizData.init().obs);
    for (var ii = 0; ii < 7; ii++) {
      VizCtrl.to.vizPoints[i].add(RxList.empty());
    }
  }

  for (var i = 0; i < Get.find<iniController>().OES_Count.value; i++) {
    Get.find<OesController>().oesChartData.add([]);
  }

  debugPrint('ConfigWR $loadConfig');
  oesDLLInit();
  runApp(MyApp());

  doWhenWindowReady(() {
    final win = appWindow;
    final initialSize = Size(1920, 1040);
    win.minSize = initialSize;
    win.maxSize = initialSize;
    win.size = initialSize;
    win.alignment = Alignment.center;
    win.title = "WR";
    win.show();
  });

  ///시리얼 포트///
  VizCtrl.to.init();
  OesController.to.init();
}

void log(String str) {
  final String path = "./test.txt";
  File file = File(path);
  String data = '$str \n';
  if (file.existsSync())
    file.writeAsStringSync(data, mode: FileMode.append);
  else
    file.writeAsStringSync(data, mode: FileMode.write);
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
      home: Home(),
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
  Size get preferredSize => Size.fromHeight(50);
  final themeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Container(
      child: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Image.asset(
            'assets/images/CI_nobg.png',
            fit: BoxFit.fitWidth,
          ),
        ),
        leadingWidth: 160,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              alignment: Alignment.center,
              height: 35,
              width: 120,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.blueGrey[100]),
              child: Obx(() => DropdownButton(
                    icon: Icon(
                      Icons.arrow_drop_down,
                      color: Colors.black,
                      size: 35,
                    ),
                    underline: DropdownButtonHideUnderline(child: Container()),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    onChanged: (v) {
                      VizCtrl.to.setSelected(v);
                    },
                    style: TextStyle(
                        fontSize: 23,
                        color: Colors.grey[800],
                        fontWeight: FontWeight.bold),
                    value: VizCtrl.to.selected.value,
                    items: VizCtrl.to.dropItem
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                  )),
            ),
            Tooltip(
              height: 50,
              textStyle: TextStyle(
                fontSize: 15,
                color: Theme.of(context).appBarTheme.foregroundColor,
              ),
              message: 'Current time',
              child: Container(
                alignment: Alignment.center,
                child: Clock(),
                // blur: 20,
                height: 85,
                width: 120,
                color: Colors.blueGrey[600],
              ),
            ),
            // SizedBox(width: 100),
            Container(
              child: Center(
                child: Text(
                  'WR-FreqAI',
                  style: WrText.WrFont,
                ),
              ),
              // blur: 20,
              color: Colors.blueGrey[600],
              height: 85,
              width: 150,
            ),
            // SizedBox(width: 80),
            Tooltip(
              height: 50,
              textStyle: TextStyle(
                fontSize: 15,
                color: Colors.white,
              ),
              message: 'Current chart name',
              child: Container(
                child: Center(
                  child: RecentRecipeName(),
                ),
                // blur: 20,
                color: Colors.blueGrey[600],
                width: 150,
                height: 85,
              ),
            ),
            // SizedBox(width: 80),
            Tooltip(
              height: 50,
              textStyle: TextStyle(
                fontSize: 15,
                color: Colors.white,
              ),
              message: 'Current status',
              child: RunErrorStatus(),
            ),
            // SizedBox(width: 100),
            Tooltip(
              height: 50,
              textStyle: TextStyle(
                fontSize: 15,
                color: Colors.white,
              ),
              message: 'Change settings',
              child: Container(
                width: 180,
                height: 37,
                child: SetBtn(),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.blueGrey[400]),
              ),
            ),
            // SizedBox(width: 60),

            Tooltip(
              height: 50,
              textStyle: TextStyle(
                fontSize: 15,
                color: Colors.white,
              ),
              message:
                  Get.isDarkMode ? 'Change white theme' : 'Change dark theme',
              child: GestureDetector(
                onTap: () {
                  ThemeService().switchTheme();
                  Get.find<LogListController>().cModeChage();
                },
                child: Icon(
                  Get.isDarkMode
                      ? Icons.toggle_on_outlined
                      : Icons.toggle_off_outlined,
                  size: 45,
                  color: Colors.white,
                ),
              ),
            ),
            // SizedBox(width: 50),
          ],
        ),
        actions: [
          WindowButtons(),
        ],
        // SizedBox(width: 60),
      ),
    );
  }
}

class WRbody extends StatefulWidget with WidgetsBindingObserver {
  const WRbody({
    Key? key,
    required this.widget,
  }) : super(key: key);

  final Home widget;

  @override
  State<WRbody> createState() => _WRbodyState();
}

////ini read / write////
class _WRbodyState extends State<WRbody> {
  void initState() {
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
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              chartTabBar(),
                              Expanded(
                                  flex: 1,
                                  child: VizCtrl.to.selected == "OES"
                                      ? OesChart()
                                      : VizCtrl.to.selected == "VIZ"
                                          ? VizChart()
                                          : Container())
                            ],
                          )),
                    ),
                  ),
                )),
          ],
        ),
      ),

      Expanded(
          flex: 1,
          child: Container(
            margin: EdgeInsets.only(right: 5),
            height: 960,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 460,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: 10,
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
                            height: 400,
                            child: LogList(),
                          )
                        ],
                      ),
                    ),
                  ),
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
                                StartStop(),
                              ],
                            ),
                          ),
                        ),
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
                        Padding(
                          padding: const EdgeInsets.all(5.0),
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
                                SizedBox(height: 20),
                                ExitBtn(),
                                SizedBox(height: 20)
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).backgroundColor,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).shadowColor,
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 2),
                ),
              ],
            ),
          ))
    ]);
  }
}

Future<bool> oesDLLInit() async {
  print('in oesInit');
  ocrStart = wgsFunction
      .lookup<NativeFunction<Int8 Function()>>('OCR_Start')
      .asFunction();
  mpmStart = wgsFunction
      .lookup<NativeFunction<Void Function(Int32)>>('MPMStart')
      .asFunction();
  mpmClose = wgsFunction
      .lookup<NativeFunction<Void Function()>>('MPMClose')
      .asFunction();
  mpmOpen = wgsFunction
      .lookup<NativeFunction<Int8 Function()>>('MPMOpen')
      .asFunction();
  closeAll = wgsFunction
      .lookup<NativeFunction<Void Function()>>('CloseAll')
      .asFunction();
  openAllSpectrometers = wgsFunction
      .lookup<NativeFunction<Int32 Function()>>('OpenAllSpectrometers')
      .asFunction();
  setIntegrationTime = wgsFunction
      .lookup<NativeFunction<Int32 Function(Int32, Int32)>>(
          'SetIntegrationTime')
      .asFunction();
  setScansToAverage = wgsFunction
      .lookup<NativeFunction<Int32 Function(Int32, Int32)>>('SetScansToAverage')
      .asFunction();
  setBoxcarWidth = wgsFunction
      .lookup<NativeFunction<Int32 Function(Int32, Int32)>>('SetBoxcarWidth')
      .asFunction();
  setElectricDarkEnable = wgsFunction
      .lookup<NativeFunction<Int32 Function(Int32, Int32)>>(
          'SetElectricDarkEnable')
      .asFunction();
  setNonlinearityCorrectionEnabled = wgsFunction
      .lookup<NativeFunction<Int32 Function(Int32, Int32)>>(
          'SetNonlinearityCorrectionEnabled')
      .asFunction();
  setTriggerMode = wgsFunction
      .lookup<NativeFunction<Int32 Function(Int32, Int32)>>('SetTriggerMode')
      .asFunction();
  getWavelength = wgsFunction
      .lookup<NativeFunction<Pointer<Double> Function(Int32)>>('GetWavelength')
      .asFunction();
  mpmSetChannel = wgsFunction
      .lookup<NativeFunction<Int32 Function(Int32)>>('MPMSetChannel')
      .asFunction();
  mpmIsSwitching = wgsFunction
      .lookup<NativeFunction<Int32 Function()>>('MPMIsSwitching')
      .asFunction();
  return true;
}

int ocrs = 0;
Future<bool> oesInit() async {
  ocrs = ocrStart();
  log('1 $ocrs');
  mpmStart(3);
  log('2');
  mpmClose();
  log('3');
  mpmOpen();
  log('4');
  openAllSpectrometers();
  log('5');
  setIntegrationTime(0, Get.find<iniController>().integrationTime.value * 1000);

  // int gg = setTriggerMode(0, 0);
  Pointer<Double> pdwaveLength = getWavelength(0);
  listWavelength.clear();
  for (var i = 0; i < 2048; i++) {
    listWavelength.add(pdwaveLength[i]);
    Get.find<OesController>().minX.value = listWavelength.first.toDouble();
    Get.find<OesController>().maxX.value = listWavelength.last;
    print('listWavelength?? ' + ' ${listWavelength[i]}');
  }
  print('getWavelength?? ' + ' ${listWavelength.length}');

  mpmSetChannel(0);
  return true;
}

Future<bool> oesClose() async {
  log('c1');

  closeAll();
  log('c2');
  mpmClose();
  return true;
}
