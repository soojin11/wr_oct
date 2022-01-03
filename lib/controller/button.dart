import 'package:flutter/material.dart';

// ignore: must_be_immutable
class RightButton extends StatelessWidget {
  RightButton(
      {Key? key,
      required this.text,
      required this.primary,
      this.icon,
      container,
      required this.onPressed})
      : super(key: key);
  String text;
  Color primary;
  IconData? icon;
  VoidCallback onPressed;
  Container? container;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        child: Container(
          width: 200,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(text),
              Icon(
                icon,
                size: 16,
              ),
            ],
          ),
        ),
        style: ElevatedButton.styleFrom(
          primary: primary,
          textStyle: TextStyle(fontSize: 16),
        ),
        onPressed: onPressed);
  }
}
