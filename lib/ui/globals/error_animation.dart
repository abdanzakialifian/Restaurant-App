import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ErrorAnimation extends StatelessWidget {
  final Color textColor;
  final String errorMessage;

  const ErrorAnimation(
      {Key? key, required this.textColor, required this.errorMessage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Lottie.asset(
            "assets/animation/error_animation.json",
            repeat: true,
            animate: true,
            height: 170,
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
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
