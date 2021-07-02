import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fyp_climate_hero/Admin/adminpage.dart';
import 'package:fyp_climate_hero/actionAdmin.dart';
import 'package:fyp_climate_hero/manageActions.dart';
import 'package:fyp_climate_hero/user.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:toast/toast.dart';
import 'package:http/http.dart' as http;
import 'package:progress_dialog/progress_dialog.dart';

class AdminAddActions extends StatefulWidget {
  final User user;
  final ActionAdmin action;

  const AdminAddActions({Key key, this.user, this.action, int index})
      : super(key: key);
  @override
  _AdminAddActionsState createState() => _AdminAddActionsState();
}

class _AdminAddActionsState extends State<AdminAddActions> {
  TextEditingController actionNameEditingController =
      new TextEditingController();
  TextEditingController categoryEditingController = new TextEditingController();
  TextEditingController easeEditingController = new TextEditingController();
  TextEditingController vitalSignEditingController =
      new TextEditingController();
  TextEditingController descriptionEditingController =
      new TextEditingController();
  TextEditingController tipsEditingController = new TextEditingController();
  TextEditingController idEditingController = new TextEditingController();

  final _formKey = GlobalKey<FormState>();

  String server = "https://seriouslaa.com/climate_hero";
  double screenHeight, screenWidth;
  bool editDetails = true;
  File _image;

