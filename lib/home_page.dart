import 'package:flutter/material.dart';

class WRHomePage extends StatelessWidget {
  const WRHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'WR',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    child: Center(
                      child: Text(
                        '1. 회사 로고',
                        style: TextStyle(fontSize: 10),
                      ),
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(),
                    ),
                  ), //1
                  SizedBox(
                    width: 4,
                  ),
                  Container(
                    width: 60,
                    height: 60,
                    child: Center(
                      child: Text(
                        '2. 현재날짜, 시간',
                        style: TextStyle(fontSize: 10),
                      ),
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(),
                    ),
                  ), //2
                  SizedBox(
                    width: 4,
                  ),
                  Container(
                    width: 360,
                    height: 60,
                    child: Center(
                      child: Text(
                        '3. 프로그램 타이틀-레시피 네임',
                        style: TextStyle(fontSize: 10),
                      ),
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(),
                    ),
                  ), //3
                  SizedBox(
                    width: 4,
                  ),
                  Container(
                    width: 60,
                    height: 60,
                    child: Center(
                      child: Text(
                        '4. 런/에러 상태표시',
                        style: TextStyle(fontSize: 10),
                      ),
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(),
                    ),
                  ), //4
                  SizedBox(
                    width: 4,
                  ),
                  Container(
                    width: 60,
                    height: 60,
                    child: Center(
                      child: Text(
                        '5. 세팅버튼',
                        style: TextStyle(fontSize: 10),
                      ),
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(),
                    ),
                  ), //4
                  SizedBox(width: 4),
                  Container(
                    width: 60,
                    height: 60,
                    child: Center(
                      child: Text(
                        '13. 최소화 버튼',
                        style: TextStyle(fontSize: 10),
                      ),
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(),
                    ),
                  ) //4
                ],
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 3),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 552,
                        height: 552,
                        child: Center(
                          child: Text(
                            '6. 차트 뷰',
                            style: TextStyle(fontSize: 10),
                          ),
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(),
                        ),
                      ), //6
                      SizedBox(width: 4),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 124,
                            height: 300,
                            child: Center(
                              child: Text(
                                '7. 로그 뷰',
                                style: TextStyle(fontSize: 10),
                              ),
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(),
                            ),
                          ), //7
                          Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: Row(
                              children: [
                                Container(
                                  width: 58,
                                  height: 45,
                                  child: Center(
                                    child: Text(
                                      '8. 스타트/스탑 토글버튼',
                                      style: TextStyle(fontSize: 10),
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border.all(),
                                  ),
                                ), //8
                                SizedBox(width: 6),
                                Container(
                                  width: 58,
                                  height: 45,
                                  child: Center(
                                    child: Text(
                                      '9. 리셋버튼',
                                      style: TextStyle(fontSize: 10),
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border.all(),
                                  ),
                                )
                              ], //9
                            ),
                          ),
                          SizedBox(height: 6),
                          Container(
                            width: 124,
                            height: 62,
                            child: Center(
                              child: Text(
                                '10. 세이브 버튼',
                                style: TextStyle(fontSize: 10),
                              ),
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(),
                            ),
                          ), //10
                          SizedBox(height: 6),
                          Container(
                            width: 124,
                            height: 62,
                            child: Center(
                              child: Text(
                                '11. 레시피 버튼',
                                style: TextStyle(fontSize: 10),
                              ),
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(),
                            ),
                          ), //11
                          SizedBox(height: 6),
                          Container(
                            width: 124,
                            height: 60,
                            child: Center(
                              child: Text(
                                '12. 나가기버튼',
                                style: TextStyle(fontSize: 10),
                              ),
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(),
                            ),
                          ), //12
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
