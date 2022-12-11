import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/source/remote/api_service.dart';
import 'package:restaurant_app/provider/restaurant_list_provider.dart';
import '../home/home_page.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({Key? key}) : super(key: key);

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 6),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) {
            return ChangeNotifierProvider<RestaurantListProvider>(
              create: (context) => RestaurantListProvider(
                apiService: ApiService(),
              ),
              child: const HomePage(),
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Lottie.asset(
          "assets/animation/restaurant_animation.json",
          repeat: true,
          animate: true,
        ),
      ),
    );
  }
}
