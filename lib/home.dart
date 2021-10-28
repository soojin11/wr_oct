import 'package:flutter/material.dart';
import 'package:wr_ui/ui/widgets/clock.dart';
import 'package:wr_ui/ui/widgets/exit_btn.dart';
import 'package:wr_ui/ui/widgets/log.dart';
import 'package:wr_ui/ui/widgets/reset_btn.dart';
import 'package:wr_ui/ui/widgets/save_file.dart';
import 'package:wr_ui/ui/widgets/window_btn.dart';

import 'chart/chart_page.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
//나중에 스테이트리스로 바꿀것..
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(
                'assets/images/CI_nobg.png',
                scale: 15,
              ),
              Clock(),
              Text('3.프로그램타이틀-레시피네임'),
              Text('4.런에러표시'),
              TextButton.icon(
                onPressed: () {},
                icon: Icon(Icons.settings),
                label: Text('5.세팅버튼'),
              ),
              WindowButtons(),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ChartPage(),
              Column(
                children: [
                  // MyList(), 마이리스트넣으니까 에러남
                  Text('MyList 1'),
                  Text('MyList 2'),
                  Text('MyList 3'),
                  Text('MyList 4'),
                  Text('MyList 5'),
                  OutlinedButton(
                    onPressed: () {},
                    child: Text('7. 로그뷰 Save Log'),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text('8. 스타트스탑 토글'),
                      TextButton.icon(
                        onPressed: () {
                          // super.dispose();
                          print('refresh!!');
                          // Get.toNamed('/');
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    super.widget),
                          );
                        },
                        icon: Icon(Icons.refresh),
                        label: Text('Reset'),
                      ),
                      // ResetBtn(),
                    ],
                  ),
                  CSVButton(),
                  Text('11.레시피버튼'),
                  ExitBtn(),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
