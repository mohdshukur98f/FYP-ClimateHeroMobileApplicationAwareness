import 'package:flutter/material.dart';
import 'package:fyp_climate_hero/GeneralPage/loginpage.dart';
import 'package:fyp_climate_hero/GeneralPage/navigation.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  double screenHeight, screenWidth;
  bool _switchValue = false;
  TextEditingController _nameEditingController = new TextEditingController();
  TextEditingController _emailEditingController = new TextEditingController();
  TextEditingController _phoneEditingController = new TextEditingController();
  TextEditingController _passwordEditingController =
      new TextEditingController();
  String server = "https://seriouslaa.com/climate_hero";

  final _formKey = GlobalKey<FormState>();

  bool _showPassword = false;
  void _togglevisibility() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Center(
              child: Text(
            'Register New Account',
            style: TextStyle(fontWeight: FontWeight.bold),
          )),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 50, 0, 50),
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
                              return 'Please enter your name';
                            }
                            return null;
                          },
                          textAlign: TextAlign.center,
                          controller: _nameEditingController,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                              borderSide:
                                  BorderSide(color: Colors.blue, width: 2),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                              borderSide:
                                  BorderSide(color: Colors.blue, width: 2),
                            ),
                            hintText: 'Your Name',
                            // alignLabelWithHint: true,
                            labelStyle: TextStyle(color: Colors.blue),
                            prefixIcon: Icon(
                              Icons.person,
                              color: Colors.blue,
                            ),
                          )),
                      SizedBox(
                        height: 10,
                      ),
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
                              borderSide:
                                  BorderSide(color: Colors.blue, width: 2),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                              borderSide:
                                  BorderSide(color: Colors.blue, width: 2),
                            ),
                            hintText: 'Your Email',
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
                              return 'Please enter your phone number';
                            }
                            return null;
                          },
                          textAlign: TextAlign.center,
                          controller: _phoneEditingController,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                              borderSide:
                                  BorderSide(color: Colors.blue, width: 2),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                              borderSide:
                                  BorderSide(color: Colors.blue, width: 2),
                            ),
                            hintText: 'Your Phone Number',
                            // alignLabelWithHint: true,
                            labelStyle: TextStyle(color: Colors.blue),
                            prefixIcon: Icon(
                              Icons.mobile_friendly,
                              color: Colors.blue,
                            ),
                          )),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                        obscureText: !_showPassword,
                        textAlign: TextAlign.center,
                        controller: _passwordEditingController,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide:
                                BorderSide(color: Colors.blue, width: 2),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide:
                                BorderSide(color: Colors.blue, width: 2),
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
                              _togglevisibility();
                            },
                            child: Icon(
                              _showPassword
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: null,
                            child: Text("Agree with the term"),
                          ),
                          Checkbox(
                            value: _switchValue,
                            onChanged: (value) {
                              setState(() {
                                _switchValue = value;
                              });
                            },
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 50,
                        width: screenWidth / 1.2,
                        child: MaterialButton(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: Text('Register',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                              )),
                          color: Colors.blue[200],
                          // ignore: sdk_version_set_literal
                          onPressed: _register,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Already have an account? "),
                          GestureDetector(
                            // ignore: sdk_version_set_literal
                            onTap: () => {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          Login()))
                            },
                            child: Text(
                              'Login',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }

  void _register() {
    if (_formKey.currentState.validate()) {
      String name = _nameEditingController.text;
      String email = _emailEditingController.text;
      String phone = _phoneEditingController.text;
      String password = _passwordEditingController.text;
      if (!_switchValue) {
        Toast.show("Please Accept Term", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        print("Tick First");

        // pb.hide();
        return;
      } else
        http.post(server + "/php/register_user.php", body: {
          "name": name,
          "email": email,
          "password": password,
          "phone": phone,
        }).then((res) {
          print(res);
          // pb.hide();
          if (res.body == "success") {
            Navigator.pop(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => NavigationPage()));
            Toast.show("Registration success", context,
                duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
          }
        }).catchError((err) {
          print(err);
        });
      print("object");
    }
  }
}
