import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fyp_climate_hero/GeneralPage/navigation.dart';
import 'package:fyp_climate_hero/ProfilePage/register.dart';

import 'package:fyp_climate_hero/user.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:progress_dialog/progress_dialog.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  double screenHeight, screenWidth;
  bool _switchValue = false;
  TextEditingController _emailEditingController = new TextEditingController();
  TextEditingController _passwordEditingController =
      new TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String server = "https://seriouslaa.com/climate_hero";

  bool _showPassword = false;
  void _passwordvisibility() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  void initState() {
    super.initState();
    print("Hello i'm in INITSTATE");
    this.loadPref();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 100, 0, 50),
              child: Container(
                  height: screenHeight / 6,
                  // width: 100,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    image: AssetImage('assets/images/savetheplanet.jpg'),
                  ))),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
              child: Column(
                children: [
                  TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                      textAlign: TextAlign.center,
                      controller: _emailEditingController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide: BorderSide(color: Colors.blue, width: 2),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide: BorderSide(color: Colors.blue, width: 2),
                        ),
                        hintText: 'Email Address',
                        // alignLabelWithHint: true,
                        labelStyle: TextStyle(color: Colors.blue),
                        prefixIcon: Icon(
                          Icons.mail,
                          color: Colors.blue,
                        ),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter password';
                        }
                        return null;
                      },
                      obscureText: !_showPassword,
                      textAlign: TextAlign.center,
                      controller: _passwordEditingController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide: BorderSide(color: Colors.blue, width: 2),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide: BorderSide(color: Colors.blue, width: 2),
                        ),
                        hintText: 'Password',
                        // alignLabelWithHint: true,
                        labelStyle: TextStyle(color: Colors.blue),
                        prefixIcon: Icon(
                          Icons.lock,
                          color: Colors.blue,
                        ),
                        suffixIcon: GestureDetector(
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
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text("Remember me"),
                      Switch(
                        value: _switchValue,
                        onChanged: (bool value) {
                          setState(() {
                            _switchValue = value;
                            _onRememberMeChanged(value);
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 50,
                        width: screenWidth / 2.5,
                        child: MaterialButton(
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            child: Text('Log In',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                )),
                            color: Colors.blue[100],
                            // ignore: sdk_version_set_literal
                            onPressed: _userLogin),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      SizedBox(
                        height: 50,
                        width: screenWidth / 2.5,
                        child: MaterialButton(
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            child: Text('Register',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                )),
                            color: Colors.blue[400],
                            // ignore: sdk_version_set_literal
                            onPressed: () => {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              Register()))
                                }),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 50,
                    width: screenWidth / 1.2,
                    child: MaterialButton(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: Text('Continue as Guest',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                            )),
                        color: Colors.grey[200],
                        // ignore: sdk_version_set_literal
                        onPressed: continueAsGuest),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: null,
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _userLogin() async {
    if (_formKey.currentState.validate()) {
      try {
        ProgressDialog pb = new ProgressDialog(context,
            type: ProgressDialogType.Normal, isDismissible: false);
        pb.style(message: "Log in...");
        pb.show();

        String _email = _emailEditingController.text;
        String _password = _passwordEditingController.text;
        http
            .post(server + "/php/login_user.php", body: {
              "email": _email,
              "password": _password,
            })
            .timeout(const Duration(seconds: 4))
            .then((res) {
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
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => NavigationPage(
                              user: _user,
                            )));
              } else {
                pb.hide();
                showDialog(
                    context: context,
                    builder: (context) => new AlertDialog(
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0))),
                          title: new Text(
                            'Invalid email or password!',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          actions: [
                            MaterialButton(
                                onPressed: () {
                                  Navigator.of(context).pop(false);
                                },
                                child: Text(
                                  "Okay",
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                )),
                          ],
                        ));
              }
            })
            .catchError((err) {
              print(err);
            });
      } on Exception catch (_) {
        Toast.show("Error", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      }
    }
  }

  void _onRememberMeChanged(bool newValue) => setState(() {
        _switchValue = newValue;
        print(_switchValue);
        if (_switchValue) {
          savepref(true);
        } else {
          savepref(false);
        }
      });

  void savepref(bool value) async {
    String email = _emailEditingController.text;
    String password = _passwordEditingController.text;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (value) {
      //save preference
      await prefs.setString('email', email);
      await prefs.setString('password', password);
      Toast.show("Preferences have been saved", context,
          duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
    } else {
      //delete preference
      await prefs.setString('email', '');
      await prefs.setString('password', '');
      setState(() {
        _switchValue = false;
      });
      Toast.show("Preferences have removed", context,
          duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
    }
  }

  Future<void> loadPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = (prefs.getString('email')) ?? '';
    String password = (prefs.getString('password')) ?? '';
    if (email.length > 0) {
      setState(() {
        _emailEditingController.text = email;
        _passwordEditingController.text = password;
        _switchValue = true;
      });
    }
  }

  void continueAsGuest() {
    User _user = new User(
      name: "Not Registered",
      email: "guest@climatehero.com",
      phone: "Not Registered",
      password: "Not Registered",
      point: "Not Registered",
      dateregister: "Not Registered",
    );

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => NavigationPage(
                  user: _user,
                )));
  }
}
