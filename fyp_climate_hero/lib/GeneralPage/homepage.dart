import 'package:flutter/material.dart';
import 'package:fyp_climate_hero/Admin/adminpage.dart';
import 'package:fyp_climate_hero/GeneralPage/loginpage.dart';
import 'package:fyp_climate_hero/GeneralPage/navigation.dart';
import 'package:fyp_climate_hero/ProfilePage/register.dart';
import 'package:fyp_climate_hero/user.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../ProfilePage/profile.dart';
import 'package:video_player/video_player.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HomePage extends StatefulWidget {
  final User user;

  const HomePage({Key key, this.user}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double screenHeight, screenWidth;
  bool _isadmin = false;
  bool _isguest = false;
  GlobalKey<RefreshIndicatorState> refreshKey;
  VideoPlayerController _controller;
  VideoPlayerController _controllerGreenhouse;
  Future<void> _initializeVideoPlayerFuture;
  Future<void> _initializeVideoPlayerFutureGreenhouse;
  String titleLoadVideo = "Loading...";
  String server = "https://seriouslaa.com/climate_hero";

  List actiondata;
  List imgList = [
    'https://seriouslaa.com/climate_hero/assetshome/wordcloud1.jpg',
    'https://seriouslaa.com/climate_hero/assetshome/4key.jpeg',
    'https://seriouslaa.com/climate_hero/assetshome/co2_concentration.jpg',
    'https://seriouslaa.com/climate_hero/assetshome/ice.jpg',
    'https://seriouslaa.com/climate_hero/assetshome/Solar_Irradiance_graph_2020.png',
    'https://seriouslaa.com/climate_hero/assetshome/wordcloud2.jpg',
  ];

  @override
  void initState() {
    super.initState();

    _controller =
        VideoPlayerController.network(server + '/assetshome/climatechange.mp4');
    _initializeVideoPlayerFuture = _controller.initialize();
    _controller.setLooping(true);
    _controller.setVolume(1);
    _controllerGreenhouse = VideoPlayerController.network(
        server + '/assetshome/Greenhouse_effect.mp4');
    _initializeVideoPlayerFutureGreenhouse = _controllerGreenhouse.initialize();
    _controllerGreenhouse.setLooping(true);
    refreshKey = GlobalKey<RefreshIndicatorState>();
    if (widget.user.email == "admin@climatehero.com") {
      _isadmin = true;
    } else if (widget.user.email == "guest@climatehero.com") {
      _isguest = true;
    }
  }

  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    _controller.dispose();

    super.dispose();
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
      title: 'Project',
      home: Container(
        decoration: BoxDecoration(
            // gradient: colorHomeGradient,
            ),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          //Drawer//
          drawer: drawer(context),

          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Center(
                child: Text(
              'CLIMATE HERO',
              style: TextStyle(fontWeight: FontWeight.bold),
            )),
          ),
          body: RefreshIndicator(
              key: refreshKey,
              color: Colors.redAccent,
              onRefresh: () async {
                await refreshList();
              },
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Visibility(
                      visible: _isguest,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(30, 8, 8, 8),
                        child: Row(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Register to use more features.",
                                  style: GoogleFonts.oswald(color: Colors.red
                                      // fontSize: 26,

                                      ),
                                ),
                                Text(
                                  "Join us now!",
                                  style: GoogleFonts.oswald(color: Colors.red
                                      // fontSize: 26,

                                      ),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 30,
                            ),
                            SizedBox(
                              height: 40,
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
                                  color: Colors.blue[100],
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
                      ),
                    ),
                    //Galery Images
                    FractionallySizedBox(
                      child: Container(
                        color: Colors.white,
                        // height: screenHeight / 3,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
                              child: Row(
                                children: [
                                  Text(
                                    "Gallery",
                                    style: GoogleFonts.oswald(
                                      fontSize: 26,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Divider(
                              thickness: 2,
                            ),
                            CarouselSlider(
                              items: imgList.map((imgUrl) {
                                return Builder(
                                  builder: (BuildContext context) {
                                    return Container(
                                        margin: EdgeInsets.all(3.0),
                                        child: CachedNetworkImage(
                                          imageUrl: imgUrl,
                                        ));
                                  },
                                );
                              }).toList(),
                              options: CarouselOptions(
                                height: screenHeight / 3,
                                enlargeCenterPage: true,
                                autoPlay: true,
                                aspectRatio: 16 / 9,
                                autoPlayCurve: Curves.fastOutSlowIn,
                                enableInfiniteScroll: true,
                                autoPlayAnimationDuration:
                                    Duration(milliseconds: 2000),
                                viewportFraction: 0.8,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Divider(
                      height: 10,
                      indent: 10,
                      endIndent: 10,
                      thickness: 1,
                      color: Colors.blue,
                    ),

                    //What is Climate Change//
                    FractionallySizedBox(
                      child: Container(
                        color: Colors.white,
                        // height: screenHeight / 3,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
                              child: Text(
                                "What is Climate Change? | Start Here.",
                                style: GoogleFonts.oswald(
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                              child: FutureBuilder(
                                future: _initializeVideoPlayerFuture,
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.done) {
                                    return AspectRatio(
                                        aspectRatio:
                                            _controller.value.aspectRatio,
                                        // Use the VideoPlayer widget to display the video.
                                        child: Stack(
                                          children: [
                                            VideoPlayer(_controller),
                                            Center(
                                              child: InkWell(
                                                child: Icon(
                                                  _controller.value.isPlaying
                                                      ? Icons.pause
                                                      : Icons.play_arrow,
                                                  color: Colors.white,
                                                  size: 60,
                                                ),
                                                onTap: () {
                                                  setState(() {
                                                    _controller.value.isPlaying
                                                        ? _controller.pause()
                                                        : _controller.play();
                                                  });
                                                },
                                              ),
                                            ),
                                          ],
                                        ));
                                  } else {
                                    return Center(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          CircularProgressIndicator(),
                                          Padding(
                                            padding: const EdgeInsets.all(15),
                                            child: Text(titleLoadVideo),
                                          ),
                                        ],
                                      ),
                                    );
                                  }
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
                              child: Text(
                                "The hard facts about global warming - a defining issue of our time. The UN says carbon dioxide levels in our atmosphere are going up, and the earth is on track to warm by 3.2 degrees before the century is over. The consequences of that acceleration are already proving disastrous for communities around the world.",
                                style: GoogleFonts.oswald(
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Divider(
                      height: 10,
                      indent: 10,
                      endIndent: 10,
                      thickness: 1,
                      color: Colors.blue,
                    ),

                    //Greenhouse
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                      child: FractionallySizedBox(
                        child: Container(
                          color: Colors.white,
                          // height: screenHeight / 3,
                          child: Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 8, 20, 8),
                                child: Row(
                                  children: [
                                    Text(
                                      "Greenhouse Effect!",
                                      style: GoogleFonts.oswald(
                                        fontSize: 26,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              FutureBuilder(
                                future: _initializeVideoPlayerFutureGreenhouse,
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.done) {
                                    return AspectRatio(
                                        aspectRatio: _controllerGreenhouse
                                            .value.aspectRatio,
                                        // Use the VideoPlayer widget to display the video.
                                        child: Stack(
                                          children: [
                                            VideoPlayer(_controllerGreenhouse),
                                            Center(
                                              child: InkWell(
                                                child: Icon(
                                                  _controllerGreenhouse
                                                          .value.isPlaying
                                                      ? Icons.pause
                                                      : Icons.play_arrow,
                                                  color: Colors.white,
                                                  size: 60,
                                                ),
                                                onTap: () {
                                                  setState(() {
                                                    _controllerGreenhouse
                                                            .value.isPlaying
                                                        ? _controllerGreenhouse
                                                            .pause()
                                                        : _controllerGreenhouse
                                                            .play();
                                                  });
                                                },
                                              ),
                                            ),
                                          ],
                                        ));
                                  } else {
                                    return Center(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          CircularProgressIndicator(),
                                          Padding(
                                            padding: const EdgeInsets.all(15),
                                            child: Text(titleLoadVideo),
                                          ),
                                        ],
                                      ),
                                    );
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Divider(
                      height: 10,
                      indent: 10,
                      endIndent: 10,
                      thickness: 1,
                      color: Colors.blue,
                    ),

                    FractionallySizedBox(
                      child: Container(
                        color: Colors.white,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
                              child: Row(
                                children: [
                                  Text(
                                    "Infographic",
                                    style: GoogleFonts.oswald(
                                      fontSize: 26,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                                margin: EdgeInsets.all(6.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: CachedNetworkImage(
                                  imageUrl: server +
                                      "/assetshome/sea_level_infographic.jpg",
                                )),
                            Container(
                                margin: EdgeInsets.all(6.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: CachedNetworkImage(
                                  imageUrl: server +
                                      "/assetshome/JOI_Infographic.jpg",
                                )),
                          ],
                        ),
                      ),
                    ),
                    Divider(
                      height: 20,
                    ),
                    Center(
                      child: Text("Claimed by Climate Hero."),
                    ),
                    SizedBox(
                      height: 20,
                    )
                  ],
                ),
              )),

          floatingActionButton: Visibility(
            visible: _isadmin,
            child: FloatingActionButton.extended(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => AdminPage(
                              user: widget.user,
                            )));
                // _loadData();
                // _loadCartQuantity();
              },
              icon: Icon(Icons.assignment),
              label: Text("Administator"),
            ),
          ),
        ),
      ),
    );
  }

  Future<Null> refreshList() async {
    await Future.delayed(Duration(seconds: 2));
    //_getLocation();
    // _loadData();
    return null;
  }

  drawer(BuildContext context) {
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
          Visibility(
            visible: !_isguest,
            child: ListTile(
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
          ),
          Visibility(
            visible: _isadmin,
            child: ListTile(
                trailing: Icon(Icons.arrow_forward),
                leading: Icon(Icons.person),
                title: Text(
                  "Administator",
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
                              builder: (BuildContext context) => AdminPage(
                                    user: widget.user,
                                  )))
                    }),
          ),
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
