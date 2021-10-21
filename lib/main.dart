import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'WR',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: Column(
          children: [
            Row(
              children: [
                Container(), //1
                Container(), //2
                Container(), //3
                Container(), //4
                Container() //5
              ],
            ),
            Expanded(
              child: Row(
                children: [
                  Container(), //6
                  Column(
                    children: [
                      Container(), //7
                      Row(
                        children: [
                          Container(), //8
                          Container()
                        ], //9
                      ),
                      Container(), //10
                      Container(), //11
                      Container(), //12
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
