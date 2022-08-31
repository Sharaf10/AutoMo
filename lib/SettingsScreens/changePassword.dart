import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_final/MainScreens/forgotPassword.dart';
import 'package:flutter_final/OptionScreens/mainSettings.dart';
import 'package:flutter_final/User.dart';
import 'package:flutter_final/constants.dart';
import 'package:http/http.dart' as http;

class ChangePasswordPage extends StatefulWidget {
  User user;

  ChangePasswordPage({Key? key, required this.user}) : super(key: key);

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordState(user: user);
}

class _ChangePasswordState extends State<ChangePasswordPage> {
  late User user;

  _ChangePasswordState({required this.user});

  late String userName;
  late String email;
  late String serverResponse;
  late String newPassword;
  TextEditingController oldPassword = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();

  // String password;
  // String confirm;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 1,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_outlined,
            color: kButtonColor,
          ),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => MainSettingsPage(user: user),
            ));
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.only(top: 20),
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                Container(
                    padding: EdgeInsets.only(top: 10),
                    child: Image(
                        image: AssetImage('assets/images/ChangePassword.jpg'))),
                Container(
                  margin: EdgeInsets.only(top: 0),
                  child: Center(
                    child: Text(
                      'Change Password',
                      style: kPageHeading,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(40.0),
                  child: Column(children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(bottom: 35),
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: kButtonColor, width: 2),
                      ),
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 40,
                            child: Container(
                              child: TextFormField(
                                controller: oldPassword,
                                keyboardType: TextInputType.text,
                                /*validator: (password_a) {
                                  if (password_a.isEmpty) {
                                    return 'Please Enter Password';
                                  }
                                  Pattern pattern =
                                      r'^(?=.*[0-9]+.*)(?=.*[a-zA-Z]+.*)[0-9a-zA-Z]{9,}$';
                                  RegExp regex = new RegExp(pattern);
                                  if (!regex.hasMatch(password_a))
                                    return 'Invalid password';
                                  else
                                    return null;
                                },*/
                                autofocus: true,
                                obscureText: true,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 3),
                                  icon: Icon(Icons.person, color: kButtonColor),
                                  border: InputBorder.none,
                                  hintText: 'Enter old Password',
                                  hintStyle: TextStyle(fontSize: 18),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 35),
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: kButtonColor, width: 2),
                      ),
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 40,
                            child: Container(
                              child: TextFormField(
                                controller: password,
                                keyboardType: TextInputType.text,
                                validator: (password_b) {
                                  if (password_b == null ||
                                      password_b.isEmpty) {
                                    return 'Please Enter Password';
                                  }
                                  String pattern =
                                      r'^(?=.*[0-9]+.*)(?=.*[a-zA-Z]+.*)[0-9a-zA-Z]{9,}$';
                                  RegExp regex = new RegExp(pattern);
                                  if (!regex.hasMatch(password_b))
                                    return 'Invalid password';
                                  else
                                    return null;
                                },
                                autofocus: true,
                                obscureText: true,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 3),
                                  icon: Icon(Icons.person, color: kButtonColor),
                                  border: InputBorder.none,
                                  hintText: 'Enter new Password',
                                  hintStyle: TextStyle(fontSize: 18),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 35),
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: kButtonColor, width: 2),
                      ),
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 40,
                            child: Container(
                              child: TextFormField(
                                controller: confirmpassword,
                                keyboardType: TextInputType.text,
                                style: TextStyle(color: Colors.black),
                                obscureText: true,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please Re-enter Password';
                                  }
                                  if (password.text != confirmpassword.text) {
                                    return "Password does not match";
                                  }
                                  return null;
                                },
                                autofocus: true,
                                onSaved: (value) {
                                  newPassword = value!;
                                },
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 3),
                                    icon: Icon(Icons.lock, color: kButtonColor),
                                    border: InputBorder.none,
                                    hintText: 'Confirm new Password',
                                    hintStyle: TextStyle(fontSize: 18)),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 80,
                      width: 300,
                      child: Padding(
                        padding: EdgeInsets.all(14.0),
                        child: ElevatedButton(
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              formKey.currentState!.save();
                              final sendResponse = await http.post(
                                  Uri.parse(
                                      'https://automovehicle.herokuapp.com/changePassword'),
                                  body: json.encode({
                                    'email': user.email,
                                    'new password': newPassword
                                  }));

                              final decoded = json
                                  .decode(
                                      sendResponse.body) as Map<String,
                                  dynamic>; //converting it from json to key value pair
                              serverResponse = decoded[
                                  'response']; //changing the state of our widget on data update

                              print(serverResponse);

                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    MainSettingsPage(user: user),
                              ));
                            }
                            ;
                          },
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(kButtonColor),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(26.0),
                              side: BorderSide(color: kButtonColor),
                            )),
                          ),
                          child: new Text(
                            'CHANGE',
                            style: TextStyle(
                                fontSize: 18,
                                letterSpacing: 2.2,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    ForgotPasswordPage(user: user),
                              ));
                            },
                            child: Text(
                              'Forgot Password? ',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.lightBlueAccent),
                            )))
                  ]),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
