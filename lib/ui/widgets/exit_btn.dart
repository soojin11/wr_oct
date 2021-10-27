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
            title: Text('프로그램을 종료하시겠습니까?'),
            actions: [
              ElevatedButton(
                onPressed: () {
                  exit(0);
                  // Navigator.pop(context, true);
                  // SystemNavigator.pop();
                },
                child: Text('예'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pop(context, false),
                child: Text('아니오'),
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
