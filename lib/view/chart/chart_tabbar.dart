import 'package:flutter/material.dart';
import 'package:wr_ui/model/const/style/pallette.dart';
import 'package:wr_ui/view/chart/pages/navigator_page/ADDpage.dart';
import 'package:wr_ui/view/chart/pages/navigator_page/ALLpage.dart';
import 'package:wr_ui/view/chart/pages/navigator_page/CUSTOMpage.dart';
import 'package:wr_ui/view/chart/pages/navigator_page/OESpage.dart';
import 'package:wr_ui/view/chart/pages/navigator_page/VIpage.dart';

class chartTabBar extends StatelessWidget {
  const chartTabBar({Key? key}) : super(key: key);

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
              autofocus: true,
              focusColor: wrColors.wrPrimary,
              borderRadius: BorderRadius.all(Radius.circular(5)),
              hoverColor: Colors.blue,
              onTap: () {
                Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation1, animation2) =>
                          ALLpage(),
                      transitionDuration: Duration.zero,
                    ));
              },
              child: Text(
                '  ALL  ',
                style: TextStyle(fontSize: 16),
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
              hoverColor: Colors.blue,
              onTap: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) => OESpage(),
                    transitionDuration: Duration.zero,
                  ),
                );
              },
              child: Text(
                '  OES  ',
                style: TextStyle(fontSize: 16),
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
              hoverColor: Colors.blue,
              onTap: () {
                Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation1, animation2) =>
                          VIpage(),
                      transitionDuration: Duration.zero,
                    ));
              },
              child: Text(
                '  VI  ',
                style: TextStyle(fontSize: 16),
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
              hoverColor: Colors.blue,
              onTap: () {
                Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation1, animation2) =>
                          CUSTOMpage(),
                      transitionDuration: Duration.zero,
                    ));
              },
              child: Text(
                '  CUSTOM  ',
                style: TextStyle(fontSize: 16),
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
              hoverColor: Colors.blue,
              onTap: () {
                Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation1, animation2) =>
                          ADDpage(),
                      transitionDuration: Duration.zero,
                    ));
              },
              child: Row(
                children: [
                  Text(
                    '  ADD  ',
                    style: TextStyle(fontSize: 16),
                  ),
                  Icon(Icons.add)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
