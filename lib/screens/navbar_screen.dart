import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:workit/resources/widgets.dart';
import 'package:workit/screens/profile_screen.dart';
import 'package:workit/screens/punch_clock_screen.dart';
import 'package:workit/screens/schedule_screen.dart';
import '../resources/constants.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import 'overview_screen.dart';

//  ---------- MENU SCREEN ------------
// This screen has the bottom navigation bar (which is animated) and loads for each NavBar option the body of the app.

class NavbarScreen extends StatelessWidget {
  NavbarScreen({Key? key}) : super(key: key);

  int _page = 1;

  List<Widget> _buildScreens() {
    return [
      ScheduleScreen(),
      OverviewScreen(),
      PunchClockScreen(),
      ProfileScreen(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() => [
        PersistentBottomNavBarItem(
          icon: FaIcon(
            FontAwesomeIcons.calendarCheck,
            size: 25,
          ),
          title: "Schedule",
          activeColorPrimary: Colors.teal,
          inactiveColorPrimary: Colors.grey,
        ),
        PersistentBottomNavBarItem(
          icon: FaIcon(
            FontAwesomeIcons.home,
            size: 25,
          ),
          title: "Home",
          activeColorPrimary: Colors.teal,
          inactiveColorPrimary: Colors.grey,
          /*routeAndNavigatorSettings: RouteAndNavigatorSettings(
          initialRoute: "/",
          routes: {
            "/filter": (final context) => const InspectionsFilterScreen(),
          },
        ),*/
        ),
        PersistentBottomNavBarItem(
          icon: FaIcon(
            FontAwesomeIcons.clock,
            size: 25,
          ),
          title: "Punch clock",
          activeColorPrimary: Colors.teal,
          inactiveColorPrimary: Colors.grey,
          /*routeAndNavigatorSettings: RouteAndNavigatorSettings(
          initialRoute: "/",
          routes: {
            "/filter": (final context) => const RecordsFilterScreen(),
          },
        ),*/
        ),
        PersistentBottomNavBarItem(
          icon: FaIcon(
            FontAwesomeIcons.user,
            size: 25,
          ),
          title: "Profile",
          activeColorPrimary: Colors.teal,
          inactiveColorPrimary: Colors.grey,
          /*routeAndNavigatorSettings: RouteAndNavigatorSettings(
          initialRoute: "/",
          routes: {
            "/filter": (final context) => const RecordsFilterScreen(),
          },
        ),*/
        ),
      ];

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    PersistentTabController _controller;
    _controller = PersistentTabController(initialIndex: _page);
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Colors.white, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset:
          true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows:
          true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle:
          NavBarStyle.style6, // Choose the nav bar style with this property.
    );
    /*return Scaffold(
      extendBody: true,
      */ /*bottomNavigationBar: CurvedNavigationBar(
        index: _page,
        height: media.height / 10,
        backgroundColor: Colors.transparent,
        color: kGrey4,
        items: <Widget>[
          FaIcon(
            FontAwesomeIcons.list,
            size: 25,
            color: kGrey1,
          ),
          FaIcon(
            FontAwesomeIcons.calendarCheck,
            size: 25,
            color: kGrey1,
          ),
          FaIcon(
            FontAwesomeIcons.home,
            size: 25,
            color: kGrey1,
          ),
          FaIcon(
            FontAwesomeIcons.clock,
            size: 25,
            color: kGrey1,
          ),
          FaIcon(
            FontAwesomeIcons.user,
            size: 25,
            color: kGrey1,
          ),
        ],
        onTap: (index) {
          //When selected an option of the navbar, change the body
          setState(() {
            _page = index;
          });
        },
        letIndexChange: (index) => true,
      ),*/ /*
      body: kNavBarScreens[_page],
    );*/
  }
}
