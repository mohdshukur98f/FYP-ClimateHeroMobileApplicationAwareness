import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard>
    with SingleTickerProviderStateMixin {
  double screenHeight, screenWidth;
  String server = "https://seriouslaa.com/climate_hero";
  TabController _tabController;

  //ArrayList
  List loadVitalCO2;
  List loadTempt;
  List loadSeaLevel;
  List loadArcticIce;

  @override
  void initState() {
    super.initState();
    _loadArcticIce();
    _loadVitalCO2();
    _loadTempt();
    _loadSeaLevel();
    _tabController = new TabController(length: 4, vsync: this);
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
          decoration: BoxDecoration(color: Colors.blueGrey[50]),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              title: Center(
                  child: Text(
                'Vital Sign',
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
            ),
            body: loadArcticIce == null ||
                    loadTempt == null ||
                    loadSeaLevel == null ||
                    loadArcticIce == null
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Column(
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                          child: GridView.count(
                            crossAxisCount: 2,
                            childAspectRatio: 1,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: ShapeDecoration(
                                    gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [
                                          Colors.purpleAccent,
                                          Colors.purple[800]
                                        ]),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0)),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            loadVitalCO2[1]["DATA_CO2"] == null
                                                ? "Loading"
                                                : loadVitalCO2[1]["DATA_CO2"],
                                            style: TextStyle(
                                                // fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 23),
                                          ),
                                          Text(
                                            " PPM",
                                            style: TextStyle(
                                                // fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        "Carbon Dioxide",
                                        style: TextStyle(
                                            // fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            fontSize: 15),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: ShapeDecoration(
                                    gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [
                                          Colors.lightBlue[300],
                                          Colors.lightBlueAccent[700]
                                        ]),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0)),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            loadTempt[1]["CELSIUS"] == null
                                                ? "Loading"
                                                : loadTempt[1]["CELSIUS"],
                                            style: TextStyle(
                                                // fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 23),
                                          ),
                                          Text(
                                            " °​C",
                                            style: TextStyle(
                                                // fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        "Global Sea",
                                        style: TextStyle(
                                            // fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            fontSize: 15),
                                      ),
                                      Text(
                                        "Temperature",
                                        style: TextStyle(
                                            // fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            fontSize: 15),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: ShapeDecoration(
                                    gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [
                                          Colors.redAccent[200],
                                          Colors.red[800]
                                        ]),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0)),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        loadSeaLevel[1]["SEALEVEL"] == null
                                            ? "Loading"
                                            : loadSeaLevel[1]["SEALEVEL"],
                                        style: TextStyle(
                                            // fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 23),
                                      ),
                                      Text(
                                        "(± 4.0) mm",
                                        style: TextStyle(
                                            // fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15),
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        "Sea Level",
                                        style: TextStyle(
                                            // fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            fontSize: 15),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: ShapeDecoration(
                                    gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          Colors.greenAccent,
                                          Colors.green[500]
                                        ]),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0)),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            loadArcticIce[1]
                                                        ["DATA_ARCTICSEAICE"] ==
                                                    null
                                                ? "Loading" + " PPM"
                                                : loadArcticIce[1]
                                                    ["DATA_ARCTICSEAICE"],
                                            style: TextStyle(
                                                // fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 23),
                                          ),
                                          Text(
                                            "% /dec",
                                            style: TextStyle(
                                                // fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        "Arctic Sea Ice",
                                        style: TextStyle(
                                            // fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            fontSize: 15),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: 40,
                        color: Colors.white,
                        child: new TabBar(
                            controller: _tabController,
                            labelColor: Colors.black,
                            unselectedLabelColor: Colors.grey,
                            indicatorSize: TabBarIndicatorSize.tab,
                            indicatorColor: Colors.blue,
                            tabs: [
                              new Tab(
                                text: "Co2",
                              ),
                              new Tab(
                                text: "°​C",
                              ),
                              new Tab(
                                text: "mm",
                              ),
                              new Tab(
                                text: "/dec",
                              ),
                            ]),
                      ),
                      Container(
                        color: Colors.white,
                        height: screenHeight / 3,
                        child: TabBarView(
                          controller: _tabController,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                              child: SingleChildScrollView(
                                child: ListBody(
                                  children: <Widget>[
                                    Divider(
                                      color: Colors.black,
                                    ),
                                    Table(
                                        defaultColumnWidth:
                                            FlexColumnWidth(10.0),
                                        columnWidths: {
                                          0: FlexColumnWidth(10.5),
                                          1: FlexColumnWidth(15.5),
                                          2: FlexColumnWidth(10.5),
                                        },
                                        children: [
                                          TableRow(children: [
                                            TableCell(
                                              child: Container(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  height: 20,
                                                  child: Text("YEAR",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color:
                                                              Colors.black))),
                                            ),
                                            TableCell(
                                              child: Container(
                                                alignment: Alignment.centerLeft,
                                                height: 20,
                                                child: Text("MONTH",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 14,
                                                        color: Colors.black)),
                                              ),
                                            ),
                                            TableCell(
                                              child: Container(
                                                alignment: Alignment.centerLeft,
                                                height: 20,
                                                child: Text("CO2",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 14,
                                                        color: Colors.black)),
                                              ),
                                            ),
                                          ])
                                        ]),
                                    Divider(
                                      color: Colors.black,
                                    ),
                                    Table(
                                        border: TableBorder(
                                          bottom: BorderSide(),
                                          horizontalInside: BorderSide(),
                                        ),
                                        defaultColumnWidth:
                                            FlexColumnWidth(10.0),
                                        columnWidths: {
                                          0: FlexColumnWidth(8.5),
                                          1: FlexColumnWidth(12.5),
                                          2: FlexColumnWidth(10.5),
                                        },
                                        children: List.generate(
                                            loadVitalCO2.length, (index) {
                                          return TableRow(children: [
                                            TableCell(
                                              child: Container(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  height: 40,
                                                  child: Text(
                                                      loadVitalCO2[index]
                                                          ['YEAR'],
                                                      style: TextStyle(
                                                          // fontWeight: FontWeight.bold,
                                                          color:
                                                              Colors.black))),
                                            ),
                                            TableCell(
                                              child: Container(
                                                alignment: Alignment.centerLeft,
                                                height: 40,
                                                child: Text(
                                                    loadVitalCO2[index]
                                                        ['MONTH'],
                                                    style: TextStyle(
                                                        // fontWeight: FontWeight.bold,
                                                        fontSize: 14,
                                                        color: Colors.black)),
                                              ),
                                            ),
                                            TableCell(
                                              child: Container(
                                                alignment: Alignment.centerLeft,
                                                height: 40,
                                                child: Text(
                                                    loadVitalCO2[index]
                                                            ['DATA_CO2'] +
                                                        " ppm",
                                                    style: TextStyle(
                                                        // fontWeight: FontWeight.bold,
                                                        fontSize: 14,
                                                        color: Colors.black)),
                                              ),
                                            ),
                                          ]);
                                        })),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                              child: SingleChildScrollView(
                                child: ListBody(
                                  children: <Widget>[
                                    Divider(
                                      color: Colors.black,
                                    ),
                                    Table(
                                        defaultColumnWidth:
                                            FlexColumnWidth(10.0),
                                        columnWidths: {
                                          0: FlexColumnWidth(10.5),
                                          1: FlexColumnWidth(15.5),
                                        },
                                        children: [
                                          TableRow(children: [
                                            TableCell(
                                              child: Container(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  height: 20,
                                                  child: Text("YEAR",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color:
                                                              Colors.black))),
                                            ),
                                            TableCell(
                                              child: Container(
                                                alignment: Alignment.centerLeft,
                                                height: 20,
                                                child: Text(
                                                    "Global Temperature",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 14,
                                                        color: Colors.black)),
                                              ),
                                            ),
                                          ])
                                        ]),
                                    Divider(
                                      color: Colors.black,
                                    ),
                                    Table(
                                        border: TableBorder(
                                          bottom: BorderSide(),
                                          horizontalInside: BorderSide(),
                                        ),
                                        defaultColumnWidth:
                                            FlexColumnWidth(10.0),
                                        columnWidths: {
                                          0: FlexColumnWidth(8.5),
                                          1: FlexColumnWidth(12.5),
                                        },
                                        children: List.generate(
                                            loadVitalCO2.length, (index) {
                                          return TableRow(children: [
                                            TableCell(
                                              child: Container(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  height: 40,
                                                  child: Text(
                                                      loadTempt[index]['YEAR'],
                                                      style: TextStyle(
                                                          // fontWeight: FontWeight.bold,
                                                          color:
                                                              Colors.black))),
                                            ),
                                            TableCell(
                                              child: Container(
                                                alignment: Alignment.centerLeft,
                                                height: 40,
                                                child: Text(
                                                    loadTempt[index]
                                                            ['CELSIUS'] +
                                                        " celsius",
                                                    style: TextStyle(
                                                        // fontWeight: FontWeight.bold,
                                                        fontSize: 14,
                                                        color: Colors.black)),
                                              ),
                                            ),
                                          ]);
                                        })),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                              child: SingleChildScrollView(
                                child: ListBody(
                                  children: <Widget>[
                                    Divider(
                                      color: Colors.black,
                                    ),
                                    Table(
                                        defaultColumnWidth:
                                            FlexColumnWidth(10.0),
                                        columnWidths: {
                                          0: FlexColumnWidth(10.5),
                                          1: FlexColumnWidth(15.5),
                                        },
                                        children: [
                                          TableRow(children: [
                                            TableCell(
                                              child: Container(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  height: 20,
                                                  child: Text("YEAR",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color:
                                                              Colors.black))),
                                            ),
                                            TableCell(
                                              child: Container(
                                                alignment: Alignment.centerLeft,
                                                height: 20,
                                                child: Text("SEA LEVEL (± 4)",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 14,
                                                        color: Colors.black)),
                                              ),
                                            ),
                                          ])
                                        ]),
                                    Divider(
                                      color: Colors.black,
                                    ),
                                    Table(
                                        border: TableBorder(
                                          bottom: BorderSide(),
                                          horizontalInside: BorderSide(),
                                        ),
                                        defaultColumnWidth:
                                            FlexColumnWidth(10.0),
                                        columnWidths: {
                                          0: FlexColumnWidth(8.5),
                                          1: FlexColumnWidth(12.5),
                                        },
                                        children: List.generate(
                                            loadSeaLevel.length, (index) {
                                          return TableRow(children: [
                                            TableCell(
                                              child: Container(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  height: 40,
                                                  child: Text(
                                                      loadSeaLevel[index]
                                                          ['YEAR'],
                                                      style: TextStyle(
                                                          // fontWeight: FontWeight.bold,
                                                          color:
                                                              Colors.black))),
                                            ),
                                            TableCell(
                                              child: Container(
                                                alignment: Alignment.centerLeft,
                                                height: 40,
                                                child: Text(
                                                    loadSeaLevel[index]
                                                            ['SEALEVEL'] +
                                                        " mm",
                                                    style: TextStyle(
                                                        // fontWeight: FontWeight.bold,
                                                        fontSize: 14,
                                                        color: Colors.black)),
                                              ),
                                            ),
                                          ]);
                                        })),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                              child: SingleChildScrollView(
                                child: ListBody(
                                  children: <Widget>[
                                    Divider(
                                      color: Colors.black,
                                    ),
                                    Table(
                                        defaultColumnWidth:
                                            FlexColumnWidth(10.0),
                                        columnWidths: {
                                          0: FlexColumnWidth(10.5),
                                          1: FlexColumnWidth(15.5),
                                        },
                                        children: [
                                          TableRow(children: [
                                            TableCell(
                                              child: Container(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  height: 20,
                                                  child: Text("YEAR",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color:
                                                              Colors.black))),
                                            ),
                                            TableCell(
                                              child: Container(
                                                alignment: Alignment.centerLeft,
                                                height: 20,
                                                child: Text("ARCTIC SEA ICE",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 14,
                                                        color: Colors.black)),
                                              ),
                                            ),
                                          ])
                                        ]),
                                    Divider(
                                      color: Colors.black,
                                    ),
                                    Table(
                                        border: TableBorder(
                                          bottom: BorderSide(),
                                          horizontalInside: BorderSide(),
                                        ),
                                        defaultColumnWidth:
                                            FlexColumnWidth(10.0),
                                        columnWidths: {
                                          0: FlexColumnWidth(8.5),
                                          1: FlexColumnWidth(12.5),
                                        },
                                        children: List.generate(
                                            loadArcticIce.length, (index) {
                                          return TableRow(children: [
                                            TableCell(
                                              child: Container(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  height: 40,
                                                  child: Text(
                                                      loadArcticIce[index]
                                                          ['YEAR'],
                                                      style: TextStyle(
                                                          // fontWeight: FontWeight.bold,
                                                          color:
                                                              Colors.black))),
                                            ),
                                            TableCell(
                                              child: Container(
                                                alignment: Alignment.centerLeft,
                                                height: 40,
                                                child: Text(
                                                    loadArcticIce[index][
                                                            'DATA_ARCTICSEAICE'] +
                                                        " million sq km",
                                                    style: TextStyle(
                                                        // fontWeight: FontWeight.bold,
                                                        fontSize: 14,
                                                        color: Colors.black)),
                                              ),
                                            ),
                                          ]);
                                        })),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
          ),
          // ),
        ));
  }

// Load Data Vital
  _loadVitalCO2() {
    String urlLoadJobs = server + "/php/load_co2.php";
    http.post(urlLoadJobs, body: {}).then((res) {
      if (res.body == "nodata") {
        //// print(res.body);
        // titlecenter = "No action found";
      } else {
        setState(() {
          var extractdata = json.decode(res.body);
          loadVitalCO2 = extractdata["vital_co2"];

          print(extractdata);
        });
      }
    }).catchError((err) {
      print(err);
    });
  }

  _loadTempt() {
    String urlLoadJobs = server + "/php/load_tempt.php";
    http.post(urlLoadJobs, body: {}).then((res) {
      if (res.body == "nodata") {
        //// print(res.body);
        // titlecenter = "No action found";
      } else {
        setState(() {
          var extractdata = json.decode(res.body);
          loadTempt = extractdata["vital_tempt"];

          print(extractdata);
        });
      }
    }).catchError((err) {
      print(err);
    });
  }

  _loadSeaLevel() {
    String urlLoadJobs = server + "/php/load_sealevel.php";
    http.post(urlLoadJobs, body: {}).then((res) {
      if (res.body == "nodata") {
        //// print(res.body);
        // titlecenter = "No action found";
      } else {
        setState(() {
          var extractdata = json.decode(res.body);
          loadSeaLevel = extractdata["vital_sealevel"];

          print(extractdata);
        });
      }
    }).catchError((err) {
      print(err);
    });
  }

  _loadArcticIce() {
    String urlLoadJobs = server + "/php/load_arcticice.php";
    http.post(urlLoadJobs, body: {}).then((res) {
      if (res.body == "nodata") {
        //// print(res.body);
        // titlecenter = "No action found";
      } else {
        setState(() {
          var extractdata = json.decode(res.body);
          loadArcticIce = extractdata["vital_arcticseaice"];

          print(extractdata);
        });
      }
    }).catchError((err) {
      print(err);
    });
  }
}
