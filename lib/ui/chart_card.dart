import 'package:flutter/material.dart';
import 'package:wr_ui/service/color_picker.dart';

class ChartCard extends StatelessWidget {
  const ChartCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2), //그림자 색
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 2), // 그림자위치 바꾸는거
          ),
        ],
      ),
      child: Row(
        children: [
          Column(
            children: [ColorContainer()],
          ),
          Column(
            children: [],
          ),
        ],
      ),
    );
  }
}
