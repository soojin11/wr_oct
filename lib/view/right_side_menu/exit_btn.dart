import 'dart:io';

import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:webview_flutter/webview_flutter.dart';
import 'package:wr_ui/model/const/style/pallette.dart';

// ignore: must_be_immutable
class ExitBtn extends StatelessWidget {
  bool measuring = true;
  ExitBtn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<bool?> showWarning(BuildContext context) async => showDialog<bool>(
          context: context,
          builder: (context) => measuring
              ? AlertDialog(
                  title: Text(
                    '측정중입니다.\n',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.check_circle_outlined,
                        color: Colors.red[400],
                        size: 12,
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      Text(
                        '측정을 중지하고 프로그램을 종료하시겠습니까?',
                        style: TextStyle(color: Colors.red[400], fontSize: 12),
                      ),
                    ],
                  ),
                  actions: [
                    ElevatedButton(
                      onPressed: () {
                        exit(0);
                        // Navigator.pop(context, true);
                        // SystemNavigator.pop();
                      },
                      child: Text(
                        '예',
                        style: TextStyle(color: Colors.white, fontSize: 8),
                      ),
                      style: ElevatedButton.styleFrom(
                          primary: wrColors.wrPrimary,
                          onPrimary: Colors.blue[700],
                          shadowColor: wrColors.wrPrimary),
                    ),
                    OutlinedButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: Text(
                        '아니오',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 8,
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                )
              : AlertDialog(
                  title: Text(
                    '프로그램을 종료하시겠습니까?\n',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.check_circle_outlined,
                        color: Colors.red[400],
                        size: 12,
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      Text(
                        '디바이스가 종료됩니다.',
                        style: TextStyle(color: Colors.red[400], fontSize: 12),
                      ),
                    ],
                  ),
                  actions: [
                    ElevatedButton(
                      onPressed: () {
                        exit(0);
                        // Navigator.pop(context, true);
                        // SystemNavigator.pop();
                      },
                      child: Text(
                        '예',
                        style: TextStyle(color: Colors.white, fontSize: 8),
                      ),
                      style: ElevatedButton.styleFrom(
                          primary: wrColors.wrPrimary,
                          onPrimary: Colors.blue[700],
                          shadowColor: wrColors.wrPrimary),
                    ),
                    OutlinedButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: Text(
                        '아니오',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 8,
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
        );
    return WillPopScope(
        onWillPop: () async {
          showWarning(context);
          final shouldPop = await showWarning(context);
          return shouldPop ?? false;
        },
        child: TextButton.icon(
          onPressed: () {
            showWarning(context);
          },
          icon: Icon(
            Icons.exit_to_app,
            color: Colors.blueGrey,
          ),
          label: Text(
            'Exit',
            style:
                TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.bold),
          ),
        ));
  }
}
