import 'package:fluent_ui/fluent_ui.dart';
import 'package:ini/ini.dart';

import 'package:wr_ui/ui/widgets/clock.dart';
import 'package:wr_ui/ui/widgets/exit_btn.dart';
import 'package:wr_ui/ui/widgets/reset_btn.dart';
// import 'package:wr_ui/ui/widgets/log.dart';
// import 'package:wr_ui/ui/widgets/reset_btn.dart';
import 'package:wr_ui/ui/widgets/save_file.dart';
import 'package:wr_ui/ui/widgets/start_stop.dart';
import 'package:wr_ui/ui/widgets/ini_creator.dart';
import 'package:wr_ui/ui/widgets/window_btn.dart';

import '../chart/chart_page.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);
//나중에 스테이트리스로 바꿀것..

  @override
  Widget build(BuildContext context) {
    return FluentApp(
        debugShowCheckedModeBanner: false,
        title: 'WR_OCT',
        theme: ThemeData(),
        darkTheme: ThemeData(),
        home: Page()
        //////////////////밑에거 수정 전 코드
        //   child: Scaffold(

        //     body: Column(
        //       children: [
        //         Row(
        //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //           children: [
        //             Image.asset(
        //               'assets/images/CI_nobg.png',
        //               scale: 15,
        //             ),
        //             Clock(),
        //             Text('3.프로그램타이틀-레시피네임'),
        //             Text('4.런에러표시'),
        //             TextButton.icon(
        //               onPressed: () {},
        //               icon: Icon(Icons.settings),
        //               label: Text('5.세팅버튼'),
        //             ),
        //             WindowButtons(),
        //             //최소화최대화 아이콘 수정하기
        //           ],
        //         ),
        //         Row(
        //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //           children: [
        //             ChartPage(),
        //             Column(
        //               children: [
        //                 // MyList(),

        //                 // 마이리스트넣으니까 에러남
        //                 Text('MyList 1'),
        //                 Text('MyList 2'),
        //                 Text('MyList 3'),
        //                 Text('MyList 4'),
        //                 Text('MyList 5'),
        //                 OutlinedButton(
        //                   onPressed: () {},
        //                   child: Text('7. 로그뷰 Save Log'),
        //                 ),
        //                 Row(
        //                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //                   children: [
        //                     StartStop(),
        //                     // Text('8. 스타트스탑 토글'),
        //                     TextButton.icon(
        //                       onPressed: () {
        //                         // super.dispose();
        //                         print('reset!!');
        //                         // Get.toNamed('/');
        //                         Navigator.pushReplacement(
        //                           context,
        //                           MaterialPageRoute(
        //                             builder: (BuildContext context) => super.widget,
        //                           ),
        //                         );
        //                       },
        //                       icon: Icon(Icons.refresh),
        //                       label: Text('Reset'),
        //                     ),
        //                     // ResetBtn(),
        //                   ],
        //                 ),
        //                 CSVButton(),
        //                 Text('11.레시피버튼'),
        //                 ExitBtn(),
        //               ],
        //             )
        //           ],
        //         ),
        //       ],
        //     ),
        //   ),
        //
        );
  }
}

class Page extends StatefulWidget {
  const Page({Key? key}) : super(key: key);

  @override
  _PageState createState() => _PageState();
}

class _PageState extends State<Page> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return NavigationView(
      appBar: NavigationAppBar(
          automaticallyImplyLeading: true,
          leading: Image.asset(
            'assets/images/CI_nobg.png',
            scale: 10,
          ),
          actions: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Clock(),
              Text('3.레시피네임'),
              Text('4. Run/Error status'),
              Row(
                children: [
                  Icon(FluentIcons.settings),
                  Text('5.Settings'),
                ],
              ),
              WindowButtons()
            ],
          )),
      pane: NavigationPane(
          selected: index,
          onChanged: (newIndex) {
            setState(() {
              index = newIndex;
            });
          },
          displayMode: PaneDisplayMode.minimal,
          items: [
            PaneItem(
                icon: Icon(FluentIcons.accept), title: const Text('menu 1')),
            PaneItem(
              icon: Icon(FluentIcons.accept),
              title: Text('menu 2'),
            ),
          ]),
      content: NavigationBody(
        index: index,
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: ScaffoldPage(
              content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //////////////////////////차트공간
                  Expanded(
                    flex: 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
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
                              children:
                                  List.generate(8, (index) => ChartPage()),
                            )
                            // ChartPage(),
                            )
                        // Expanded(
                        // flex: 1,
                        // child: Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        // children: [
                        // Flexible(
                        // child: GridView.count(
                        // mainAxisSpacing: 10,
                        // crossAxisSpacing: 10,
                        // shrinkWrap: true,
                        // crossAxisCount: 8,
                        // children: List.generate(8, (index) {
                        // return const Center(
                        // child: ChartPage(),
                        // );
                        // }),
                        // ),
                        // ),
                        // ],
                        // ),
                        // ),
                        ,
                      ],
                    ),
                  ),
                  //////////////////////////차트공간
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text('Mylist 1'),
                        Text('Mylist 2'),
                        Text('Mylist 3'),
                        Text('Mylist 4'),
                        Text('Mylist 5'),
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
                                  FluentPageRoute(
                                    builder: (BuildContext context) =>
                                        super.widget,
                                  ),
                                );
                              },
                              child: Icon(FluentIcons.refresh),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CSVButton(),
                            // IniBtn()
                            // TxtBtn(),
                          ],
                        ),
                        Text('Recipe button'),
                        ExitBtn()
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
