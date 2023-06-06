import 'package:flutter_login/flutter_login.dart';
import 'package:flutter/material.dart';
import 'package:workit/screens/navbar_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user.dart';
import '../resources/api_calls.dart';
import '../resources/constants.dart';

//  ------------------- LOGIN SCREEN -------------------
//  Screen called when starting the app (after the splash). It returns a
//  form with mail and password fields. After submitted, returns the StartScreen.

class LoginScreen extends StatelessWidget {
  Future<String> _authUser(LoginData data) async {
    final SharedPreferences _prefs = await SharedPreferences.getInstance();

    debugPrint('Name: ${data.name}, Password: ${data.password}');

    Map loginRequest = {'email': data.name, 'password': data.password};

    try {
      Map response = await login(loginRequest);
      user = User.fromMap(response);
    } catch (e) {
      return 'Something went wrong. Try again.';
    }

    await _prefs.setInt('id', user.id ?? 0);
    await _prefs.setString('email', user.email);
    await _prefs.setString('username', user.username);
    await _prefs.setString('fullName', user.fullName);
    await _prefs.setBool('administrator', user.administrator);
    await _prefs.setDouble('totalDaysOff', user.totalDaysOff);

    return '';
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      title: 'WORK IT',
      //logo: AssetImage('assets/images/ecorp-lightblue.png'),
      onLogin: _authUser,
      hideForgotPasswordButton: true,
      onSubmitAnimationCompleted: () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => NavbarScreen(),
          ),
        );
      },
      onRecoverPassword: (String) {},
    );
  }
}