  @override
  void initState() {
    super.initState();
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
          title: Text('Add New Action(Admin)'),
        ),
        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      "Action ID",
                      style: GoogleFonts.merriweather(
                          fontSize: 18, color: Colors.black),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FractionallySizedBox(
                        alignment: Alignment.centerLeft,
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter something!';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: "Enter action ID here",
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.blue, width: 2)),
                          ),
                          enabled: editDetails,
                          textInputAction: TextInputAction.newline,
                          keyboardType: TextInputType.multiline,
                          minLines: null,
                          maxLines: null,
                          style: GoogleFonts.oswald(
                              fontSize: 11, color: Colors.black),
                          controller: idEditingController,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Action Name",
                      style: GoogleFonts.merriweather(
                          fontSize: 18, color: Colors.black),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FractionallySizedBox(
                        alignment: Alignment.centerLeft,
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter something!';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: "Enter action name here",
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.blue, width: 2)),
                          ),
                          enabled: editDetails,
                          textInputAction: TextInputAction.newline,
                          keyboardType: TextInputType.multiline,
                          minLines: null,
                          maxLines: null,
                          style: GoogleFonts.oswald(
                              fontSize: 33, color: Colors.black),
                          controller: actionNameEditingController,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Action Category",
                      style: GoogleFonts.merriweather(
                          fontSize: 18, color: Colors.black),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FractionallySizedBox(
                        alignment: Alignment.centerLeft,
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter something!';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: "Enter action category here",
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.blue, width: 2)),
                          ),
                          enabled: editDetails,
                          textInputAction: TextInputAction.newline,
                          keyboardType: TextInputType.multiline,
                          minLines: null,
                          maxLines: null,
                          style: GoogleFonts.merriweather(
                              fontSize: 11, color: Colors.black),
                          controller: categoryEditingController,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    GestureDetector(
                      onTap: _choose,
                      child: Column(
                        children: [
                          Text(
                            "Action Image",
                            style: GoogleFonts.merriweather(
                                fontSize: 20, color: Colors.black),
                          ),
                          SizedBox(height: 10),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Container(
                              height: screenHeight / 4.5,
                              width: screenWidth / 0.5,
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                image: new DecorationImage(
                                  image: _image == null
                                      ? AssetImage('assets/icons/addfolder.png')
                                      : FileImage(_image),
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 15),
                    Table(
                        defaultColumnWidth: FlexColumnWidth(1.0),
                        columnWidths: {
                          0: FlexColumnWidth(0.9),
                          1: FlexColumnWidth(1.5),
                        },
                        children: [
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
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: FractionallySizedBox(
                                  alignment: Alignment.centerLeft,
                                  child: TextFormField(
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter something!';
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                        hintText: "Enter action ease here",
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.blue, width: 2)),
                                      ),
                                      enabled: editDetails,
                                      textInputAction: TextInputAction.newline,
                                      keyboardType: TextInputType.multiline,
                                      minLines: null,
                                      maxLines: null,
                                      style: GoogleFonts.merriweather(
                                          fontSize: 11, color: Colors.black),
                                      controller: easeEditingController),
                                ),
                              ),
                            ),
                            TableCell(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: FractionallySizedBox(
                                  alignment: Alignment.centerLeft,
                                  child: TextFormField(
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter something!';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      hintText: "Enter action vital sign here",
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.blue, width: 2)),
                                    ),
                                    enabled: editDetails,
                                    textInputAction: TextInputAction.newline,
                                    keyboardType: TextInputType.multiline,
                                    minLines: null,
                                    maxLines: null,
                                    style: GoogleFonts.merriweather(
                                        fontSize: 11, color: Colors.black),
                                    controller: vitalSignEditingController,
                                  ),
                                ),
                              ),
                            ),
                          ]),
                        ]),
                    Divider(
                      thickness: 5,
                      color: Colors.blue[200],
                    ),
                    Text("Description",
                        style: GoogleFonts.abel(
                            fontWeight: FontWeight.bold, fontSize: 30)),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FractionallySizedBox(
                        alignment: Alignment.centerLeft,
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter something!';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: "Enter action description here",
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.blue, width: 2)),
                          ),
                          enabled: editDetails,
                          textInputAction: TextInputAction.newline,
                          keyboardType: TextInputType.multiline,
                          minLines: null,
                          maxLines: null,
                          style: GoogleFonts.merriweather(
                              fontSize: 12, color: Colors.black),
                          controller: descriptionEditingController,
                        ),
                      ),
                    ),
                    Divider(
                      thickness: 5,
                      color: Colors.blue[200],
                    ),
                    Text("Tips",
                        style: GoogleFonts.abel(
                            fontWeight: FontWeight.bold, fontSize: 30)),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FractionallySizedBox(
                        alignment: Alignment.centerLeft,
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter something!';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: "Enter action tips here",
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.blue, width: 2)),
                          ),
                          enabled: editDetails,
                          textInputAction: TextInputAction.newline,
                          keyboardType: TextInputType.multiline,
                          minLines: null,
                          maxLines: null,
                          style: GoogleFonts.merriweather(
                              fontSize: 11, color: Colors.black),
                          controller: tipsEditingController,
                        ),
                      ),
                    ),
                    Divider(
                      thickness: 5,
                      color: Colors.blue[200],
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                      child: MaterialButton(
                        // elevation: 10,
                        height: 50,
                        minWidth: 280,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Text('Save all data',
                            style:
                                TextStyle(color: Colors.white, fontSize: 20)),
                        color: Colors.blue,
                        onPressed: updateActionDialog,
                      ),
                    ),
                    Divider(
                      thickness: 5,
                      color: Colors.blue[200],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _choose() async {
    // ignore: deprecated_member_use
    _image = await ImagePicker.pickImage(
        source: ImageSource.gallery, maxWidth: 800, maxHeight: 800);
    _cropImage();
    setState(() {});
  }

  Future<Null> _cropImage() async {
    File croppedFile = await ImageCropper.cropImage(
        sourcePath: _image.path,
        aspectRatioPresets: Platform.isAndroid
            ? [CropAspectRatioPreset.ratio16x9]
            : [CropAspectRatioPreset.ratio16x9],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Set image size',
            toolbarColor: Colors.blue,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          title: 'Set image size',
        ));
    if (croppedFile != null) {
      _image = croppedFile;
    }
    setState(() {});
  }

  updateActionDialog() {
    if (_formKey.currentState.validate()) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            title: new Text("Add new action ",
                style: GoogleFonts.merriweather(fontSize: 14)),
            content: new Text("Are you sure?",
                style: GoogleFonts.merriweather(fontSize: 14)),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              // ignore: deprecated_member_use
              new FlatButton(
                child: new Text("Yes",
                    style: GoogleFonts.merriweather(fontSize: 14)),
                onPressed: _addNewAction,
              ),
              // ignore: deprecated_member_use
              new FlatButton(
                child: new Text("No",
                    style: GoogleFonts.merriweather(fontSize: 14)),
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

  void _addNewAction() {
    ProgressDialog pr = new ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false);
    pr.style(message: "Adding new action...");
    pr.show();
    String base64Image = base64Encode(_image.readAsBytesSync());

    http.post(server + "/php/insert_actions.php", body: {
      "actionid": idEditingController.text,
      "name": actionNameEditingController.text,
      "category": categoryEditingController.text,
      "vitalsign": vitalSignEditingController.text,
      "ease": easeEditingController.text,
      "description": descriptionEditingController.text,
      "tips": tipsEditingController.text,
      "encoded_string": base64Image,
    }).then((res) {
      print(res.body);
      pr.hide();
      if (res.body == "found") {
        Toast.show("Action already in database", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => ManageActions(
                      user: widget.user,
                    )));
      }
      if (res.body == "success") {
        Toast.show("Action Added", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => ManageActions(
                      user: widget.user,
                    )));
      } else {
        Toast.show("Failed to add", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => ManageActions(
                      user: widget.user,
                    )));
      }
    }).catchError((err) {
      print(err);
      pr.hide();
    });
  }
}
