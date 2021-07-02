import 'package:flutter/material.dart';
import 'package:fyp_climate_hero/Admin/adminAddActions.dart';
import 'package:fyp_climate_hero/manageActions.dart';
import 'package:fyp_climate_hero/GeneralPage/loginpage.dart';
import 'package:fyp_climate_hero/GeneralPage/navigation.dart';
import 'package:fyp_climate_hero/ProfilePage/profile.dart';
import 'package:fyp_climate_hero/user.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class AdminPage extends StatefulWidget {
  final User user;

  const AdminPage({Key key, this.user}) : super(key: key);
  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  double screenHeight, screenWidth;
  GlobalKey<RefreshIndicatorState> refreshKey;

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.grey[200],
        drawer: drawer(context),
        appBar: AppBar(
          title: Text(
            'App Management',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: Stack(
          children: [
            upper(context),
            lower(context),
          ],
        ),
      ),
    );
  }

  upper(BuildContext context) {
    return Container(
      color: Colors.blue,
      height: screenHeight / 3.5,
      width: screenWidth,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  "My Climate Hero Management",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ],
            ),
            SizedBox(
              height: 3,
            ),
            Row(
              children: [
                Text(widget.user.email),
              ],
            )
          ],
        ),
      ),
    );
  }

  lower(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Column(
        children: [
          SizedBox(height: screenHeight / 9),
          Row(
            children: [],
          ),
          SizedBox(
            height: 50,
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) =>
                          AdminAddActions(user: widget.user)));
            },
            child: Container(
              height: screenHeight / 5,
              width: screenWidth / 2,
              margin: EdgeInsets.all(6.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(1.0, 1.0), //(x,y)
                    blurRadius: 3.0,
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    MdiIcons.plusCircle,
                    color: Colors.blue,
                    size: 50,
                  ),
                  SizedBox(height: 10),
                  Text(
                    "New Action",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) =>
                          ManageActions(user: widget.user)));
            },
            child: Container(
              height: screenHeight / 5,
              width: screenWidth / 2,
              margin: EdgeInsets.all(6.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(1.0, 1.0), //(x,y)
                    blurRadius: 3.0,
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    MdiIcons.pencilLock,
                    color: Colors.blue,
                    size: 50,
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Manage Actions",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  drawer(context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          Container(
            height: 200,
            color: Colors.blue,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(MdiIcons.leaf),
                SizedBox(width: 10),
                Text(
                  "Climate Hero",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ],
            ),
          ),
          ListTile(
              trailing: Icon(Icons.arrow_forward),
              leading: Icon(Icons.person),
              title: Text(
                "Home",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              // ignore: sdk_version_set_literal
              onTap: () => {
                    Navigator.pop(context),
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => NavigationPage(
                                  user: widget.user,
                                )))
                  }),
          ListTile(
              trailing: Icon(Icons.arrow_forward),
              leading: Icon(Icons.person),
              title: Text(
                "User Profile",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              // ignore: sdk_version_set_literal
              onTap: () => {
                    Navigator.pop(context),
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => Profile(
                                  user: widget.user,
                                )))
                  }),
          ListTile(
              trailing: Icon(Icons.arrow_forward),
              leading: Icon(Icons.lock),
              title: Text(
                "Log out",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              // ignore: sdk_version_set_literal
              onTap: () => {
                    Navigator.pop(context),
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => Login()))
                  }),
          Container(
            alignment: Alignment.bottomCenter,
            child: Text("Claimed by Climate Hero"),
          ),
        ],
      ),
    );
  }
}
