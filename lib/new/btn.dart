import 'package:flutter/material.dart';
import 'package:wr_ui/view/chart/main_chart.dart';
import 'package:wr_ui/view/chart/pages/ALLpage.dart';

class BtnHover extends StatefulWidget {
  final int index;
  final String title;
  BtnHover({required this.index, required this.title});
  @override
  _BtnHoverState createState() =>
      _BtnHoverState(index: this.index, title: this.title);
}

class _BtnHoverState extends State<BtnHover> {
  final int index;
  final String title;
  _BtnHoverState({required this.index, required this.title});
  // final Color _color =
  //     Colors.primaries[Random.secure().nextInt(Colors.primaries.length)];
  bool isHover = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (fls) {
        setState(() {
          isHover = true;
        });
      },
      onExit: (fls) {
        setState(() {
          isHover = false;
        });
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          onTap: () {
            print('차트페이지로 이동');
            // Navigator.push(
            //     context,
            //     PageRouteBuilder(
            //       pageBuilder: (context, animation1, animation2) => ALLpage(),
            //       transitionDuration: Duration.zero,
            //     )
            // );
          },
          child: AnimatedContainer(
            child: ChartPage(),
            margin: EdgeInsets.symmetric(vertical: isHover ? 3 : 0),
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      blurRadius: isHover ? 12 : 7,
                      spreadRadius: 5,
                      color: isHover
                          ? Colors.cyan.withOpacity(0.4)
                          : Colors.grey.withOpacity(0.2))
                ],
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                )
                //  BorderRadius.only(
                //   topRight: (isHover || index == 0)
                //       ? Radius.circular(10)
                //       : Radius.circular(0),
                //   topLeft: (isHover || index == 0)
                //       ? Radius.circular(10)
                //       : Radius.circular(0),
                //   bottomLeft: (isHover || index == 5)
                //       ? Radius.circular(10)
                //       : Radius.circular(0),
                //   bottomRight: (isHover || index == 5)
                //       ? Radius.circular(10)
                //       : Radius.circular(0),
                // ),
                ),
            duration: Duration(milliseconds: 200),
            width: isHover ? 250 : 240,
            height: isHover ? 250 : 240,
          ),
        ),
      ),
    );
  }
}
