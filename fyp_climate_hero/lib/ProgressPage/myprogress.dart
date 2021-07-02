import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fyp_climate_hero/Quiz/constants.dart';
import 'package:fyp_climate_hero/Quiz/screens/welcome/welcome_screen.dart';
import 'package:fyp_climate_hero/actionList/actions_in_progress.dart';
import 'package:fyp_climate_hero/actionList/completed_actions.dart';
import 'package:fyp_climate_hero/actionList/saved_action.dart';
import 'package:fyp_climate_hero/ActionPage/actiondetails.dart';
import 'package:fyp_climate_hero/action.dart';
import 'package:fyp_climate_hero/ProfilePage/register.dart';
import 'package:fyp_climate_hero/user.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';

class MyProgress extends StatefulWidget {
  final User user;

  const MyProgress({Key key, this.user}) : super(key: key);
  @override
  _MyProgressState createState() => _MyProgressState();
}

class _MyProgressState extends State<MyProgress>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  double screenHeight, screenWidth;

  List completedactiondata;
  List actiondata;
  List savedgoaldata;
  List addgoaldata;
  List completedactioncategory;

  String titlecenter = "Loading products...";
  String server = "https://seriouslaa.com/climate_hero";
  String totalCompleted = "0";
  String totalAddGoal = "0";
  String totalSavedGoal = "0";
  bool completedVisible = true;
  bool inProgressVisible = true;
  bool savedVisible = true;

  bool _isguest = false;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: 2, vsync: this);
    if (widget.user.email == "guest@climatehero.com") {
      _isguest = true;
    }

    _loadCompletedAction();
    _loadAddGoal();
    _loadSavedGoal();
    _loadAction();
    // _loadCompletedCategory();
  }

  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Container(
        decoration: BoxDecoration(gradient: colorHomeGradient),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Center(
                child: Text(
              'MY PROGRESS',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            )),
            bottom: new TabBar(
                controller: _tabController,
                labelColor: Colors.black,
                unselectedLabelColor: Colors.white,
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorColor: Colors.black,
                tabs: [
                  new Tab(
                    text: "Actions",
                  ),
                  new Tab(
                    text: "My Emissions",
                  ),
                ]),
          ),
          body: new TabBarView(
            controller: _tabController,
            children: <Widget>[
              //Tab Actions
              Column(
                children: <Widget>[
                  actiondata == null
                      ? Container(
                          height: screenHeight / 1.5,
                          child: Center(
                            child: CircularProgressIndicator(
                              backgroundColor: Colors.white,
                            ),
                          ),
                        )
                      : Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              child: GridView.count(
                                scrollDirection: Axis.vertical,
                                crossAxisCount: 1,
                                childAspectRatio: 100 / 80,
                                children: List.generate(
                                  actiondata.length,
                                  (index) {
                                    return InkWell(
                                      // ignore: sdk_version_set_literal
                                      onTap: () => _actionDetails(index),
                                      child: Card(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Column(
                                            children: [
                                              Center(
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  10),
                                                          topRight:
                                                              Radius.circular(
                                                                  10)),
                                                  child: CachedNetworkImage(
                                                    fit: BoxFit.cover,
                                                    height: 155,
                                                    width: screenWidth,
                                                    imageUrl: server +
                                                        "/actionsimages/${actiondata[index]['id']}.jpg",
                                                    placeholder: (context,
                                                            url) =>
                                                        new CircularProgressIndicator(),
                                                    errorWidget: (context, url,
                                                            error) =>
                                                        new Icon(Icons.error),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        8, 3, 0, 0),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      actiondata[index]['name'],
                                                      style: GoogleFonts.oswald(
                                                          fontSize: 25),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        9, 10, 9, 0),
                                                child: Table(
                                                    defaultColumnWidth:
                                                        FlexColumnWidth(1.0),
                                                    columnWidths: {
                                                      0: FlexColumnWidth(0.9),
                                                      1: FlexColumnWidth(1.5),
                                                      2: FlexColumnWidth(1.2),
                                                    },

                                                    //border: TableBorder.all(color: Colors.white),
                                                    children: [
                                                      TableRow(children: [
                                                        TableCell(
                                                          child: Container(
                                                              alignment: Alignment
                                                                  .centerLeft,
                                                              height: 17,
                                                              child: Text(
                                                                  "Ease",
                                                                  style: GoogleFonts.merriweather(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      color: Colors
                                                                              .grey[
                                                                          600]))),
                                                        ),
                                                        TableCell(
                                                          child: Container(
                                                            alignment: Alignment
                                                                .centerLeft,
                                                            height: 17,
                                                            child: Text(
                                                                "Vital Sign",
                                                                style: GoogleFonts.merriweather(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                            .grey[
                                                                        600])),
                                                          ),
                                                        ),
                                                        TableCell(
                                                          child: Container(
                                                            alignment: Alignment
                                                                .centerLeft,
                                                            height: 17,
                                                            child: Text(
                                                                "Category",
                                                                style: GoogleFonts.merriweather(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                            .grey[
                                                                        600])),
                                                          ),
                                                        ),
                                                      ]),
                                                      TableRow(children: [
                                                        TableCell(
                                                          child: Container(
                                                              alignment: Alignment
                                                                  .centerLeft,
                                                              height: 22,
                                                              child: Text(
                                                                  actiondata[
                                                                          index]
                                                                      ['ease'],
                                                                  style: GoogleFonts.merriweather(
                                                                      fontSize: 13,
                                                                      // fontWeight:
                                                                      //     FontWeight
                                                                      //         .bold,
                                                                      color: Colors.black))),
                                                        ),
                                                        TableCell(
                                                          child: Container(
                                                            alignment: Alignment
                                                                .centerLeft,
                                                            height: 22,
                                                            child: Text(
                                                                actiondata[
                                                                        index][
                                                                    'vitalsign'],
                                                                style: GoogleFonts
                                                                    .merriweather(
                                                                        fontSize:
                                                                            13,
                                                                        color: Colors
                                                                            .black)),
                                                          ),
                                                        ),
                                                        TableCell(
                                                          child: Container(
                                                            alignment: Alignment
                                                                .centerLeft,
                                                            height: 22,
                                                            child: Text(
                                                                actiondata[
                                                                        index][
                                                                    'category'],
                                                                style: GoogleFonts
                                                                    .merriweather(
                                                                        fontSize:
                                                                            13,
                                                                        color: Colors
                                                                            .black)),
                                                          ),
                                                        ),
                                                      ]),
                                                    ]),
                                              ),
                                            ],
                                          )),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                ],
              ),

              //Tab My Emissions
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: _isguest
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: screenHeight / 4,
                            ),
                            Text(
                              "Register to use more features.",
                              style: GoogleFonts.oswald(
                                color: Colors.black,
                                fontSize: 26,
                              ),
                            ),
                            Text(
                              "Join us now!",
                              style: GoogleFonts.oswald(
                                color: Colors.black,
                                fontSize: 26,
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              height: 50,
                              width: screenWidth / 3,
                              child: MaterialButton(
                                  // elevation: 10,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Text('Register now',
                                      style: TextStyle(
                                        color: Colors.black,
                                      )),
                                  color: Colors.white,
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                Register()));
                                  }),
                            ),
                          ],
                        ),
                      )
                    : Column(
                        children: <Widget>[
                          //Quizzes
                          SizedBox(
                            height: 20.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(25, 0, 20, 0),
                            child: Text('Try to challenge your knowledge!',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 10,
                                softWrap: false,
                                style: GoogleFonts.oswald(
                                  fontSize: 30,
                                )),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          WelcomeScreen(
                                            user: widget.user,
                                          )));
                            },
                            child: SizedBox(
                              width: screenWidth / 1.2,
                              height: screenHeight / 6,
                              child: Card(
                                color: Colors.white,
                                elevation: 10,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 10, 0, 8),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.question_answer_outlined,
                                            size: 40,
                                            color: Colors.red,
                                          ),
                                          Text(
                                            "Quizzes",
                                            style: TextStyle(fontSize: 18),
                                          )
                                        ],
                                      ),
                                    ),
                                    Text(
                                      "Let's Play!",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 30),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),

                          // Completed Actions
                          Row(
                            // mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                    "   Completed Actions" +
                                        " (" +
                                        totalCompleted +
                                        ")",
                                    style: GoogleFonts.oswald(
                                      fontSize: 25,
                                    )),
                              ),
                              InkWell(
                                // ignore: sdk_version_set_literal
                                onTap: () => {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              CompletedActions(
                                                  user: widget.user)))
                                },
                                child: Text(
                                  "See More    ",
                                  style: TextStyle(color: Colors.black),
                                ),
                              )
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              completedactiondata == null
                                  ? Container(
                                      height: 50,
                                      width: screenWidth / 1.12,
                                      child: Container(
                                          color: Colors.transparent,
                                          child: Center(
                                              child: Text(
                                            titlecenter,
                                            style: TextStyle(
                                                color: Colors.red,
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                          ))))
                                  : Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                          height: 128,
                                          child: GridView.count(
                                              scrollDirection: Axis.horizontal,
                                              crossAxisCount: 1,
                                              childAspectRatio: 0.37,
                                              children: List.generate(
                                                  completedactiondata.length,
                                                  (index) {
                                                return Card(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10)),
                                                    elevation: 2,
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      9.0),
                                                          child:
                                                              CachedNetworkImage(
                                                            fit: BoxFit.cover,
                                                            height: 120,
                                                            width: 120,
                                                            imageUrl: server +
                                                                "/actionsimages/${completedactiondata[index]['id']}.jpg",
                                                            placeholder: (context,
                                                                    url) =>
                                                                new CircularProgressIndicator(),
                                                            errorWidget: (context,
                                                                    url,
                                                                    error) =>
                                                                new Icon(Icons
                                                                    .error),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .fromLTRB(
                                                                  8, 0, 0, 0),
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceEvenly,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Container(
                                                                width: 203,
                                                                child: Text(
                                                                    completedactiondata[
                                                                            index]
                                                                        [
                                                                        'name'],
                                                                    textAlign:
                                                                        TextAlign
                                                                            .left,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .clip,
                                                                    maxLines:
                                                                        10,
                                                                    style: GoogleFonts.oswald(
                                                                        fontSize:
                                                                            18)),
                                                              ),
                                                              Container(
                                                                width:
                                                                    screenWidth /
                                                                        1.9,
                                                                child: Table(
                                                                    defaultColumnWidth:
                                                                        FlexColumnWidth(
                                                                            1.0),
                                                                    columnWidths: {
                                                                      0: FlexColumnWidth(
                                                                          5),
                                                                      1: FlexColumnWidth(
                                                                          8),
                                                                    },

                                                                    //border: TableBorder.all(color: Colors.white),
                                                                    children: [
                                                                      TableRow(
                                                                          children: [
                                                                            TableCell(
                                                                              child: Container(alignment: Alignment.centerLeft, height: 17, child: Text("Ease", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black))),
                                                                            ),
                                                                            TableCell(
                                                                              child: Container(
                                                                                alignment: Alignment.centerLeft,
                                                                                height: 17,
                                                                                child: Text(": " + completedactiondata[index]['ease'],
                                                                                    style: TextStyle(
                                                                                        // fontWeight: FontWeight.bold,
                                                                                        color: Colors.black)),
                                                                              ),
                                                                            ),
                                                                          ]),
                                                                      TableRow(
                                                                          children: [
                                                                            TableCell(
                                                                              child: Container(alignment: Alignment.centerLeft, height: 17, child: Text("Vital Sign", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black))),
                                                                            ),
                                                                            TableCell(
                                                                              child: Container(
                                                                                alignment: Alignment.centerLeft,
                                                                                height: 17,
                                                                                child: Text(": " + completedactiondata[index]['vitalsign'],
                                                                                    style: TextStyle(
                                                                                        // fontWeight: FontWeight.bold,
                                                                                        color: Colors.black)),
                                                                              ),
                                                                            ),
                                                                          ]),
                                                                      TableRow(
                                                                          children: [
                                                                            TableCell(
                                                                              child: Container(alignment: Alignment.centerLeft, height: 17, child: Text("Category", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black))),
                                                                            ),
                                                                            TableCell(
                                                                              child: Container(
                                                                                alignment: Alignment.centerLeft,
                                                                                height: 17,
                                                                                child: Text(": " + completedactiondata[index]['category'],
                                                                                    style: TextStyle(
                                                                                        // fontWeight: FontWeight.bold,
                                                                                        color: Colors.black)),
                                                                              ),
                                                                            ),
                                                                          ]),
                                                                    ]),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ));
                                              }))),
                                    )
                            ],
                          ),
                          SizedBox(
                            height: 25,
                          ),

                          //Actions In Progress
                          Row(
                            // mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                    "   Actions in progress (" +
                                        totalAddGoal +
                                        ")",
                                    style: GoogleFonts.oswald(fontSize: 25)),
                              ),
                              GestureDetector(
                                // ignore: sdk_version_set_literal
                                onTap: () => {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              ActionInProgress(
                                                  user: widget.user)))
                                },
                                child: Text(
                                  "See More    ",
                                  style: TextStyle(color: Colors.black),
                                ),
                              )
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              addgoaldata == null
                                  ? Container(
                                      height: 50,
                                      width: screenWidth / 1.12,
                                      child: Container(
                                          color: Colors.transparent,
                                          child: Center(
                                              child: Text(
                                            titlecenter,
                                            style: TextStyle(
                                                color: Colors.red,
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                          ))))
                                  : Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                          height: 128,
                                          child: GridView.count(
                                              scrollDirection: Axis.horizontal,
                                              crossAxisCount: 1,
                                              childAspectRatio: 0.37,
                                              children: List.generate(
                                                  addgoaldata.length, (index) {
                                                return Card(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10)),
                                                    elevation: 2,
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      9.0),
                                                          child:
                                                              CachedNetworkImage(
                                                            fit: BoxFit.cover,
                                                            height: 120,
                                                            width: 120,
                                                            imageUrl: server +
                                                                "/actionsimages/${addgoaldata[index]['id']}.jpg",
                                                            placeholder: (context,
                                                                    url) =>
                                                                new CircularProgressIndicator(),
                                                            errorWidget: (context,
                                                                    url,
                                                                    error) =>
                                                                new Icon(Icons
                                                                    .error),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .fromLTRB(
                                                                  8, 0, 0, 0),
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceEvenly,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Container(
                                                                width: 203,
                                                                child: Text(
                                                                    addgoaldata[
                                                                            index]
                                                                        [
                                                                        'name'],
                                                                    textAlign:
                                                                        TextAlign
                                                                            .left,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .clip,
                                                                    maxLines:
                                                                        10,
                                                                    style: GoogleFonts.oswald(
                                                                        fontSize:
                                                                            18)),
                                                              ),
                                                              Container(
                                                                width:
                                                                    screenWidth /
                                                                        1.9,
                                                                child: Table(
                                                                    defaultColumnWidth:
                                                                        FlexColumnWidth(
                                                                            1.0),
                                                                    columnWidths: {
                                                                      0: FlexColumnWidth(
                                                                          5),
                                                                      1: FlexColumnWidth(
                                                                          8),
                                                                    },

                                                                    //border: TableBorder.all(color: Colors.white),
                                                                    children: [
                                                                      TableRow(
                                                                          children: [
                                                                            TableCell(
                                                                              child: Container(alignment: Alignment.centerLeft, height: 17, child: Text("Ease", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black))),
                                                                            ),
                                                                            TableCell(
                                                                              child: Container(
                                                                                alignment: Alignment.centerLeft,
                                                                                height: 17,
                                                                                child: Text(": " + addgoaldata[index]['ease'],
                                                                                    style: TextStyle(
                                                                                        // fontWeight: FontWeight.bold,
                                                                                        color: Colors.black)),
                                                                              ),
                                                                            ),
                                                                          ]),
                                                                      TableRow(
                                                                          children: [
                                                                            TableCell(
                                                                              child: Container(alignment: Alignment.centerLeft, height: 17, child: Text("Vital Sign", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black))),
                                                                            ),
                                                                            TableCell(
                                                                              child: Container(
                                                                                alignment: Alignment.centerLeft,
                                                                                height: 17,
                                                                                child: Text(": " + addgoaldata[index]['vitalsign'],
                                                                                    style: TextStyle(
                                                                                        // fontWeight: FontWeight.bold,
                                                                                        color: Colors.black)),
                                                                              ),
                                                                            ),
                                                                          ]),
                                                                      TableRow(
                                                                          children: [
                                                                            TableCell(
                                                                              child: Container(alignment: Alignment.centerLeft, height: 17, child: Text("Category", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black))),
                                                                            ),
                                                                            TableCell(
                                                                              child: Container(
                                                                                alignment: Alignment.centerLeft,
                                                                                height: 17,
                                                                                child: Text(": " + addgoaldata[index]['category'],
                                                                                    style: TextStyle(
                                                                                        // fontWeight: FontWeight.bold,
                                                                                        color: Colors.black)),
                                                                              ),
                                                                            ),
                                                                          ]),
                                                                    ]),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ));
                                              }))),
                                    )
                            ],
                          ),
                          SizedBox(
                            height: 25,
                          ),

                          //Saved Action
                          Row(
                            // mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                    "   Saved Actions (" + totalSavedGoal + ")",
                                    style: GoogleFonts.oswald(
                                      fontSize: 25,
                                    )),
                              ),
                              GestureDetector(
                                // ignore: sdk_version_set_literal
                                onTap: () => {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              SavedActions(
                                                user: widget.user,
                                              )))
                                },
                                child: Text(
                                  "See More    ",
                                  style: TextStyle(color: Colors.black),
                                ),
                              )
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              savedgoaldata == null
                                  ? Container(
                                      height: 50,
                                      width: screenWidth / 1.12,
                                      child: Container(
                                          color: Colors.transparent,
                                          child: Center(
                                              child: Text(
                                            titlecenter,
                                            style: TextStyle(
                                                color: Colors.red,
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                          ))))
                                  : Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                          height: 128,
                                          child: GridView.count(
                                              scrollDirection: Axis.horizontal,
                                              crossAxisCount: 1,
                                              childAspectRatio: 0.37,
                                              children: List.generate(
                                                  savedgoaldata.length,
                                                  (index) {
                                                return Card(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10)),
                                                    elevation: 2,
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      9.0),
                                                          child:
                                                              CachedNetworkImage(
                                                            fit: BoxFit.cover,
                                                            height: 120,
                                                            width: 120,
                                                            imageUrl: server +
                                                                "/actionsimages/${savedgoaldata[index]['id']}.jpg",
                                                            placeholder: (context,
                                                                    url) =>
                                                                new CircularProgressIndicator(),
                                                            errorWidget: (context,
                                                                    url,
                                                                    error) =>
                                                                new Icon(Icons
                                                                    .error),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .fromLTRB(
                                                                  8, 0, 0, 0),
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceEvenly,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Container(
                                                                width: 203,
                                                                child: Text(
                                                                    savedgoaldata[
                                                                            index]
                                                                        [
                                                                        'name'],
                                                                    textAlign:
                                                                        TextAlign
                                                                            .left,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .clip,
                                                                    maxLines:
                                                                        10,
                                                                    style: GoogleFonts.oswald(
                                                                        fontSize:
                                                                            18)),
                                                              ),
                                                              Container(
                                                                width:
                                                                    screenWidth /
                                                                        1.9,
                                                                child: Table(
                                                                    defaultColumnWidth:
                                                                        FlexColumnWidth(
                                                                            1.0),
                                                                    columnWidths: {
                                                                      0: FlexColumnWidth(
                                                                          5),
                                                                      1: FlexColumnWidth(
                                                                          8),
                                                                    },

                                                                    //border: TableBorder.all(color: Colors.white),
                                                                    children: [
                                                                      TableRow(
                                                                          children: [
                                                                            TableCell(
                                                                              child: Container(alignment: Alignment.centerLeft, height: 17, child: Text("Ease", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black))),
                                                                            ),
                                                                            TableCell(
                                                                              child: Container(
                                                                                alignment: Alignment.centerLeft,
                                                                                height: 17,
                                                                                child: Text(": " + savedgoaldata[index]['ease'],
                                                                                    style: TextStyle(
                                                                                        // fontWeight: FontWeight.bold,
                                                                                        color: Colors.black)),
                                                                              ),
                                                                            ),
                                                                          ]),
                                                                      TableRow(
                                                                          children: [
                                                                            TableCell(
                                                                              child: Container(alignment: Alignment.centerLeft, height: 17, child: Text("Vital Sign", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black))),
                                                                            ),
                                                                            TableCell(
                                                                              child: Container(
                                                                                alignment: Alignment.centerLeft,
                                                                                height: 17,
                                                                                child: Text(": " + savedgoaldata[index]['vitalsign'],
                                                                                    style: TextStyle(
                                                                                        // fontWeight: FontWeight.bold,
                                                                                        color: Colors.black)),
                                                                              ),
                                                                            ),
                                                                          ]),
                                                                      TableRow(
                                                                          children: [
                                                                            TableCell(
                                                                              child: Container(alignment: Alignment.centerLeft, height: 17, child: Text("Category", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black))),
                                                                            ),
                                                                            TableCell(
                                                                              child: Container(
                                                                                alignment: Alignment.centerLeft,
                                                                                height: 17,
                                                                                child: Text(": " + savedgoaldata[index]['category'],
                                                                                    style: TextStyle(
                                                                                        // fontWeight: FontWeight.bold,
                                                                                        color: Colors.black)),
                                                                              ),
                                                                            ),
                                                                          ]),
                                                                    ]),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ));
                                              }))),
                                    )
                            ],
                          ),
                          SizedBox(
                            height: 30.0,
                          ),
                        ],
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _loadAddGoal() {
    String urlLoadJobs = server + "/php/load_add_goal.php";
    http.post(urlLoadJobs, body: {
      "email": widget.user.email,
    }).then((res) {
      if (res.body == "nodata") {
        setState(() {
          titlecenter = "No action available";
        });
      } else {
        setState(() {
          var extractdata1 = json.decode(res.body);
          addgoaldata = extractdata1["add_goals"];
          totalAddGoal = addgoaldata.length.toString();
          print(extractdata1);
        });
      }
    }).catchError((err) {
      print(err);
    });
  }

  _loadSavedGoal() {
    String urlLoadJobs = server + "/php/load_saved_goal.php";
    http.post(urlLoadJobs, body: {
      "email": widget.user.email,
    }).then((res) {
      if (res.body == "nodata") {
        // print(res.body);
        setState(() {
          titlecenter = "No action available";
        });
      } else {
        setState(() {
          var extractdata3 = json.decode(res.body);
          savedgoaldata = extractdata3["saved_goals"];
          totalSavedGoal = savedgoaldata.length.toString();
          print(extractdata3);
        });
      }
    }).catchError((err) {
      print(err);
    });
  }

  _loadCompletedAction() {
    String urlLoadJobs = server + "/php/load_completed_action.php";
    http.post(urlLoadJobs, body: {
      "email": widget.user.email,
    }).then((res) {
      if (res.body == "nodata") {
        // print(res.body);

        setState(() {
          titlecenter = "No action available";
        });
      } else {
        setState(() {
          var extractdata = json.decode(res.body);
          completedactiondata = extractdata["completed_actions"];
          totalCompleted = completedactiondata.length.toString();
          print(extractdata);
        });
      }
    }).catchError((err) {
      print(err);
    });
  }

  _loadAction() {
    String urlLoadJobs = server + "/php/load_action.php";
    http.post(urlLoadJobs, body: {}).then((res) {
      if (res.body == "nodata") {
        setState(() {
          titlecenter = "No action available";
        });
      } else {
        setState(() {
          var extractdata = json.decode(res.body);
          actiondata = extractdata["actions"];
          print(extractdata);
        });
      }
    }).catchError((err) {
      print(err);
    });
  }

  _actionDetails(int index) async {
    Action1 _actionData = new Action1(
        actionid: actiondata[index]['id'],
        name: actiondata[index]['name'],
        category: actiondata[index]['category'],
        vitalsign: actiondata[index]['vitalsign'],
        ease: actiondata[index]['ease'],
        description: actiondata[index]['description'],
        tips: actiondata[index]['tips']);

    if (_isguest) {
      showDialog(
        context: context,
        builder: (context) => new AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          title: new Text(
            'Please register to use this feature.',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          actions: [
            MaterialButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => Register()));
                },
                child: Text(
                  "Register now",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                )),
            MaterialButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: Text(
                  "Cancel",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                )),
          ],
        ),
      );
    } else {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => ActionDetails(
                    action: _actionData,
                    user: widget.user,
                  )));
    }
  }
}
