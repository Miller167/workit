import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:workit/resources/widgets.dart';
import '../resources/constants.dart';

//  --------------------- OVERVIEW SCREEN -----------------------
//  Home page of the navBar. Has a summary of today's task. Has events,
//  shift hours and tasks.

class OverviewScreen extends StatefulWidget {
  const OverviewScreen({Key? key}) : super(key: key);

  @override
  State<OverviewScreen> createState() => _OverviewScreenState();
}

class _OverviewScreenState extends State<OverviewScreen> {
  bool shiftStarted = true;
  bool shiftEnded = false;

  @override
  Widget build(BuildContext context) {
    MediaQueryData media = MediaQuery.of(context);
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.fromLTRB(0, 0, 0, media.size.height / 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(
                media.size.width / 10,
                media.size.height / 10,
                0,
                0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Hi,',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    'Tania',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ],
              ),
            ),
            Center(
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 10.0),
                height: 1.25,
                width: media.size.width / 1.1,
                decoration: BoxDecoration(
                  color: kGrey4,
                ),
              ),
            ),
            Container(
              //padding: EdgeInsets.all(5.0),
              margin: EdgeInsets.fromLTRB(
                media.size.width / 10,
                5,
                0,
                15,
              ),
              child: Text(
                'Today!',
                style: Theme.of(context).textTheme.headline3,
              ),
            ),
            Center(
              child: customOverviewEventTile(
                color: Colors.pinkAccent,
                height: 100,
                width: media.size.width / 1.1,
                title: 'Meeting w/ Rui',
                description: 'Room 1, main office',
                endHour: '12:00',
                startHour: '11:00',
              ),
            ),
            Center(
              child: customOverviewEventTile(
                color: Colors.blue,
                height: 100,
                width: media.size.width / 1.1,
                title: 'Call boss',
                description: 'Weekend off',
                endHour: '09:30',
                startHour: '09:00',
              ),
            ),
            Center(
              child: customOverviewEventTile(
                color: Colors.orangeAccent,
                height: 100,
                width: media.size.width / 1.1,
                title: 'Prepare project documentation',
                description: '',
                endHour: '15:00',
                startHour: '12:00',
              ),
            ),
            Center(
              child: CustomContainer(
                  parentMargin: EdgeInsets.symmetric(vertical: 5.0),
                  context: context,
                  height: media.size.height / 8,
                  width: media.size.width / 1.3,
                  backgroundColor: kGrey1,
                  content: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        margin: const EdgeInsets.all(2.5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FaIcon(
                              FontAwesomeIcons.arrowRight,
                              size: 15,
                              color: kGrey4,
                            ),
                            const SizedBox(
                              width: 10.0,
                            ),
                            Text(
                              shiftStarted
                                  ? 'Your shift started at 08:54'
                                  : 'Your shift hasn\'t started yet',
                              style: Theme.of(context).textTheme.headline2,
                            ),
                          ],
                        ),
                      ),
                      FaIcon(
                        FontAwesomeIcons.ellipsisV,
                        size: 15,
                        color: kGrey4,
                      ),
                      Container(
                        margin: const EdgeInsets.all(2.5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FaIcon(
                              FontAwesomeIcons.arrowLeft,
                              size: 15,
                              color: kGrey4,
                            ),
                            const SizedBox(
                              width: 10.0,
                            ),
                            Text(
                              shiftEnded
                                  ? 'Your shift ended at 18:01'
                                  : 'Your shift hasn\'t ended yet',
                              style: Theme.of(context).textTheme.headline2,
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
