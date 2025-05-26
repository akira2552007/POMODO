import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyWidget extends StatelessWidget {
  final CountDownController controller;
  const MyWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: CircularCountDownTimer(
        width: 100, // smaller fixed size
        height: 150,
        duration: 60,
        fillColor: Colors.purpleAccent[100]!,
        ringColor: Colors.grey[200]!,
        controller: controller,
        isReverse: true,
        isTimerTextShown: true,
        onComplete: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Timer Completed!'),
              duration: Duration(seconds: 2),
            ),
          );
        },
      ),
    );
  }
}
