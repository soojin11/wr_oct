import 'package:flutter/material.dart';
import 'package:wr_ui/model/const/style/pallette.dart';
import 'package:wr_ui/view/chart/pages/navigator_page/ADDpage.dart';
import 'package:wr_ui/view/chart/pages/navigator_page/ALLpage.dart';
import 'package:wr_ui/view/chart/pages/navigator_page/CUSTOMpage.dart';
import 'package:wr_ui/view/chart/pages/navigator_page/OESpage.dart';
import 'package:wr_ui/view/chart/pages/navigator_page/VIpage.dart';

class chartTabBar extends StatefulWidget {
  const chartTabBar({Key? key}) : super(key: key);

  @override
  State<chartTabBar> createState() => _chartTabBarState();
}

class _chartTabBarState extends State<chartTabBar> {
  static int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1000,
      height: 50,
      child: Row(
        children: [
          SizedBox(
            width: 40,
          ),
          Material(
            child: InkWell(
              // autofocus: true,
              // focusColor: wrColors.wrPrimary,
              borderRadius: BorderRadius.all(Radius.circular(5)),
              // hoverColor: Colors.blue,
              onTap: () {
                setState(() {
                  _index = 0;
                });
                Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation1, animation2) =>
                          ALLpage(),
                      transitionDuration: Duration.zero,
                    ));
              },
              child: Container(
                decoration: BoxDecoration(
                    color: _index == 0 ? Colors.blueGrey : Colors.transparent,
                    borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 6.0, right: 6.0, top: 4, bottom: 4),
                  child: Text(
                    '  ALL  ',
                    style: TextStyle(
                        fontSize: 16,
                        color: _index == 0 ? wrColors.white : Colors.black,
                        fontWeight:
                            _index == 0 ? FontWeight.bold : FontWeight.normal),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 30,
          ),
          Material(
            child: InkWell(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5),
                topRight: Radius.circular(5),
              ),
              // hoverColor: Colors.blue,
              onTap: () {
                setState(() {
                  _index = 1;
                });
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) => OESpage(),
                    transitionDuration: Duration.zero,
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                    color: _index == 1 ? Colors.blueGrey : Colors.transparent,
                    borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 6, right: 6, top: 4, bottom: 4),
                  child: Text(
                    '  OES  ',
                    style: TextStyle(
                        fontSize: 16,
                        color: _index == 1 ? wrColors.white : Colors.black,
                        fontWeight:
                            _index == 1 ? FontWeight.bold : FontWeight.normal),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 30,
          ),
          Material(
            child: InkWell(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5),
                topRight: Radius.circular(5),
              ),
              // hoverColor: Colors.blue,
              onTap: () {
                setState(() {
                  _index = 2;
                });
                Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation1, animation2) =>
                          VIpage(),
                      transitionDuration: Duration.zero,
                    ));
              },
              child: Container(
                decoration: BoxDecoration(
                    color: _index == 2 ? Colors.blueGrey : Colors.transparent,
                    borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 6, right: 6, top: 4, bottom: 4),
                  child: Text(
                    '  VI  ',
                    style: TextStyle(
                        fontSize: 16,
                        color: _index == 2 ? wrColors.white : Colors.black,
                        fontWeight:
                            _index == 2 ? FontWeight.bold : FontWeight.normal),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 30,
          ),
          Material(
            child: InkWell(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5),
                topRight: Radius.circular(5),
              ),
              // hoverColor: Colors.blue,
              onTap: () {
                setState(() {
                  _index = 3;
                });
                Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation1, animation2) =>
                          CUSTOMpage(),
                      transitionDuration: Duration.zero,
                    ));
              },
              child: Container(
                decoration: BoxDecoration(
                    color: _index == 3 ? Colors.blueGrey : Colors.transparent,
                    borderRadius: BorderRadius.circular(20)),
                child: Text(
                  '  CUSTOM  ',
                  style: TextStyle(
                      fontSize: 16,
                      color: _index == 3 ? wrColors.white : Colors.black,
                      fontWeight:
                          _index == 3 ? FontWeight.bold : FontWeight.normal),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 30,
          ),
          Material(
            child: InkWell(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5),
                topRight: Radius.circular(5),
              ),
              // hoverColor: Colors.blue,
              onTap: () {
                setState(() {
                  _index = 4;
                });
                Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation1, animation2) =>
                          ADDpage(),
                      transitionDuration: Duration.zero,
                    ));
              },
              child: Container(
                decoration: BoxDecoration(
                    color: _index == 4 ? Colors.blueGrey : Colors.transparent,
                    borderRadius: BorderRadius.circular(20)),
                child: Row(
                  children: [
                    Text(
                      '  ADD  ',
                      style: TextStyle(
                          fontSize: 16,
                          color: _index == 4 ? wrColors.white : Colors.black,
                          fontWeight: _index == 4
                              ? FontWeight.bold
                              : FontWeight.normal),
                    ),
                    Icon(
                      Icons.add,
                      color: _index == 4 ? wrColors.white : Colors.black,
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
