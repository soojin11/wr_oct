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
import 'package:wr_ui/ui/widgets/save_file.dart';
import 'package:wr_ui/ui/widgets/ini_creator.dart';
import 'package:wr_ui/ui/widgets/start_stop.dart';
// import 'package:wr_ui/wr_home_page.dart';

Future main() async {
  Get.put(ControllerWithReactive());
  Get.put(iniControllerWithReactive());
  // Get.put(txtControllerWithReactive());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(backgroundColor: Colors.grey[50]),
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
          leading: Image.asset(
            'assets/images/CI_nobg.png',
            scale: 10,
          ),
          actions: [
            Spacer(),
            Clock(),
            Spacer(),
            Text('3.레시피네임'),
            Spacer(),
            Text('4. Run/Error status'),
            Spacer(),
            Row(
              children: [
                Icon(Icons.settings),
                Text('5.Settings'),
              ],
            ),
          ] //
          ),
      body: Row(
        children: [
          //////////////////////////차트공간
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Expanded(child: CahrtDropDown()),
                Expanded(
                  flex: 2,
                  child: ChartPage(),
                ),
                SizedBox(height: 20),
                Expanded(
                    flex: 1,
                    child: GridView.count(
                      crossAxisSpacing: 10,
                      crossAxisCount: 8,
                      shrinkWrap: true,
                      children: List.generate(8, (index) => ChartPage()),
                    )
                    // ChartPage(),
                    ),
              ],
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
                    borderRadius: BorderRadius.circular(20),
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
                Container(
                  width: 200,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.grey[40]?.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'Start / Stop / Reset',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            StartStop(),
                            TextButton(
                              onPressed: () {
                                // super.dispose();
                                print('reset!!');
                                // Get.toNamed('/');
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        super.widget,
                                  ),
                                );
                              },
                              child: Icon(Icons.refresh),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: 200,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.grey[40]?.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'Save Buttons',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Center(
                        child: Row(
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
                Text('Recipe button'),
                ExitBtn()
              ],
            ),
          ),
        ],
      ),
    );
  }
}
