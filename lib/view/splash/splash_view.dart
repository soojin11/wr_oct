import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wr_ui/controller/splash_controller.dart';
import 'package:wr_ui/main.dart';
import 'package:wr_ui/model/const/style/pallette.dart';

class SplashView extends GetView<SplashController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WRappbar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              height: 10,
            ),
            Image.asset(
              'assets/images/CI_nobg.png',
              width: 300,
            ),
            SizedBox(
              height: 5,
            ),
            CircularProgressIndicator(
              backgroundColor: Color(0xFF83ACB9),
              color: Colors.blue[900],
              strokeWidth: 6,
            )
          ],
        ),
      ),
    );
  }
}
