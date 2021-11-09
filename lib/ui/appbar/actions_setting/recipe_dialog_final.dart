import 'package:flutter/material.dart';
import 'package:wr_ui/style/pallette.dart';

//장바구니 CRUD 예제...
Future<Map<String, dynamic>> recipesDialog(
    BuildContext context, Map<String, dynamic> settings) async {
  return await showDialog(
    barrierColor: null,
    barrierDismissible: false,
    context: context,
    builder: (BuildContext ctx) {
      ////디바이스
      String deviceName = settings['deviceName'].toString();
      double interval = settings['interval'] as double;
      String unit = settings['unit'].toString();
      ////차트
      String chartName = settings['chartName'].toString();
      String chartColor = settings['chartColor'].toString();
      String chartTheme = settings['chartTheme'].toString();
      String seriesType = settings['seriesType'].toString();
      double scaleValue = settings['scaleValue'] as double;
      var top = 100.0;
      var left = 800.0;
      return StatefulBuilder(
        builder: (BuildContext ctx, StateSetter setState) {
          return GestureDetector(
            onVerticalDragUpdate: (DragUpdateDetails dd) {
              print(dd);
              setState(() {
                top = dd.localPosition.dy;
                left = dd.localPosition.dx;
              });
            },
            child: Stack(children: [
              Positioned(
                top: top,
                left: left,
                child: SimpleDialog(
                  contentPadding: EdgeInsets.zero,
                  titlePadding: const EdgeInsets.fromLTRB(24, 10, 24, 0),
                  title: Text('Recipe'),
                  children: [
                    Column(
                      children: [
                        Divider(
                          thickness: 0.3,
                          color: Colors.grey[700],
                        ),
                        //레시피리스트
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: wrColors.wrPrimary)),
                              child: Text(
                                'Recipe List',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: wrColors.wrPrimary,
                                ),
                              ),
                            ),
                            Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: wrColors.wrPrimary)),
                                  child: Text(
                                    'parameter1',
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: wrColors.wrPrimary,
                                    ),
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: wrColors.wrPrimary)),
                                  child: Text(
                                    'parameters',
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: wrColors.wrPrimary,
                                    ),
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: wrColors.wrPrimary)),
                                  child: Text(
                                    'parameters',
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: wrColors.wrPrimary,
                                    ),
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: wrColors.wrPrimary)),
                                  child: Text(
                                    'parameters',
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: wrColors.wrPrimary,
                                    ),
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: wrColors.wrPrimary)),
                                  child: Text(
                                    'parameters',
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: wrColors.wrPrimary,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),

//레시피리스트
                        ///////////차트세팅
                        Divider(
                          thickness: 0.3,
                          color: Colors.grey[700],
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 20.0, bottom: 16.0, left: 6.0, right: 6.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context, rootNavigator: true)
                                  .pop(<String, dynamic>{
                                'deviceName': deviceName,
                                'interval': interval,
                                'unit': unit,

                                ///차트세팅
                                'chartName': chartName,
                                'chartColor': chartColor,
                                'chartTheme': chartTheme,
                                'seriesType': seriesType,
                                'scaleValue': scaleValue
                              });
                            },
                            child: Text('Add'),
                            style: ElevatedButton.styleFrom(
                                primary: wrColors.wrPrimary),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: wrColors.wrPrimary,
                            ),
                            onPressed: () {
                              print('레시피 삭제');
                            },
                            child: Text('Delete'),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: wrColors.wrPrimary,
                            ),
                            onPressed: () {
                              print('레시피 선택');
                            },
                            child: Text('Select'),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ]),
          );
        },
      );
    },
  );
}
