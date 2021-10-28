import 'dart:io';

import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:webview_flutter/webview_flutter.dart';

class ExitBtn extends StatelessWidget {
  const ExitBtn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<bool?> showWarning(BuildContext context) async => showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
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
                  '디바이스 종료 후 프로그램을 종료 해 주세요',
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
                    primary: Colors.blue[900],
                    onPrimary: Colors.blue[700],
                    shadowColor: Colors.blue[900]),
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
      child: TextButton(
        onPressed: () {
          showWarning(context);
        },
        child: Icon(Icons.exit_to_app),
      ),
    );
  }
}
