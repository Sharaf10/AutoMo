import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_downloader/image_downloader.dart';
import 'package:image_picker/image_picker.dart';

import '../OptionScreens/mainSettings.dart';
import '../User.dart';
import '../constants.dart';

class EditProfileSettings extends StatelessWidget {
  User? user;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: EditProfile(
        user: user!,
      ),
    );
  }
}

class EditProfile extends StatefulWidget {
  User user;

  EditProfile({Key? key, required this.user}) : super(key: key);

  @override
  _EditProfile createState() => _EditProfile(user: user);
}

class _EditProfile extends State<EditProfile> {
  User? user;

  _EditProfile({required this.user});

  @override
  initState() {
    // _asyncMethod();
    super.initState();
  }

  // _asyncMethod() async {
  //   var path;
  //   if (user!.downloaded == true) {
  //     path = user!.photoPath;
  //   } else {
  //     var imageId = await ImageDownloader.downloadImage(user!.photoURL);
  //     path = await ImageDownloader.findPath(imageId!);
  //     user!.photoPath = path;
  //     user!.downloaded = true;
  //   }
  //   //PickedFile file2 = new PickedFile(path);             // <-- 2
  //   //file2.writeAsBytesSync(response.bodyBytes);         // <-- 3
  //   setState(() {
  //     imageFile = path;
  //   });
  // }

  late String serverResponse;
  String? imageFile;
  late String detailsChanged;
  late String userName;
  late String email;

  final ImagePicker picker = ImagePicker();

  void takePhoto(ImageSource source) async {
    final pickedFile = await picker.getImage(source: source);
    setState(() {
      imageFile = pickedFile!.path;
    });
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget okButton = ElevatedButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => MainSettingsPage(user: user!),
        ));
      },
    );
    // set up the AlertDialog

    AlertDialog alert = AlertDialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      content: Text(
        "Saved Changes",
        style: TextStyle(color: Colors.black),
      ),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Widget bottomSheet() {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          Text(
            'Choose Profile Photo',
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                    primary: Colors.transparent, elevation: 0),
                icon: Icon(
                  Icons.camera,
                  color: Colors.black,
                ),
                onPressed: () {
                  takePhoto(ImageSource.camera);
                },
                label: Text('Camera', style: TextStyle(color: Colors.black)),
              ),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                    primary: Colors.transparent, elevation: 0),
                icon: Icon(
                  Icons.image,
                  color: Colors.black,
                ),
                onPressed: () {
                  takePhoto(ImageSource.gallery);
                },
                label: Text('Gallery', style: TextStyle(color: Colors.black)),
              )
            ],
          )
        ],
      ),
    );
  }

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_outlined),
          color: kButtonColor,
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => MainSettingsPage(user: user!),
            ));
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            color: kButtonColor,
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => MainSettingsPage(user: user!),
              ));
            },
          ),
        ],
      ),
      body: Form(
        key: formKey,
        child: Container(
          padding: EdgeInsets.only(top: 25, left: 16, right: 16),
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: ListView(
              children: <Widget>[
                Text(
                  'Edit Profile',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                SizedBox(
                  height: 15,
                ),
                Center(
                  child: Stack(
                    children: [
                      Container(
                          width: 130,
                          height: 130,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 4,
                                  color: Theme.of(context)
                                      .scaffoldBackgroundColor),
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                    spreadRadius: 2,
                                    blurRadius: 10,
                                    color: Colors.black.withOpacity(0.1),
                                    offset: Offset(0, 10))
                              ],
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: imageFile == null
                                      ? Image.network("").image
                                      : FileImage(File(imageFile!))))),
                      Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                    width: 4,
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor),
                                color: kButtonColor),
                            child: InkWell(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: ((builder) => bottomSheet()),
                                );
                              },
                              child: Icon(
                                Icons.edit,
                                color: Colors.white,
                              ),
                              splashColor: Colors.lightBlueAccent,
                            ),
                          ))
                    ],
                  ),
                ),
                SizedBox(
                  height: 35,
                ),
                TextFormField(
                  initialValue: user!.userName,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please Enter Your Name';
                    }
                    Pattern pattern = r'^[A-Za-z]+(?:[ _-][A-Za-z]+)*$';
                    RegExp regex =
                        new RegExp(r'^[A-Za-z]+(?:[ _-][A-Za-z]+)*$');
                    if (!regex.hasMatch(value))
                      return 'Invalid username';
                    else
                      return null;
                  },
                  onSaved: (value) {
                    userName = value!;
                  },
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(bottom: 3),
                      labelText: 'User Name',
                      labelStyle: TextStyle(
                        fontSize: 22,
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      hintStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black)),
                ),
                SizedBox(
                  height: 35,
                ),
                TextFormField(
                  initialValue: user!.email,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please Enter Your Email';
                    }
                    if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                        .hasMatch(value)) {
                      return 'Please provide a valid Email';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    email = value!;
                  },
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(bottom: 3),
                      labelText: 'Email',
                      labelStyle: TextStyle(
                        fontSize: 22,
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      hintStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black)),
                ),
                SizedBox(
                  height: 95,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 35),
                      child: OutlinedButton(
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          )),
                        ),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => MainSettingsPage(user: user!),
                          ));
                        },
                        child: Text(
                          'CANCEL',
                          style: TextStyle(
                              fontSize: 14,
                              letterSpacing: 2.2,
                              color: Colors.black),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 35),
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(kButtonColor),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                    side: BorderSide(color: kButtonColor)))),
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            formKey.currentState!.save();
                            if(imageFile != null){
                              Dio dio = new Dio();
                              var formData = FormData.fromMap({
                                'email': user!.email,
                                'file': await MultipartFile.fromFile(imageFile!,
                                    filename: "upload")
                              });
                              var response = await dio.post(
                                  'https://automovehicle.herokuapp.com/saveImage',
                                  data: formData,
                                  options: Options(
                                      method: 'POST',
                                      responseType: ResponseType.json));

                              final getResponse = await http.get(Uri.parse(
                                  'https://automovehicle.herokuapp.com/saveImage'));

                              final decoded = json
                                  .decode(
                                      getResponse.body) as Map<String,
                                  dynamic>; //converting it from json to key value pair
                              user!.photoURL = decoded[
                                  'photoURL']; //changing the state of our widget on data update
                              user!.downloaded = false;
                              print(user!.photoURL);
                            }

                            final sendResponse = await http.post(
                                Uri.parse(
                                    'https://automovehicle.herokuapp.com/saveDetails'),
                                body: json.encode({
                                  'email': user!.email,
                                  'new email': email,
                                  'username': user!.userName,
                                  'new username': userName
                                }));

                            final detailsDecoded = json
                                .decode(
                                    sendResponse.body) as Map<String,
                                dynamic>; //converting it from json to key value pair
                            detailsChanged = detailsDecoded['response'];
                            print(detailsChanged);

                            if (detailsChanged == "true") {
                              user!.email = email;
                              user!.userName = userName;
                            }
                            showAlertDialog(context);
                          }
                        },
                        child: Text(
                          ' SAVE ',
                          style: TextStyle(
                              fontSize: 14,
                              letterSpacing: 2.2,
                              color: Colors.black),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
