import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fyp_climate_hero/actionAdmin.dart';
import 'package:fyp_climate_hero/manageActions.dart';
import 'package:fyp_climate_hero/user.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:toast/toast.dart';
import 'package:http/http.dart' as http;
import 'package:progress_dialog/progress_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class AdminActionDetails extends StatefulWidget {
  final User user;
  final ActionAdmin action;

  const AdminActionDetails({Key key, this.user, this.action, int index})
      : super(key: key);
  @override
  _AdminActionDetailsState createState() => _AdminActionDetailsState();
}

class _AdminActionDetailsState extends State<AdminActionDetails> {
  TextEditingController actionNameEditingController =
      new TextEditingController();
  TextEditingController categoryEditingController = new TextEditingController();
  TextEditingController easeEditingController = new TextEditingController();
  TextEditingController vitalSignEditingController =
      new TextEditingController();
  TextEditingController descriptionEditingController =
      new TextEditingController();
  TextEditingController tipsEditingController = new TextEditingController();

  String server = "https://seriouslaa.com/climate_hero";
  double screenHeight, screenWidth;
  bool editDetails = false;
  File _image;
  bool _takepicture = true;
  bool _takepicturelocal = false;

  void _editProfileVisibility() {
    setState(() {
      editDetails = !editDetails;

      print(editDetails);
    });
  }

  @override
  void initState() {
    super.initState();

    actionNameEditingController.text = widget.action.name;
    categoryEditingController.text = widget.action.category;
    easeEditingController.text = widget.action.ease;
    vitalSignEditingController.text = widget.action.vitalsign;
    descriptionEditingController.text = widget.action.description;
    tipsEditingController.text = widget.action.tips;
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
            Navigator.of(context).pop();
          }),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              editDetails == false
                  ? Text('Action Details(Admin)')
                  : Text('Edit Actions'),
              editDetails == false
                  ? IconButton(
                      icon: Icon(
                        Icons.settings,
                        color: Colors.black,
                      ),
                      onPressed: _editProfileVisibility)
                  : GestureDetector(
                      child: Text("Update", style: TextStyle(fontSize: 16)),
                      onTap: () => updateActionDialog())
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
          child: SingleChildScrollView(
            child: editDetails == false
                ? Column(
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
                          fit: BoxFit.cover,
                          height: screenHeight / 4.5,
                          width: screenWidth / 0.5,
                          imageUrl: server +
                              "/actionsimages/${widget.action.actionid}.jpg",
                          placeholder: (context, url) =>
                              new CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              new Icon(Icons.error),
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
                                child: Container(
                                    alignment: Alignment.centerLeft,
                                    height: 22,
                                    child: Text(widget.action.ease,
                                        style: GoogleFonts.merriweather(
                                            fontSize: 13,
                                            // fontWeight:
                                            //     FontWeight
                                            //         .bold,
                                            color: Colors.black))),
                              ),
                              TableCell(
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  height: 22,
                                  child: Text(widget.action.vitalsign,
                                      style: GoogleFonts.merriweather(
                                          fontSize: 13,
                                          // fontWeight:
                                          //     FontWeight
                                          //         .bold,
                                          color: Colors.black)),
                                ),
                              ),
                            ]),
                          ]),
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
                      Container(
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
                      Divider(
                        height: 50,
                        thickness: 5,
                        color: Colors.blue[200],
                      ),
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FractionallySizedBox(
                          alignment: Alignment.centerLeft,
                          child: TextField(
                            decoration: InputDecoration(
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
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FractionallySizedBox(
                          alignment: Alignment.centerLeft,
                          child: TextField(
                            decoration: InputDecoration(
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
                            Visibility(
                              visible: _takepicture,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: CachedNetworkImage(
                                  fit: BoxFit.fill,
                                  height: screenHeight / 4.5,
                                  width: screenWidth / 0.5,
                                  imageUrl: server +
                                      "/actionsimages/${widget.action.actionid}.jpg",
                                  placeholder: (context, url) =>
                                      new CircularProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      new Icon(Icons.error),
                                ),
                              ),
                            ),
                            Visibility(
                                visible: _takepicturelocal,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: Container(
                                    height: screenHeight / 4.5,
                                    width: screenWidth / 0.5,
                                    decoration: BoxDecoration(
                                      image: new DecorationImage(
                                        image: _image == null
                                            ? AssetImage(
                                                'assets/images/splash.jpg')
                                            : FileImage(_image),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                )),
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
                                    child: TextField(
                                        decoration: InputDecoration(
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.blue,
                                                  width: 2)),
                                        ),
                                        enabled: editDetails,
                                        textInputAction:
                                            TextInputAction.newline,
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
                                    child: TextField(
                                      decoration: InputDecoration(
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
                          child: TextField(
                            decoration: InputDecoration(
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
                          child: TextField(
                            decoration: InputDecoration(
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
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  void _choose() async {
    // ignore: deprecated_member_use
    _image = await ImagePicker.pickImage(
        source: ImageSource.gallery, maxHeight: 800, maxWidth: 800);
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
      setState(() {
        _takepicture = false;
        _takepicturelocal = true;
      });
    }
  }

  updateProduct() {
    ProgressDialog pr = new ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false);
    pr.style(message: "Updating action...");
    pr.show();
    String base64Image;

    if (_image != null) {
      base64Image = base64Encode(_image.readAsBytesSync());
      http.post(server + "/php/update_action.php", body: {
        "id": widget.action.actionid,
        "name": actionNameEditingController.text,
        "category": categoryEditingController.text,
        "ease": easeEditingController.text,
        "vital": vitalSignEditingController.text,
        "description": descriptionEditingController.text,
        "tips": tipsEditingController.text,
        "encoded_string": base64Image,
      }).then((res) {
        pr.hide();
        if (res.body == "successUpdatedImg") {
          Toast.show("Update success", context,
              duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);

          setState(() {
            DefaultCacheManager manager = new DefaultCacheManager();
            manager.emptyCache();
          });
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => ManageActions(
                        user: widget.user,
                      )));
        } else {
          Toast.show("Update failed", context,
              duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        }
      }).catchError((err) {
        print(err);
        pr.hide();
      });
    } else {
      http.post(server + "/php/update_action.php", body: {
        "id": widget.action.actionid,
        "name": actionNameEditingController.text,
        "category": categoryEditingController.text,
        "ease": easeEditingController.text,
        "vital": vitalSignEditingController.text,
        "description": descriptionEditingController.text,
        "tips": tipsEditingController.text,
      }).then((res) {
        print(res.body);
        pr.hide();
        if (res.body == "SuccessUpdatedData") {
          Toast.show("Update success", context,
              duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);

          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => ManageActions(
                        user: widget.user,
                      )));
        } else {
          Toast.show("Update failed", context,
              duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        }
      }).catchError((err) {
        print(err);
        pr.hide();
      });
    }
  }

  updateActionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          title: new Text("Update action ",
              style: GoogleFonts.merriweather(fontSize: 14)),
          content: new Text("Are you sure?",
              style: GoogleFonts.merriweather(fontSize: 14)),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            // ignore: deprecated_member_use
            new FlatButton(
              child: new Text("Yes",
                  style: GoogleFonts.merriweather(fontSize: 14)),
              onPressed: () {
                Navigator.of(context).pop();
                updateProduct();
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
