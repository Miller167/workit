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
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        canvasColor: primaryColor,
        primaryColor: primaryColor,
        textTheme: const TextTheme(
            headline1: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.normal,
              color: Colors.black87,
            ),
            headline2: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.normal,
              color: Colors.black87,
            ),
            headline3: TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.normal,
              color: Colors.black87,
            ),
            headline4: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
            headline5: TextStyle(
              fontSize: 35.0,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
            headline6: TextStyle(
              fontSize: 40.0,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
            bodyText1: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.normal,
              color: Colors.black87,
            ),
            bodyText2: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.normal,
              color: Colors.black87,
            )),
      ),
      home:
          NavbarScreen(), /*
        builder: (context, child) => ResponsiveWrapper.builder(child,
            maxWidth: 1200,
            minWidth: 600,
            defaultScale: true,
            breakpoints: [
              const ResponsiveBreakpoint.autoScaleDown(600, name: MOBILE),
              const ResponsiveBreakpoint.autoScale(800, name: TABLET),
              const ResponsiveBreakpoint.autoScale(1000, name: TABLET),
              const ResponsiveBreakpoint.resize(1200, name: DESKTOP),
              const ResponsiveBreakpoint.autoScale(2460, name: "4K"),
            ],
            background: Container(color: const Color(0xFFF5F5F5))),*/
    );
  }
}
