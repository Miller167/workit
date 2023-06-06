import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../resources/constants.dart';
import '../widgets/CustomContainer.dart';
import '../widgets/CustomDivider.dart';
import '../widgets/CustomOverviewEventTile.dart';
import 'package:flutter_emoji/flutter_emoji.dart';

import '../widgets/CustomOverviewTaskTile.dart';

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
  var parser = EmojiParser();

  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;

    List<Widget> events = [
      customOverviewEventTile(
        color: Colors.blue,
        height: media.height / 10,
        width: media.width / 1.1,
        title: 'Call boss',
        description: 'Weekend off',
        endHour: '09:30',
        startHour: '09:00',
      ),
      customOverviewEventTile(
        color: Colors.pinkAccent,
        height: media.height / 10,
        width: media.width / 1.1,
        title: 'Meeting w/ Rui',
        description: 'Room 1, main office',
        endHour: '12:00',
        startHour: '11:00',
      ),
      customOverviewEventTile(
        color: Colors.orangeAccent,
        height: media.height / 10,
        width: media.width / 1.1,
        title: 'Prepare project documentation',
        description: '',
        endHour: '15:00',
        startHour: '12:00',
      ),
    ];
    List<Widget> tasks = [
      customOverviewTaskTile(
        height: media.height / 20,
        width: media.width / 1.1,
        title: 'Finish essay',
      ),
      customOverviewTaskTile(
        height: media.height / 20,
        width: media.width / 1.1,
        title: 'Edit yesterday\'s post',
      )
    ];

    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(
            vertical: media.height / 30, horizontal: media.width / 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                  vertical: media.height / 40, horizontal: media.width / 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('Good morning,',
                            style: Theme.of(context).textTheme.titleMedium),
                        Text('Tania ${parser.getName('wave').code}',
                            style: Theme.of(context).textTheme.titleLarge),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text('Wed 16th, May',
                            style: Theme.of(context).textTheme.titleMedium),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(parser.getName('sunny').code,
                                style: Theme.of(context).textTheme.titleMedium),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ), //Title + date
            CustomDivider(padding: media.width / 15),
            TextButton(
              onPressed: () {},
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Today\'s events',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(width: 5),
                  Icon(Icons.arrow_forward_ios,
                      size: Theme.of(context).textTheme.titleMedium?.fontSize,
                      color: Colors.black87),
                ],
              ),
            ),

            SizedBox(
              height: media.height / 5,
              child: ListView.builder(
                  itemCount: events.length,
                  itemBuilder: (BuildContext context, int index) {
                    return events[index];
                  }),
            ),
            SizedBox(
              height: 10,
            ),
            TextButton(
              onPressed: () {},
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Today\'s tasks',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(width: 5),
                  Icon(Icons.arrow_forward_ios,
                      size: Theme.of(context).textTheme.titleMedium?.fontSize,
                      color: Colors.black87),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: media.width / 40),
              height: media.height / 7,
              child: ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (BuildContext context, int index) {
                    return tasks[index];
                    //TextButton(onPressed: () {}, child: Text('...')),
                  }),
            ),
            SizedBox(
              height: media.height / 15,
            ),
            Center(
              child: CustomContainer(
                  parentMargin: EdgeInsets.symmetric(vertical: 5.0),
                  context: context,
                  height: media.height / 8,
                  width: media.width / 1.3,
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
                              style: Theme.of(context).textTheme.titleSmall,
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
                              style: Theme.of(context).textTheme.titleSmall,
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
