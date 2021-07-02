import 'package:flutter/material.dart';
import 'package:fyp_climate_hero/GeneralPage/homepage.dart';
import 'package:fyp_climate_hero/DashboardPage/dashboard.dart';
import 'package:fyp_climate_hero/ProgressPage/myprogress.dart';
import 'package:fyp_climate_hero/ProfilePage/profile.dart';
import 'package:fyp_climate_hero/user.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class NavigationPage extends StatefulWidget {
  final User user;

  const NavigationPage({Key key, this.user}) : super(key: key);

  @override
  _NavigationPage createState() => _NavigationPage();
}

class _NavigationPage extends State<NavigationPage> {
  int _currentIndex = 0;
  List<Widget> tabchildren;
  String maintitle = "Home";

  @override
  void initState() {
    super.initState();
    tabchildren = [
      HomePage(user: widget.user),
      Dashboard(),
      MyProgress(user: widget.user),
      Profile(user: widget.user),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: mainDrawer(context),
      body: tabchildren[_currentIndex], // new
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,

        onTap: onTabTapped, // new
        currentIndex: _currentIndex, // new
        items: [
          new BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          new BottomNavigationBarItem(
              icon: Icon(Icons.insert_chart), label: 'Dashboard'),
          new BottomNavigationBarItem(
              icon: Icon(MdiIcons.leaf), label: 'My Progress'),
          new BottomNavigationBarItem(
              icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
      if (_currentIndex == 0) {
        maintitle = "Home";
      }
      if (_currentIndex == 1) {
        maintitle = "Dashboard";
      }
      if (_currentIndex == 2) {
        maintitle = "My Progress";
      }
      if (_currentIndex == 3) {
        maintitle = "Profile";
      }
    });
  }
}
