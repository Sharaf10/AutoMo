import 'dart:convert';
import 'dart:io'; // for File

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_final/ContactUs.dart';
import 'package:flutter_final/MainScreens/signup.dart';
import 'package:flutter_final/MainScreens/signIn.dart';
import 'package:flutter_final/OptionScreens/FAQPage.dart';
import 'package:flutter_final/OptionScreens/callExpert.dart';
import 'package:flutter_final/OptionScreens/mainSettings.dart';
import 'package:flutter_final/OptionScreens/predictor.dart';
import 'package:flutter_final/User.dart';
import 'package:flutter_final/constants.dart';
import 'package:flutter_final/privacyPolicy.dart';
import 'package:http/http.dart' as http;
import 'package:image_downloader/image_downloader.dart';
import 'package:image_picker/image_picker.dart';

class Option extends StatefulWidget {
  User user;

  Option({Key? key, required this.user}) : super(key: key);

  @override
  State<Option> createState() => _OptionState(user: user);
}

class _OptionState extends State<Option> {
  late User user;

  _OptionState({required this.user});

  @override
  initState() {
  //  _asyncMethod();
    super.initState();
  }

  _asyncMethod() async {
    late var path;
    if (user.downloaded == true) {
      path = user.photoPath;
    } else {
      var imageId = await ImageDownloader.downloadImage(user.photoURL);
      if(imageId != null) {
        path = await ImageDownloader.findPath(imageId);
        user.photoPath = path;
        user.downloaded = true;
      }
    }
    //PickedFile file2 = new PickedFile(path);             // <-- 2
    //file2.writeAsBytesSync(response.bodyBytes);         // <-- 3
    setState(() {
      imageFile = path;
    });
  }

  late String serverResponse;
  String? imageFile;
  bool _load = false;

  final ImagePicker picker = ImagePicker();

  void takePhoto(ImageSource source) async {
    final pickedFile = await picker.getImage(source: source);
    setState(() {
      imageFile = pickedFile!.path;
    });
    Dio dio = Dio();
    var formData = FormData.fromMap({
      'email': user.email,
      'file': await MultipartFile.fromFile(imageFile!, filename: "upload")
    });
    var response = await dio.post('https://automovehicle.herokuapp.com/saveImage',
        data: formData,
        options: Options(method: 'POST', responseType: ResponseType.json));

    final getResponse = await http
        .get(Uri.parse('https://automovehicle.herokuapp.com/saveImage'));

    final decoded = json.decode(getResponse.body)
        as Map<String, dynamic>; //converting it from json to key value pair
    user.photoURL =
        decoded['photoURL']; //changing the state of our widget on data update
    user.downloaded = false;
    print(user.photoURL);
  }

  @override
  Widget build(BuildContext context) {
    Widget bottomsheet() {
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

    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child:
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => PrivacyPolicyPage(user: user),
              ));
            },
            child: Text(
              'Privacy Policy |',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ContactUs(user: user),
              ));
            },
            child: Text(
              ' Contact Us | ',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return SignInPage();
                },
              ));
            },
            child: Text(
              'Logout',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          )
        ]),
      ),
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 1,
        title: Text(
          'Home',
          style: TextStyle(color: kButtonColor),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_outlined,
            color: kButtonColor,
          ),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return Signup();
            }));
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.only(top: 20, bottom: 10),
          child: Column(children: <Widget>[
            Center(
              child: Stack(
                children: [
                  Container(
                      width: 160,
                      height: 160,
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 4,
                              color: Theme.of(context).scaffoldBackgroundColor),
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
                                  ? AssetImage('assets/images/default_user.jpg')
                                      as ImageProvider
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
                                color:
                                    Theme.of(context).scaffoldBackgroundColor),
                            color: kButtonColor),
                        child: InkWell(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              builder: ((builder) => bottomsheet()),
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
              height: 80,
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.white, elevation: 0),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => DropDown(user: user),
                      ));
                    },
                    child: Image.asset(
                      'assets/images/Predictor.png',
                      width: 120,
                      height: 120,
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.white, elevation: 0),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => Call(user: user),
                      ));
                    },
                    child: Image.asset(
                      'assets/images/call_expert.png',
                      width: 120,
                      height: 120,
                    ),
                  ),
                ],
              ),
            ),
            Padding(padding: EdgeInsets.symmetric(vertical: 20)),
            Container(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.white, elevation: 0),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => MainSettingsPage(user: user),
                    ));
                  },
                  child: Image.asset(
                    'assets/images/settings.png',
                    width: 120,
                    height: 120,
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.white, elevation: 0),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => QuestionsPage(user: user),
                    ));
                  },
                  child: Image.asset(
                    'assets/images/question.png',
                    width: 120,
                    height: 120,
                  ),
                ),
              ],
            )),
          ]),
        ),
      ),
    );
  }
}
