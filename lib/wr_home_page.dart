import 'package:flutter/material.dart';
import 'package:wr_ui/ui/widgets/clock.dart';
import 'package:wr_ui/ui/widgets/exit_btn.dart';
import 'package:wr_ui/ui/widgets/log.dart';
import 'package:wr_ui/ui/widgets/reset_btn.dart';
import 'package:wr_ui/ui/widgets/save_file.dart';
// ignore: unused_import
import 'package:wr_ui/ui/widgets/start_stop.dart';

class wrHomePage extends StatelessWidget {
  wrHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double Height = MediaQuery.of(context).size.height;
    double Width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: Width * 0.1,
                  height: Height * 0.1,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1)),
                  child: Image.asset("images/CI_nobg.png"),
                ),
                Container(
                    padding: EdgeInsets.only(left: 27, top: 12),
                    width: Width * 0.1,
                    height: Height * 0.1,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 1)),
                    child: Clock() //2
                    ),
                Container(
                  width: Width * 0.1,
                  height: Height * 0.1,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1)),
                  child: Text('3.프로그램타이틀 레시피네임'),
                ),
                Container(
                  width: Width * 0.1,
                  height: Height * 0.1,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1)),
                  child: Text('4.런/에러상태표시'),
                ),
                Container(
                  width: Width * 0.1,
                  height: Height * 0.1,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1)),
                  child: Text('5.세팅버튼'),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.1,
                  height: MediaQuery.of(context).size.height * 0.1,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1)),
                  child: Text('13.최소화버튼'),
                ),
              ],
            ),
            SizedBox(height: Height * 0.05),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: Width * 0.79,
                  height: Height * 0.75,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1)),
                  child: Text('6.차트뷰'),
                ),
                SizedBox(width: Width * 0.01 - 18),
                Column(
                  children: [
                    Column(
                      children: [
                        Column(
                          children: [
                            Container(
                              width: Width * 0.15,
                              height: Height * 0.3,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.black, width: 1)),
                              child: MyList(),
                            ),
                            Container(
                              width: Width * 0.15,
                              height: Height * 0.05,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.black, width: 1)),
                              child: OutlinedButton(
                                  onPressed: () {}, child: Text('Save Log')),
                            )
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: Height * 0.02),
                    Row(
                      children: [
                        //8번 스타트 스탑버튼
                        Container(
                          child: Text('8.'),
                        ),
                        //9번 리프레시 버튼
                        // RefreshBtn()
                      ],
                    ),
                    Container(
                      width: Width * 0.15,
                      height: Height * 0.1,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1)),
                      child: CSVButton(),
                    ),
                    SizedBox(height: Height * 0.02),
                    Container(
                      width: Width * 0.15,
                      height: Height * 0.1,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1)),
                      child: Text('11.'),
                    ),
                    SizedBox(height: Height * 0.02),
                    Container(
                      width: Width * 0.15,
                      height: Height * 0.1,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1)),
                      child: ExitBtn(),
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
