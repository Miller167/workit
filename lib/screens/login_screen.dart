import 'package:flutter_login/flutter_login.dart';
import 'package:flutter/material.dart';
import 'package:workit/screens/navbar_screen.dart';

import '../resources/constants.dart';

//  ------------------- LOGIN SCREEN -------------------
//  Screen called when starting the app (after the splash). It returns a
//  form with mail and password fields. After submitted, returns the StartScreen.

class LoginScreen extends StatelessWidget {
  Duration get loginTime => Duration(milliseconds: 2250);

  Future<String?> _authUser(LoginData data) {
    debugPrint('Name: ${data.name}, Password: ${data.password}');
    return Future.delayed(loginTime).then((_) {
      if (!users.containsKey(data.name)) {
        return 'User not exists';
      }
      if (users[data.name] != data.password) {
        return 'Password does not match';
      }
      return null;
    });
  }

  Future<String?> _signupUser(SignupData data) {
    debugPrint('Signup Name: ${data.name}, Password: ${data.password}');
    return Future.delayed(loginTime).then((_) {
      return null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      title: 'WORK IT',
      //logo: AssetImage('assets/images/ecorp-lightblue.png'),
      onLogin: _authUser,
      onSignup: _signupUser,
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
