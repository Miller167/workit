import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:workit/screens/profile_screen.dart';
import 'package:workit/screens/punch_clock_screen.dart';
import 'package:workit/screens/schedule_screen.dart';
import 'package:workit/screens/todo_list_screen.dart';
import '../resources/constants.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import 'overview_screen.dart';

//  ---------- MENU SCREEN ------------
// This screen has the bottom navigation bar (which is animated) and loads for each NavBar option the body of the app.

class NavbarScreen extends StatelessWidget {
  NavbarScreen({Key? key}) : super(key: key);

  int _page = 2;

  List<Widget> _buildScreens() {
    return [
      ScheduleScreen(),
      TodoListScreen(),
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
          activeColorPrimary: secondaryColor,
          inactiveColorPrimary: Colors.grey,
        ),
        PersistentBottomNavBarItem(
          icon: FaIcon(
            FontAwesomeIcons.listUl,
            size: 25,
          ),
          title: "To do",
          activeColorPrimary: secondaryColor,
          inactiveColorPrimary: Colors.grey,
        ),
        PersistentBottomNavBarItem(
          icon: FaIcon(
            FontAwesomeIcons.home,
            size: 25,
          ),
          title: "Home",
          activeColorPrimary: secondaryColor,
          inactiveColorPrimary: Colors.grey,
        ),
        PersistentBottomNavBarItem(
          icon: FaIcon(
            FontAwesomeIcons.clock,
            size: 25,
          ),
          title: "Punch clock",
          activeColorPrimary: secondaryColor,
          inactiveColorPrimary: Colors.grey,
        ),
        PersistentBottomNavBarItem(
          icon: FaIcon(
            FontAwesomeIcons.user,
            size: 25,
          ),
          title: "Profile",
          activeColorPrimary: secondaryColor,
          inactiveColorPrimary: Colors.grey,
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
      //resizeToAvoidBottomInset: true, // This needs to be true if you want to move up the screen when keyboard appears. Default is false.
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
  }
}
