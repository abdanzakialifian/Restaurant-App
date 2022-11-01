import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:restaurant_app/style/color.dart';
import 'package:restaurant_app/ui/splashscreen/splash_screen_page.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: darkGreen),
  );
  return runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Restaurant App",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const SplashScreenPage(),
    );
  }
}
