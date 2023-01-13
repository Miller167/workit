import 'package:flutter/cupertino.dart';
import 'package:flutter/scheduler.dart';

//  ------------------- SPLASH SCREEN ---------------------
//  Screen that returns the splash image

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'images/splash_xxxhdpi.png',
    );
  }
}
