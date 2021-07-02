import 'dart:convert';
import 'package:fyp_climate_hero/action.dart';
import 'package:fyp_climate_hero/ActionPage/actiondetails.dart';
import 'package:fyp_climate_hero/user.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CompletedActions extends StatefulWidget {
  final User user;
  const CompletedActions({Key key, this.user}) : super(key: key);

  @override
  _CompletedActionsState createState() => _CompletedActionsState();
}

class _CompletedActionsState extends State<CompletedActions> {
  List completedactiondata;
  String titlecenter = "Loading products...";
  String server = "https://seriouslaa.com/climate_hero";
  String totalCompleted = "0";
  double screenHeight, screenWidth;

  @override
  void initState() {
    super.initState();

    _loadCompletedAction();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.blue, Colors.white])),
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            leading: BackButton(onPressed: () {
              Navigator.of(context).pop();
            }),
            title: Text('Completed Actions'),
          ),
          body: Column(
            children: <Widget>[
              completedactiondata == null
                  ? Container(
                      height: screenHeight / 1.5,
                      width: screenWidth,
                      child: Center(
                          child: Text(
                        titlecenter,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                      )))
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          height: screenHeight / 1.16,
                          child: GridView.count(
                              scrollDirection: Axis.vertical,
                              crossAxisCount: 1,
                              childAspectRatio: 100 / 37.3,
                              children: List.generate(
                                  completedactiondata.length, (index) {
                                return InkWell(
                                  onTap: () => _actionDetails(index),
                                  child: Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      elevation: 2,
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(9.0),
                                            child: CachedNetworkImage(
                                              fit: BoxFit.cover,
                                              height: 120,
                                              width: 120,
                                              imageUrl: server +
                                                  "/actionsimages/${completedactiondata[index]['id']}.jpg",
                                              placeholder: (context, url) =>
                                                  new CircularProgressIndicator(),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      new Icon(Icons.error),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                8, 0, 0, 0),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  width: 203,
                                                  child: Text(
                                                      completedactiondata[index]
                                                          ['name'],
                                                      textAlign: TextAlign.left,
                                                      overflow:
                                                          TextOverflow.clip,
                                                      maxLines: 10,
                                                      style: GoogleFonts.oswald(
                                                          fontSize: 18)),
                                                ),
                                                Container(
                                                  width: screenWidth / 1.9,
                                                  child: Table(
                                                      defaultColumnWidth:
                                                          FlexColumnWidth(1.0),
                                                      columnWidths: {
                                                        0: FlexColumnWidth(5),
                                                        1: FlexColumnWidth(8),
                                                      },
                                                      children: [
                                                        TableRow(children: [
                                                          TableCell(
                                                            child: Container(
                                                                alignment: Alignment
                                                                    .centerLeft,
                                                                height: 17,
                                                                child: Text(
                                                                    "Ease",
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        color: Colors
                                                                            .black))),
                                                          ),
                                                          TableCell(
                                                            child: Container(
                                                              alignment: Alignment
                                                                  .centerLeft,
                                                              height: 17,
                                                              child: Text(
                                                                  ": " +
                                                                      completedactiondata[
                                                                              index]
                                                                          [
                                                                          'ease'],
                                                                  style: TextStyle(
                                                                      // fontWeight: FontWeight.bold,
                                                                      color: Colors.black)),
                                                            ),
                                                          ),
                                                        ]),
                                                        TableRow(children: [
                                                          TableCell(
                                                            child: Container(
                                                                alignment: Alignment
                                                                    .centerLeft,
                                                                height: 17,
                                                                child: Text(
                                                                    "Vital Sign",
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        color: Colors
                                                                            .black))),
                                                          ),
                                                          TableCell(
                                                            child: Container(
                                                              alignment: Alignment
                                                                  .centerLeft,
                                                              height: 17,
                                                              child: Text(
                                                                  ": " +
                                                                      completedactiondata[
                                                                              index]
                                                                          [
                                                                          'vitalsign'],
                                                                  style: TextStyle(
                                                                      // fontWeight: FontWeight.bold,
                                                                      color: Colors.black)),
                                                            ),
                                                          ),
                                                        ]),
                                                        TableRow(children: [
                                                          TableCell(
                                                            child: Container(
                                                                alignment: Alignment
                                                                    .centerLeft,
                                                                height: 17,
                                                                child: Text(
                                                                    "Category",
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        color: Colors
                                                                            .black))),
                                                          ),
                                                          TableCell(
                                                            child: Container(
                                                              alignment: Alignment
                                                                  .centerLeft,
                                                              height: 17,
                                                              child: Text(
                                                                  ": " +
                                                                      completedactiondata[
                                                                              index]
                                                                          [
                                                                          'category'],
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
                                      )),
                                );
                              }))),
                    )
            ],
          ),
        ),
      ),
    );
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

  _actionDetails(int index) async {
    Action1 _actionData = new Action1(
        actionid: completedactiondata[index]['id'],
        name: completedactiondata[index]['name'],
        category: completedactiondata[index]['category'],
        vitalsign: completedactiondata[index]['vitalsign'],
        ease: completedactiondata[index]['ease'],
        description: completedactiondata[index]['description'],
        tips: completedactiondata[index]['tips']);

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => ActionDetails(
                  action: _actionData,
                  user: widget.user,
                )));
  }
}
