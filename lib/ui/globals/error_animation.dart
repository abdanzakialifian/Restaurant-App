import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ErrorAnimation extends StatelessWidget {
  const ErrorAnimation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Lottie.asset(
          "assets/animation/error_animation.json",
          repeat: true,
          animate: true,
          height: 200,
        ),
      ),
    );
  }
}
