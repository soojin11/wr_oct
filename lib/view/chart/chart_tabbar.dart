import 'package:flutter/material.dart';
import 'package:wr_ui/const/style/pallette.dart';
import 'package:wr_ui/view/chart/pages/ADDpage.dart';
import 'package:wr_ui/view/chart/pages/ALLpage.dart';
import 'package:wr_ui/view/chart/pages/CUSTOMpage.dart';
import 'package:wr_ui/view/chart/pages/OESpage.dart';
import 'package:wr_ui/view/chart/pages/VIpage.dart';

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
          InkWell(
            autofocus: true,
            focusColor: wrColors.wrPrimary,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(5),
              topRight: Radius.circular(5),
            ),
            hoverColor: Colors.blue,
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => ALLpage()));
            },
            child: Text(
              '  ALL  ',
              style: TextStyle(fontSize: 16, color: wrColors.white),
            ),
          ),
          SizedBox(
            width: 30,
          ),
          InkWell(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(5),
              topRight: Radius.circular(5),
            ),
            hoverColor: Colors.blue,
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => OESpage()));
            },
            child: Text(
              '  OES  ',
              style: TextStyle(fontSize: 16),
            ),
          ),
          SizedBox(
            width: 30,
          ),
          InkWell(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(5),
              topRight: Radius.circular(5),
            ),
            hoverColor: Colors.blue,
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => VIpage()));
            },
            child: Text(
              '  VI  ',
              style: TextStyle(fontSize: 16),
            ),
          ),
          SizedBox(
            width: 30,
          ),
          InkWell(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(5),
              topRight: Radius.circular(5),
            ),
            hoverColor: Colors.blue,
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CUSTOMpage()));
            },
            child: Text(
              '  CUSTOM  ',
              style: TextStyle(fontSize: 16),
            ),
          ),
          SizedBox(
            width: 30,
          ),
          InkWell(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(5),
              topRight: Radius.circular(5),
            ),
            hoverColor: Colors.blue,
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => ADDpage()));
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
        ],
      ),
    );
  }
}
