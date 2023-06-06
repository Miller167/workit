import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:workit/screens/login_screen.dart';

//  ------------------- SPLASH SCREEN ---------------------
//  Screen that returns the splash image

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<dynamic> getData() async {
    /*List users = await getUsers().onError((error, stackTrace) => false);
    List<User> parsedUsers = [];
    for (var element in users) {
      parsedUsers.add(User.fromMap(element));
    }
    print(parsedUsers);*/

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return Container();
        } else if (snapshot.hasError) {
          print(snapshot.error);
          print(snapshot.stackTrace);
          return Scaffold(
              body: Center(
                  child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(snapshot.error.toString()),
          )));
        } else {
          return Container();
        }
      },
      future: getData().then((value) {
        if (value) {
          /*Navigator.push(
              context, MaterialPageRoute(builder: (context) => NavbarScreen()));*/

          Navigator.push(
              context, MaterialPageRoute(builder: (context) => LoginScreen()));
        }
      }),
    );
  }
}
