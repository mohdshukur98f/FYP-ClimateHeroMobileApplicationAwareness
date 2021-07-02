import 'package:flutter/material.dart';
import 'package:fyp_climate_hero/action.dart';
import 'package:fyp_climate_hero/GeneralPage/navigation.dart';
import 'package:fyp_climate_hero/user.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toast/toast.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';

class ActionDetails extends StatefulWidget {
  final Action1 action;
  final User user;

  const ActionDetails({Key key, this.action, this.user, int index})
      : super(key: key);

  @override
  _ActionDetailsState createState() => _ActionDetailsState();
}

class _ActionDetailsState extends State<ActionDetails> {
  String titlecenter = "Loading products...";
  String server = "https://seriouslaa.com/climate_hero";
  double screenHeight, screenWidth;
  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          leading: BackButton(onPressed: () {
            Navigator.of(context).pop();
          }),
          title: Text('Action'),
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.action.name,
                    style: GoogleFonts.oswald(
                      fontSize: 33,
                    )),
                SizedBox(
                  height: 10,
                ),
                Text(widget.action.category,
                    style: GoogleFonts.merriweather(fontSize: 14)),
                SizedBox(
                  height: 8,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: CachedNetworkImage(
                    fit: BoxFit.fill,
                    height: screenHeight / 4.5,
                    width: screenWidth / 0.5,
                    imageUrl:
                        server + "/actionsimages/${widget.action.actionid}.jpg",
                    placeholder: (context, url) =>
                        new CircularProgressIndicator(),
                    errorWidget: (context, url, error) => new Icon(Icons.error),
                  ),
                ),
                SizedBox(height: 15),
                Table(defaultColumnWidth: FlexColumnWidth(1.0), columnWidths: {
                  0: FlexColumnWidth(0.9),
                  1: FlexColumnWidth(1.5),
                }, children: [
                  TableRow(children: [
                    TableCell(
                      child: Container(
                          alignment: Alignment.centerLeft,
                          height: 17,
                          child: Text("Ease",
                              style: GoogleFonts.merriweather(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[600]))),
                    ),
                    TableCell(
                      child: Container(
                        alignment: Alignment.centerLeft,
                        height: 17,
                        child: Text("Vital Sign",
                            style: GoogleFonts.merriweather(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[600])),
                      ),
                    ),
                  ]),
                  TableRow(children: [
                    TableCell(
                      child: Container(
                          alignment: Alignment.centerLeft,
                          height: 22,
                          child: Text(widget.action.ease,
                              style: GoogleFonts.merriweather(
                                  fontSize: 13, color: Colors.black))),
                    ),
                    TableCell(
                      child: Container(
                        alignment: Alignment.centerLeft,
                        height: 22,
                        child: Text(widget.action.vitalsign,
                            style: GoogleFonts.merriweather(
                                fontSize: 13, color: Colors.black)),
                      ),
                    ),
                  ]),
                ]),
                Divider(
                  height: 50,
                  thickness: 5,
                  color: Colors.blue[200],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox.fromSize(
                          size: Size(56, 56),
                          child: ClipOval(
                            child: Material(
                              color: Colors.blue,
                              child: InkWell(
                                splashColor: Colors.grey,
                                onTap: () => _addGoal(),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(
                                      Icons.add,
                                      size: 40,
                                      color: Colors.white,
                                    ), // icon
                                    // text
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 7),
                        Container(
                            width: 60,
                            child: Text("Add to my goal",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.merriweather(
                                    fontSize: 13, color: Colors.black))),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox.fromSize(
                          size: Size(56, 56),
                          child: ClipOval(
                            child: Material(
                              color: Colors.blue,
                              child: InkWell(
                                splashColor: Colors.grey,
                                onTap: () => _savedGoal(),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(
                                      Icons.bookmark_border_outlined,
                                      size: 40,
                                      color: Colors.white,
                                    ), // icon
                                    // text
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 7),
                        Container(
                            width: 60,
                            child: Text("Save for later",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.merriweather(
                                    fontSize: 13, color: Colors.black))),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox.fromSize(
                          size: Size(56, 56),
                          child: ClipOval(
                            child: Material(
                              color: Colors.blue,
                              child: InkWell(
                                splashColor: Colors.grey,
                                onTap: () => _completedGoal(),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(Icons.done,
                                        size: 40, color: Colors.white), // icon
                                    // text
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 7),
                        Container(
                            width: 70,
                            child: Text("Complete the Action",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.merriweather(
                                    fontSize: 13, color: Colors.black))),
                      ],
                    ),
                  ],
                ),
                Divider(
                  height: 50,
                  thickness: 5,
                  color: Colors.blue[200],
                ),
                Text("Description",
                    style: GoogleFonts.abel(
                        fontWeight: FontWeight.bold, fontSize: 30)),
                SizedBox(
                  height: 15,
                ),
                Container(
                  constraints: BoxConstraints(
                    maxHeight: double.infinity,
                  ),
                  child: Column(
                    children: [
                      Text(
                        widget.action.description,
                        softWrap: true,
                        style: GoogleFonts.merriweather(
                          color: Colors.black,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  height: 50,
                  thickness: 5,
                  color: Colors.blue[200],
                ),
                Text("Tips",
                    style: GoogleFonts.abel(
                        fontWeight: FontWeight.bold, fontSize: 30)),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    constraints: BoxConstraints(
                      maxHeight: double.infinity,
                    ),
                    child: Column(
                      children: [
                        Text(
                          widget.action.tips,
                          softWrap: true,
                          style: GoogleFonts.merriweather(
                            color: Colors.black,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _addGoal() {
    http.post(server + "/php/add_goal.php", body: {
      "userid": widget.user.email,
      "actionid": widget.action.actionid,
      "name": widget.action.name,
      "category": widget.action.category,
      "vitalsign": widget.action.vitalsign,
      "ease": widget.action.ease,
      "description": widget.action.description,
      "tips": widget.action.tips,
    }).then((res) {
      print(res.body);

      if (res.body == "found") {
        Toast.show("Action already in your goal!", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        return;
      }
      if (res.body == "success") {
        Toast.show("Let's save the world!", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => NavigationPage(
                      user: widget.user,
                    )));
      } else {
        Toast.show("Failed to add to your goal!", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      }
    }).catchError((err) {
      print(err);
    });
  }

  _savedGoal() {
    http.post(server + "/php/saved_goal.php", body: {
      "userid": widget.user.email,
      "actionid": widget.action.actionid,
      "name": widget.action.name,
      "category": widget.action.category,
      "vitalsign": widget.action.vitalsign,
      "ease": widget.action.ease,
      "description": widget.action.description,
      "tips": widget.action.tips,
    }).then((res) {
      print(res.body);

      if (res.body == "found") {
        Toast.show("You already save the action!", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        return;
      }
      if (res.body == "success") {
        Toast.show("Saved", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => NavigationPage(
                      user: widget.user,
                    )));
      } else {
        Toast.show("Failed to save", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      }
    }).catchError((err) {
      print(err);
    });
  }

  _completedGoal() {
    http.post(server + "/php/completed_goal.php", body: {
      "userid": widget.user.email,
      "actionid": widget.action.actionid,
      "name": widget.action.name,
      "category": widget.action.category,
      "vitalsign": widget.action.vitalsign,
      "ease": widget.action.ease,
      "description": widget.action.description,
      "tips": widget.action.tips,
    }).then((res) {
      print(res.body);

      if (res.body == "found") {
        Toast.show(
            "You already completed the action, Congratulation Hero!", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        return;
      }
      if (res.body == "success") {
        Toast.show("Action has been completed, Congratulation Hero!", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => NavigationPage(
                      user: widget.user,
                    )));
      } else {
        Toast.show("Ops, something wrong!", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      }
    }).catchError((err) {
      print(err);
    });
  }
}
