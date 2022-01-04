import 'package:flutter/material.dart';

// ignore: must_be_immutable
class RightButton extends StatelessWidget {
  RightButton(
      {Key? key,
      required this.text,
      required this.primary,
      this.icon,
      this.color,
      required this.onPressed})
      : super(key: key);
  String text;
  Color primary;
  IconData? icon;
  VoidCallback onPressed;
  Color? color;

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
                color: color,
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
