import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:workit/resources/constants.dart';

import '../resources/api_calls.dart';
import '../widgets/CustomContainer.dart';
import '../widgets/CustomCupertinoButton.dart';
import '../widgets/CustomProfileButton.dart';

// -------------- PROFILE SCREEN -----------------
//  This is an option of the navbar. The body returns an info card of the user
//  and buttons with the different account management options (such as viewing
//  documents, time off, account settings and logging off)

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {


  @override
  Widget build(BuildContext context) {
    MediaQueryData media = MediaQuery.of(context);
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          //mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Center(
              child: CustomContainer(
                context: context,
                parentMargin:
                    EdgeInsets.fromLTRB(5, media.size.width / 7, 5, 5),
                childMargin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                childPadding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                height: media.size.height / 4,
                width: media.size.width / 1.25,
                color: kGrey1,
                content: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        radius: media.size.width / 7,
                        backgroundImage: AssetImage('assets/images/avatar.jpg'),
                        backgroundColor: Colors.white,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.all(5.0),
                          child: Text(
                            'Martha King',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.all(2.5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const FaIcon(
                                FontAwesomeIcons.envelope,
                                size: 15,
                              ),
                              const SizedBox(
                                width: 10.0,
                              ),
                              Text(
                                'mking@uda.ad',
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: media.size.height / 30,
            ),
            CustomProfileButton(
              media: media,
              title: 'Documents',
              onPressed: () {}
            ),
            CustomProfileButton(
              media: media,
              title: 'Time off',
              onPressed: () {},
            ),
            CustomProfileButton(
              media: media,
              title: 'Account settings',
              onPressed: () {},
            ),
            CustomProfileButton(
              media: media,
              title: 'Log out',
              onPressed: () {},
            ),
          ],
        ),
        Positioned(
          bottom: 10,
          right: media.size.width / 80,
          child: CustomCupertinoButton(
            context: context,
            height: 50,
            width: 50,
            backgroundColor: kGrey1,
            content: Center(
              child: FaIcon(
                FontAwesomeIcons.pencilAlt,
                color: secondaryColor,
                size: 17,
              ),
            ),
            borderRadius: 100,
            onPressed: () {},
          ),
        ),
      ],
    );
  }
}
