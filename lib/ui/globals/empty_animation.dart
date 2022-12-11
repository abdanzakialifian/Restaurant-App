import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class EmptyAnimation extends StatelessWidget {
  final Color textColor;
  final String errorMessage;

  const EmptyAnimation({
    Key? key,
    required this.textColor,
    required this.errorMessage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Lottie.asset(
            "assets/animation/empty_animation.json",
            repeat: true,
            animate: true,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            errorMessage,
            style: TextStyle(
              fontFamily: "Poppins Medium",
              fontSize: 18,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}
