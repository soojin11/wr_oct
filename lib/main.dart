import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wr_ui/chart/main_chart.dart';
import 'package:wr_ui/controller/drop_down_controller.dart';
// import 'package:get/get_navigation/src/routes/default_transitions.dart';
// import 'package:wr_ui/chart/carousel_chart.dart';

import 'package:wr_ui/ui/widgets/drop_down_chart.dart';
import 'package:wr_ui/ui/widgets/clock.dart';
import 'package:wr_ui/ui/widgets/exit_btn.dart';
import 'package:wr_ui/ui/widgets/log_screen.dart';
import 'package:wr_ui/ui/widgets/save_file.dart';
import 'package:wr_ui/ui/widgets/ini_creator.dart';
import 'package:wr_ui/ui/widgets/start_stop.dart';
// import 'package:wr_ui/wr_home_page.dart';

Future main() async {
  Get.put(ControllerWithReactive());
  Get.put(iniControllerWithReactive());
  Get.put(ChartController());
  Get.put(LogListController());
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
          color: Colors.blueGrey,
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
      getPages: [
        GetPage(
          name: '/',
          page: () => Home(),
          transition: Transition.noTransition,
        ),
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
      appBar: AppBar(
          automaticallyImplyLeading: true,
          // backgroundColor: Theme.of(context).backgroundColor,
          leading: Image.asset(
            'assets/images/CI_nobg.png',
            scale: 10,
          ),
          actions: [
            Spacer(),
            Clock(),
            Spacer(),
            Text(
              'ExampleRecipeName',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Spacer(),
            Text('4. Run/Error status'),
            Spacer(),
            Row(
              children: [
                TextButton.icon(
                    onPressed: () {
                      print('setting버튼클릭');
                    },
                    icon: Icon(
                      Icons.settings,
                      color: Colors.white,
                    ),
                    label: Text(
                      'Settings',
                      style: TextStyle(color: Colors.white),
                    ))
                // Icon(Icons.settings),
                // Text('5.Settings'),
              ],
            ),
          ] //
          ),
      body: Row(
        children: [
          //////////////////////////차트공간
          SizedBox(width: 60),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(20),
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
                  ],
                ),
              ),
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
                          Column(
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
                              'Save Buttons',
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
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CSVButton(),
                              iniBtn()
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
      ),
    );
  }
}
