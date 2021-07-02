import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:fyp_climate_hero/Admin/adminActionDetails.dart';
import 'package:fyp_climate_hero/Admin/adminAddActions.dart';
import 'package:fyp_climate_hero/Admin/adminpage.dart';
import 'package:fyp_climate_hero/Quiz/constants.dart';
import 'package:fyp_climate_hero/actionAdmin.dart';
import 'package:fyp_climate_hero/user.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:toast/toast.dart';

class ManageActions extends StatefulWidget {
  final User user;

  const ManageActions({Key key, this.user}) : super(key: key);
  @override
  _ManageActionsState createState() => _ManageActionsState();
}

class _ManageActionsState extends State<ManageActions> {
  List actiondata;
  String titlecenter = "Loading products...";
  String server = "https://seriouslaa.com/climate_hero";
  double screenHeight, screenWidth;

  @override
  void initState() {
    super.initState();

    _loadAction();
    // _loadCompletedCategory();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Actions Management',
      home: Scaffold(
        appBar: AppBar(
          leading: BackButton(onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => AdminPage(
                          user: widget.user,
                        )));
          }),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Actions Management'),
              IconButton(
                  icon: Icon(Icons.add, size: 40),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => AdminAddActions(
                                  user: widget.user,
                                )));
                  })
            ],
          ),
        ),
        body: Container(
          decoration: BoxDecoration(gradient: colorHomeGradient),
          child: Column(
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
                          // height: 100,
                          child: GridView.count(
                            scrollDirection: Axis.vertical,
                            crossAxisCount: 1,
                            childAspectRatio: 100 / 91,
                            children: List.generate(
                              actiondata.length,
                              (index) {
                                return Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Column(
                                      children: [
                                        Center(
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(10),
                                                topRight: Radius.circular(10)),
                                            child: CachedNetworkImage(
                                              fit: BoxFit.cover,
                                              height: 155,
                                              width: screenWidth,
                                              imageUrl: server +
                                                  "/actionsimages/${actiondata[index]['id']}.jpg",
                                              placeholder: (context, url) => Center(
                                                  child:
                                                      new CircularProgressIndicator()),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      new Icon(Icons.error),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
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
                                          padding: const EdgeInsets.fromLTRB(
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
                                                        child: Text("Ease",
                                                            style: GoogleFonts
                                                                .merriweather(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                            .grey[
                                                                        600]))),
                                                  ),
                                                  TableCell(
                                                    child: Container(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      height: 17,
                                                      child: Text("Vital Sign",
                                                          style: GoogleFonts
                                                              .merriweather(
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
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      height: 17,
                                                      child: Text("Category",
                                                          style: GoogleFonts
                                                              .merriweather(
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
                                                            actiondata[index]
                                                                ['ease'],
                                                            style: GoogleFonts
                                                                .merriweather(
                                                                    fontSize:
                                                                        13,
                                                                    color: Colors
                                                                        .black))),
                                                  ),
                                                  TableCell(
                                                    child: Container(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      height: 22,
                                                      child: Text(
                                                          actiondata[index]
                                                              ['vitalsign'],
                                                          style: GoogleFonts
                                                              .merriweather(
                                                                  fontSize: 13,
                                                                  color: Colors
                                                                      .black)),
                                                    ),
                                                  ),
                                                  TableCell(
                                                    child: Container(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      height: 22,
                                                      child: Text(
                                                          actiondata[index]
                                                              ['category'],
                                                          style: GoogleFonts
                                                              .merriweather(
                                                                  fontSize: 13,
                                                                  color: Colors
                                                                      .black)),
                                                    ),
                                                  ),
                                                ]),
                                              ]),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        8, 2, 8, 10),
                                                child: Container(
                                                  child: MaterialButton(
                                                    minWidth: 150,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                    ),
                                                    child: Text('Manage',
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                        )),
                                                    color: Colors.yellow,
                                                    onPressed: () =>
                                                        actionDetails(index),
                                                  ),
                                                )),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      8, 2, 8, 10),
                                              child: MaterialButton(
                                                minWidth: 150,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                ),
                                                child: Text('Delete',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                    )),
                                                color: Colors.red,
                                                onPressed: () =>
                                                    _deleteDialog(index),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ));
                              },
                            ),
                          ),
                        ),
                      ),
                    )
            ],
          ),
        ),
      ),
    );
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

  void actionDetails(int index) {
    ActionAdmin _actionData = new ActionAdmin(
        actionid: actiondata[index]['id'],
        name: actiondata[index]['name'],
        category: actiondata[index]['category'],
        vitalsign: actiondata[index]['vitalsign'],
        ease: actiondata[index]['ease'],
        description: actiondata[index]['description'],
        tips: actiondata[index]['tips']);

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => AdminActionDetails(
                  action: _actionData,
                  user: widget.user,
                )));
  }

  _deleteDialog(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          title: new Text("Delete the action? ",
              style: GoogleFonts.merriweather(fontSize: 14)),
          content: new Text("Are you sure?",
              style: GoogleFonts.merriweather(fontSize: 14)),
          actions: <Widget>[
            // ignore: deprecated_member_use
            new FlatButton(
              child: new Text("Yes",
                  style: GoogleFonts.merriweather(fontSize: 14)),
              onPressed: () {
                ProgressDialog pr = new ProgressDialog(context,
                    type: ProgressDialogType.Normal, isDismissible: false);
                pr.style(message: "Deleting action...");
                pr.show();

                http.post(server + "/php/delete_actions.php", body: {
                  "actionid": actiondata[index]['id'],
                }).then((res) {
                  print(res.body);
                  pr.hide();
                  if (res.body == "success") {
                    Toast.show("Action Deleted.", context,
                        duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                    // _loadData();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => ManageActions(
                                  user: widget.user,
                                )));
                  } else {
                    Toast.show("Failed to delete.", context,
                        duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                  }
                }).catchError((err) {
                  print(err);
                  pr.hide();
                });
              },
            ),
            // ignore: deprecated_member_use
            new FlatButton(
              child:
                  new Text("No", style: GoogleFonts.merriweather(fontSize: 14)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
