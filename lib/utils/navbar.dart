import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:its_urgent/constants.dart';
import 'package:its_urgent/screens/contacts.dart';
import 'package:its_urgent/screens/dialer.dart';
import 'package:its_urgent/screens/login/index.dart';
import 'package:its_urgent/screens/settings/index.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int currentPageIndex = 0;

  // icons for the bottom navigation bar
  final List<Widget> _icons = [
    const Icon(Icons.phone),
    const Icon(Icons.contacts),
    const Icon(Icons.settings),
    const Icon(Icons.person),
  ];

  // index for navigate to the page
  int currentTab = 0;

  // pages
  final List<Widget> pages = [
    const ContactPage(),
    const DialerPage(),
    const SettingPage(),
    const LoginPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
          items: _icons,
          index: currentTab,
          height: 47,
          color: kPrimaryColor,
          backgroundColor: Colors.transparent,
          animationCurve: Curves.easeInOut,
          onTap: (index) {
            setState(() {
              currentTab = index;
            });
          },
        ),
        body: getSelectedWidget(index: currentTab));
  }

  Widget getSelectedWidget({required int index}) {
    Widget widget;
    switch (index) {
      case 0:
        widget = const DialerPage();
        break;
      case 1:
        widget = const ContactPage();
        break;
      case 2:
        widget = const SettingPage();
        break;
      case 3:
        widget = const LoginPage();
        break;
      default:
        widget = const DialerPage();
    }
    return widget;
  }
}
