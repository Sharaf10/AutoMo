import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_final/MainScreens/option.dart';
import 'package:flutter_final/User.dart';
import 'package:http/http.dart' as http;

import 'constants.dart';

class ContactUs extends StatelessWidget {
  User user;
  ContactUs({required this.user});

  late String serverResponse;
  late String userName;
  late String email;
  late String message;
  final formKey = GlobalKey<FormState>();
  void showMessageDialog(BuildContext context) {
    Widget okButton = ElevatedButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => Option(user: user),
        ));
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Center(child: Text('Success')),
      content: Text('Thank you for messaging we will get back to you soon :)'),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 1,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_outlined,
              color: kButtonColor,
            ),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => Option(user: user),
              ));
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(30),
            child: Form(
              key: formKey,
              child: Column(children: [
                Text(
                  'Contact Us',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'FontTitle',
                      color: Color(0xFF80DEEA)),
                ),
                SizedBox(height: 20),
                Text('How can we help you',
                    style:
                        TextStyle(fontSize: 18, fontStyle: FontStyle.italic)),
                SizedBox(height: 20),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Your Name';
                    }
                    String pattern = r'^[A-Za-z0-9]+(?:[ _-][A-Za-z0-9]+)*$';
                    RegExp regex = RegExp(pattern);
                    if (!regex.hasMatch(value)) {
                      return 'Invalid username';
                    } else {
                      return null;
                    }
                  },
                  onSaved: (value) {
                    userName = value!;
                  },
                  decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: kButtonColor, width: 2)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: kButtonColor, width: 2)),
                    labelText: "User Name",
                    labelStyle: TextStyle(
                      fontSize: 20,
                      color: Colors.blue[800],
                    ),
                  ),
                ),
                SizedBox(
                  height: 45,
                ),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Your Email';
                    }
                    //EmailValidator.validate(value)? null:"Invalid email address";

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
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: kButtonColor, width: 2)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: kButtonColor, width: 2)),
                    labelText: "Email",
                    labelStyle: TextStyle(
                      fontSize: 20,
                      color: Colors.blue[800],
                    ),
                  ),
                ),
                SizedBox(
                  height: 45,
                ),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '* required';
                    } else
                      return null;
                  },
                  minLines: 6,
                  maxLines: 13,
                  onSaved: (value) {
                    message = value!;
                  },
                  decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: kButtonColor, width: 2)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: kButtonColor, width: 2)),
                    labelText: "Message",
                    labelStyle: TextStyle(
                      fontSize: 20,
                      color: Colors.blue[800],
                    ),
                  ),
                ),
                SizedBox(
                  height: 45,
                ),
                Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                        width: 120,
                        height: 45,
                        child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  kButtonColor),
                            ),
                            child: Row(
                              children: <Widget>[
                                Text(
                                  'Send  ',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                                Icon(
                                  Icons.send,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ],
                            ),
                            onPressed: () async {
                              if (formKey.currentState!.validate()) {
                                formKey.currentState!.save();
                                final sendResponse = await http.post(
                                    Uri.parse(
                                        'https://automovehicle.herokuapp.com/feedback'),
                                    body: json.encode({
                                      'username': userName,
                                      'email': email,
                                      'message': message
                                    }));

                                final decoded = json
                                    .decode(
                                        sendResponse.body) as Map<String,
                                    dynamic>; //converting it from json to key value pair
                                serverResponse = decoded[
                                    'response']; //changing the state of our widget on data update

                                print(serverResponse);
                                showMessageDialog(context);
                              }
                            }))),
              ]),
            ),
          ),
        ));
  }
}
