import 'package:flutter/material.dart';
import 'package:wr_ui/ui/widgets/clock.dart';
import 'package:wr_ui/ui/widgets/start_stop_toggle_button.dart';

class wrHomePage extends StatelessWidget {
  const wrHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Text('1.회사로고'),
                ),
                Container(child: Clock() //2
                    ),
                Container(
                  child: Text('3.프로그램타이틀 레시피네임'),
                ),
                Container(
                  child: Text('4.런/에러상태표시'),
                ),
                Container(
                  child: Text('5.세팅버튼'),
                ),
                Container(
                  child: Text('13.최소화버튼'),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Container(
                    width: 1000,
                    height: 550,
                    child: Text('6.차트뷰'),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 250,
                      width: 150,
                      color: Colors.amber,
                      child: Text('7.'),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(child: Text('8')),
                        StartStopToggleBtn(),
                        Container(
                          child: Text('9.'),
                        ),
                      ],
                    ),
                    Container(
                      child: Text('10.'),
                    ),
                    Container(
                      child: Text('11.'),
                    ),
                    Container(
                      child: Text('12.'),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
