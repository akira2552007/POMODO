import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';

class MyWidget extends StatelessWidget {
  final CountDownController controller;
  const MyWidget({super.key, required this.controller, required this.time});
  final int time;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      
      child: CircularCountDownTimer(
        textStyle: TextStyle(
          fontSize: 20,
          color: Colors.orange,
          
        ),
        width: 100, // smaller fixed size
        height: 150,
        duration: 60 * time,
        fillColor: Colors.orange,
        ringColor: Colors.grey[200]!,
        fillGradient: LinearGradient(colors: [Colors.white, Colors.orange]),
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
