import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class EmptyAnimation extends StatelessWidget {
  const EmptyAnimation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.only(top: 70),
        child: Lottie.asset(
          "assets/animation/empty_animation.json",
          repeat: true,
          animate: true,
        ),
      ),
    );
  }
}
