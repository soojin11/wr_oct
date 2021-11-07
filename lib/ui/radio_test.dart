import 'package:flutter/material.dart';

class Test extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text("Set Radio Button Horizontally"),
          ),
          body: Center(
            child: RadioGroup(),
          )),
    );
  }
}

class RadioGroup extends StatefulWidget {
  @override
  RadioGroupWidget createState() => RadioGroupWidget();
}

class RadioGroupWidget extends State {
  // Default Radio Button Selected Item When App Starts.
  String radioButtonItem = 'ONE';

  // Group Value for Radio Button.
  int id = 1;

  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
            padding: EdgeInsets.all(14.0),
            child: Text('Selected Radio Item = ' + '$radioButtonItem',
                style: TextStyle(fontSize: 21))),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Radio(
              value: 1,
              groupValue: id,
              onChanged: (val) {
                setState(() {
                  radioButtonItem = 'ONE';
                  id = 1;
                });
              },
            ),
            Text(
              'ONE',
              style: new TextStyle(fontSize: 17.0),
            ),
            Radio(
              value: 2,
              groupValue: id,
              onChanged: (val) {
                setState(() {
                  radioButtonItem = 'TWO';
                  id = 2;
                });
              },
            ),
            Text(
              'TWO',
              style: new TextStyle(
                fontSize: 17.0,
              ),
            ),
            Radio(
              value: 3,
              groupValue: id,
              onChanged: (val) {
                setState(() {
                  radioButtonItem = 'THREE';
                  id = 3;
                });
              },
            ),
            Text(
              'THREE',
              style: new TextStyle(fontSize: 17.0),
            ),
          ],
        ),
      ],
    );
  }
}
