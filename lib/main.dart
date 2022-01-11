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
    //VizCtrl.to.vizChannel[i];
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

  ///시리얼 포트///
  VizCtrl.to.init();
  VizCtrl.to.startSerial();
  for (var i = 0; i < 5; i++) {
    print('열렸나? ${VizCtrl.to.vizChannel[i].port.isOpen}');
  }
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
  Size get preferredSize => Size.fromHeight(65);
  final themeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Container(
        child: AppBar(automaticallyImplyLeading: false, actions: [
          Padding(
            padding: const EdgeInsets.only(top: 6.0),
            child: Container(
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
                  SizedBox(width: 100),
                  Tooltip(
                    height: 50,
                    textStyle: TextStyle(
                      fontSize: 15,
                      color: Theme.of(context).appBarTheme.foregroundColor,
                    ),
                    message: 'Current time',
                    child: Container(
                      child: Clock(),
                      // blur: 20,
                      width: 120,
                      color: Colors.blueGrey[600],
                    ),
                  ),
                  SizedBox(width: 100),
                  Container(
                    child: Center(
                      child: Text(
                        'WR-FreqAI',
                        style: WrText.WrFont,
                      ),
                    ),
                    // blur: 20,
                    color: Colors.blueGrey[600],
                    width: 150,
                    height: 85,
                  ),
                  SizedBox(width: 80),
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
                  SizedBox(width: 80),
                  Tooltip(
                    height: 50,
                    textStyle: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                    ),
                    message: 'Current status',
                    child: RunErrorStatus(),
                  ),
                  SizedBox(width: 100),
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
                  SizedBox(width: 60),
                  Container(
                    padding: EdgeInsets.only(left: 20),
                    height: 35,
                    width: 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.blueGrey[50]),
                    child: Obx(() => DropdownButton(
                          underline:
                              DropdownButtonHideUnderline(child: Container()),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          onChanged: (v) {
                            VizCtrl.to.setSelected(v);
                          },
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.grey[800],
                              fontWeight: FontWeight.bold),
                          value: VizCtrl.to.selected.value,
                          items: VizCtrl.to.dropItem
                              .map((e) =>
                                  DropdownMenuItem(value: e, child: Text(e)))
                              .toList(),
                        )),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 60),
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
                color: Get.isDarkMode ? Colors.white : Colors.black,
              ),
            ),
          ),
          SizedBox(
            width: 50,
          ),
          WindowButtons(),
        ]),
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
            height: 992,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 510,
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
                            height: 430,
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
                                ],
                              ),
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
              color: Theme.of(context).appBarTheme.foregroundColor,
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

appContainer({required double width, required Widget child}) {
  return Container(
      child: Center(child: child),
      decoration: BoxDecoration(
        color: Colors.blueGrey[600],
      ),
      width: width,
      height: 85);
}

