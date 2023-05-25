import 'package:responsive_framework/responsive_framework.dart';
import 'package:flutter/material.dart';
import 'package:workit/resources/constants.dart';
import 'package:workit/screens/login_screen.dart';
import 'package:workit/screens/overview_screen.dart';
import 'package:workit/screens/schedule_screen.dart';
import 'package:workit/screens/splash_screen.dart';
import 'package:workit/screens/navbar_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          canvasColor: kGrey3,
          primaryColor: primaryColor,
          highlightColor: kGrey5,
          focusColor: kGrey5,
          fontFamily: 'NotoSansJP',
        ),
        home: SplashScreen());
  }
}
