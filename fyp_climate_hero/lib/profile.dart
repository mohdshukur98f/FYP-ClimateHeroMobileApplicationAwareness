import 'dart:convert';
// import 'package:fyp_climate_hero/navigation.dart';
import 'package:fyp_climate_hero/GeneralPage/homepage.dart';
import 'package:fyp_climate_hero/GeneralPage/loginpage.dart';
import 'package:fyp_climate_hero/GeneralPage/navigation.dart';
import 'package:fyp_climate_hero/ProfilePage/register.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:fyp_climate_hero/user.dart';
import 'package:toast/toast.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:google_fonts/google_fonts.dart';

class Profile extends StatefulWidget {
  final User user;

  const Profile({Key key, this.user}) : super(key: key);
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  TextEditingController nameEditingController = new TextEditingController();
  TextEditingController emailEditingController = new TextEditingController();
  TextEditingController phoneEditingController = new TextEditingController();
  TextEditingController passwordEditingController = new TextEditingController();

  List completedactiondata;
  String totalCompleted = "0";
  bool _isguest = false;

  double screenHeight, screenWidth;
  String server = "https://seriouslaa.com/climate_hero";
  bool editProfile = false;
  bool _showPassword = false;
  void _passwordvisibility() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  void _editProfileVisibility() {
    setState(() {
      editProfile = !editProfile;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadCompletedAction();
    nameEditingController.text = widget.user.name;
    emailEditingController.text = widget.user.email;
    phoneEditingController.text = widget.user.phone;
    passwordEditingController.text = widget.user.password;
    if (widget.user.email == "guest@climatehero.com") {
      _isguest = true;
    }
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
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          drawer: drawer(context),
          body: Stack(
            children: [
              upper(context),
              lower(context),
            ],
          ),
        ),
      ),
    );
  }

  upper(BuildContext context) {
    return Container(
      color: Colors.blue,
      height: screenHeight / 3,
    );
  }

  lower(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: screenHeight / 7.6,
          ),
          Row(
            children: [
              SizedBox(
                width: screenWidth / 10,
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                    width: 2,
                  ),
                  shape: BoxShape.circle,
                ),
                height: screenHeight / 10,
                width: screenWidth / 4,
                child: Center(
                    child: CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('assets/images/userdefault.jpg'),
                )
                    // Your Widget
                    ),
              ),
              Container(
                height: screenHeight / 10,
                width: screenWidth / 1.7,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.user.name,
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Text(
                      widget.user.email,
                      style: TextStyle(fontSize: 12),
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            _editProfileVisibility();
                          },
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                            child: Text(
                              "Edit",
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.yellow,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                          child: Visibility(
                            visible: editProfile,
                            child: Row(
                              children: [
                                Text(" | "),
                                GestureDetector(
                                  onTap: () {
                                    _editProfileVisibility();
                                  },
                                  child: Text(
                                    "Cancel",
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.yellow,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(100, 0, 100, 0),
            child: SizedBox(
              height: screenHeight / 5.3,
              width: screenWidth / 2.5,
              child: Card(
                color: Colors.blue[400],
                elevation: 10,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 8),
                      child: Icon(
                        Icons.verified_user,
                        size: 40,
                        color: Colors.yellow,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Total contributed",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                    Text(
                      totalCompleted,
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
          _isguest == true
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: screenHeight / 9,
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
                          color: Colors.red,
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
                            color: Colors.blue[200],
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
              : editProfile == false
                  ? Padding(
                      padding: const EdgeInsets.fromLTRB(20, 14, 20, 0),
                      child: SingleChildScrollView(
                        child: Container(
                          child: Column(
                            children: [
                              TextFormField(
                                initialValue: "  " + widget.user.name,
                                enabled: editProfile,
                                textCapitalization:
                                    TextCapitalization.characters,
                                style: TextStyle(fontSize: 15),
                                controller: null,
                                keyboardType: TextInputType.name,
                                decoration: InputDecoration(
                                  prefix: Icon(Icons.person),
                                  labelText: "Full Name",
                                ),
                              ),
                              TextFormField(
                                  initialValue: "  " + widget.user.email,
                                  enabled: editProfile,
                                  textCapitalization:
                                      TextCapitalization.characters,
                                  style: TextStyle(fontSize: 15),
                                  controller: null,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                      prefix: Icon(Icons.email),
                                      labelText: "E-Mail")),
                              TextFormField(
                                  initialValue:
                                      "  " + "(+6) " + widget.user.phone,
                                  enabled: editProfile,
                                  style: TextStyle(fontSize: 15),
                                  controller: null,
                                  keyboardType: TextInputType.phone,
                                  decoration: InputDecoration(
                                      prefix: Icon(Icons.phone),
                                      labelText: "Phone Number")),
                              Visibility(
                                visible: editProfile,
                                child: TextFormField(
                                    obscureText: !_showPassword,
                                    initialValue: "  " + widget.user.password,
                                    enabled: editProfile,
                                    textCapitalization:
                                        TextCapitalization.characters,
                                    style: TextStyle(fontSize: 15),
                                    controller: null,
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: InputDecoration(
                                        prefix: Icon(Icons.lock),
                                        suffixIcon: Visibility(
                                          visible: editProfile,
                                          child: GestureDetector(
                                            onTap: () {
                                              _passwordvisibility();
                                            },
                                            child: Icon(
                                              _showPassword
                                                  ? Icons.visibility
                                                  : Icons.visibility_off,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ),
                                        labelText: "Password")),
                              ),
                              SizedBox(
                                height: 13,
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.fromLTRB(20, 14, 20, 0),
                      child: SingleChildScrollView(
                        child: Container(
                          child: Column(
                            children: [
                              TextFormField(
                                enabled: editProfile,
                                textCapitalization:
                                    TextCapitalization.characters,
                                style: TextStyle(fontSize: 15),
                                controller: nameEditingController,
                                keyboardType: TextInputType.name,
                                decoration: InputDecoration(
                                  prefix: Icon(Icons.person),
                                  labelText: "Full Name",
                                ),
                              ),
                              TextFormField(
                                  enabled: editProfile,
                                  style: TextStyle(fontSize: 15),
                                  controller: phoneEditingController,
                                  keyboardType: TextInputType.phone,
                                  decoration: InputDecoration(
                                      prefix: Icon(Icons.phone),
                                      labelText: "Phone Number")),
                              Visibility(
                                visible: editProfile,
                                child: TextFormField(
                                    obscureText: !_showPassword,
                                    enabled: editProfile,
                                    textCapitalization:
                                        TextCapitalization.characters,
                                    style: TextStyle(fontSize: 15),
                                    controller: passwordEditingController,
                                    decoration: InputDecoration(
                                        prefix: Icon(Icons.lock),
                                        suffixIcon: Visibility(
                                          visible: editProfile,
                                          child: GestureDetector(
                                            onTap: () {
                                              _passwordvisibility();
                                            },
                                            child: Icon(
                                              _showPassword
                                                  ? Icons.visibility
                                                  : Icons.visibility_off,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ),
                                        labelText: "Password")),
                              ),
                              SizedBox(
                                height: 13,
                              ),
                              Visibility(
                                visible: editProfile,
                                child: Container(
                                  width: screenWidth / 1,
                                  child: MaterialButton(
                                    child: Text('UPDATE',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold)),
                                    color: Colors.blue,
                                    // ignore: sdk_version_set_literal
                                    onPressed: updateProfile,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
        ],
      ),
    );
  }

  _loadCompletedAction() {
    String urlLoadJobs = server + "/php/load_completed_action.php";
    http.post(urlLoadJobs, body: {
      "email": widget.user.email,
    }).then((res) {
      if (res.body == "nodata") {
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

  updateProfile() {
    http.post(server + "/php/update_user.php", body: {
      "name": nameEditingController.text,
      "email": widget.user.email,
      "phone": phoneEditingController.text,
      "password": passwordEditingController.text,
    }).then((res) {
      print(res.body);

      if (res.body == "success") {
        setState(() {
          _editProfileVisibility();

          try {
            ProgressDialog pb = new ProgressDialog(context,
                type: ProgressDialogType.Normal, isDismissible: false);
            pb.style(message: "Log in...");
            pb.show();
            String _email = widget.user.email;
            String _password = passwordEditingController.text;
            http.post(server + "/php/login_user.php", body: {
              "email": _email,
              "password": _password,
            }).then((res) {
              print(res.body);
              var string = res.body;
              List userdata = string.split(",");
              if (userdata[0] == "success") {
                User _user = new User(
                  name: userdata[1],
                  email: userdata[2],
                  phone: userdata[3],
                  password: _password,
                  point: userdata[4],
                  dateregister: userdata[5],
                );
                pb.hide();

                showDialog(
                  context: context,
                  builder: (context) => new AlertDialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0))),
                    title: new Text(
                      'Information Saved',
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
                                    builder: (BuildContext context) =>
                                        NavigationPage(user: _user)));
                          },
                          child: Text(
                            "Continue",
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
                Toast.show("Cant load", context,
                    duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
              }
            }).catchError((err) {
              print(err);
            });
          } on Exception catch (_) {
            Toast.show("Error", context,
                duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
          }
        });
      } else {
        Toast.show("Update failed", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      }
    }).catchError((err) {
      print(err);
    });
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
                            builder: (BuildContext context) => HomePage(
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