Future<void> oesInit() async {
  print('in oesInit');
  log('1');

  ocrStart = wgsFunction
      .lookup<NativeFunction<Int8 Function()>>('OCR_Start')
      .asFunction();
  log('2 $ocrStart');
  if (ocrStart == 0) {
    saveLog();
    Get.find<LogController>()
        .loglist
        .add('${logfileTime()} ocrstart 1 $ocrStart' + '\n');
  }
  log('3');
  final int ocrs = ocrStart();
  log('4 $ocrs');
  if (ocrs == 0) {
    Get.find<LogController>()
        .loglist
        .add('${logfileTime()} ocrstart 2 $ocrs' + '\n');
  }
  print('ocrStart??' + ' ${ocrs}');
  log('5');
  mpmStart = wgsFunction
      .lookup<NativeFunction<Void Function(Int32)>>('MPMStart')
      .asFunction();
//포트 번호
  mpmStart(3);
  log('6');
  print('mpmstart?? $mpmStart');

  mpmClose = wgsFunction
      .lookup<NativeFunction<Void Function()>>('MPMClose')
      .asFunction();
  log('7');
  mpmClose();
  print('mpmClose??');
  mpmOpen = wgsFunction
      .lookup<NativeFunction<Int8 Function()>>('MPMOpen')
      .asFunction();
  print('mpmOpen??');
  int intMpmOpen = mpmOpen();
  print('intMpmOpen??');
  closeAll = wgsFunction
      .lookup<NativeFunction<Void Function()>>('CloseAll')
      .asFunction();
  // closeAll();
  print('closeAll??');
  log('8');
  openAllSpectrometers = wgsFunction
      .lookup<NativeFunction<Int32 Function()>>('OpenAllSpectrometers')
      .asFunction();
  print('openAllSpectrometers??');
  int bb = openAllSpectrometers();
  print('bb??');
  setIntegrationTime = wgsFunction
      .lookup<NativeFunction<Int32 Function(Int32, Int32)>>(
          'SetIntegrationTime')
      .asFunction();
  log('9');
  print(
      'setIntegrationTime?? ${Get.find<iniController>().integrationTime.value}');
  int cc = setIntegrationTime(
      0, Get.find<iniController>().integrationTime.value * 1000);
  log('10');
  print('intgration???  ${Get.find<iniController>().integrationTime.value}');
  print('plusTime???  ${Get.find<iniController>().plusTime.value}');
  setScansToAverage = wgsFunction
      .lookup<NativeFunction<Int32 Function(Int32, Int32)>>('SetScansToAverage')
      .asFunction();
  log('11');
  int dd = setScansToAverage(0, 1);

  print('setScansToAverage?? ' + ' $dd');
  setBoxcarWidth = wgsFunction
      .lookup<NativeFunction<Int32 Function(Int32, Int32)>>('SetBoxcarWidth')
      .asFunction();

  int ss = setBoxcarWidth(0, 0);

  print('setBoxCarWidth?? ' + '$ss');
  setElectricDarkEnable = wgsFunction
      .lookup<NativeFunction<Int32 Function(Int32, Int32)>>(
          'SetElectricDarkEnable')
      .asFunction();

  int rr = setElectricDarkEnable(0, 0);

  print('setElectricDarkEnable?? ' + '$rr');
  setNonlinearityCorrectionEnabled = wgsFunction
      .lookup<NativeFunction<Int32 Function(Int32, Int32)>>(
          'SetNonlinearityCorrectionEnabled')
      .asFunction();

  int ee = setNonlinearityCorrectionEnabled(0, 0);

  print('setNonlinearityCorrectionEnabled?? ' + ' $ee');
  setTriggerMode = wgsFunction
      .lookup<NativeFunction<Int32 Function(Int32, Int32)>>('SetTriggerMode')
      .asFunction();

  int gg = setTriggerMode(0, 0);

  print('setTriggerMode?? ' + ' $gg');

  getWavelength = wgsFunction
      .lookup<NativeFunction<Pointer<Double> Function(Int32)>>('GetWavelength')
      .asFunction();
  Pointer<Double> pdwaveLength = getWavelength(0);
  for (var i = 0; i < 2048; i++) {
    // OesController.to.oesData[i].xVal.add(pdwaveLength[i]);
    listWavelength.add(pdwaveLength[i]);
    Get.find<OesController>().minX.value = listWavelength.first.toDouble();
    Get.find<OesController>().maxX.value = listWavelength.last;
    print('listWavelength?? ' + ' ${listWavelength[i]}');
  }

  print('getWavelength?? ' + ' ${listWavelength.length}');

  mpmSetChannel = wgsFunction
      .lookup<NativeFunction<Int32 Function(Int32)>>('MPMSetChannel')
      .asFunction();

  int rrr = mpmSetChannel(0);

  print('mpmsetChannel?? ' + ' $rrr');
  mpmIsSwitching = wgsFunction
      .lookup<NativeFunction<Int32 Function()>>('MPMIsSwitching')
      .asFunction();
}
