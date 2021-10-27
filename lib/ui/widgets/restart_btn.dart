import 'package:flutter/material.dart';

class restartBtn extends StatelessWidget {
  const restartBtn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Icon(
        Icons.replay,
        color: Colors.black,
      ),
    );
  }
}
