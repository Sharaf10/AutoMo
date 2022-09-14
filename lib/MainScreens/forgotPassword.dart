import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_final/MainScreens/signIn.dart';
import 'package:flutter_final/User.dart';
import 'package:flutter_final/constants.dart';
import 'package:http/http.dart' as http;

import '../User.dart';
import '../constants.dart';

class ForgotPasswordPage extends StatelessWidget {
  User user;
  ForgotPasswordPage({required this.user});
  late String email;
  late String serverResponse;
  final forgotKey = GlobalKey<FormState>();

  void showResetPasswordDialog(BuildContext context) {
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return SignInPage();
        }));
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Center(child: Text('Success')),
      content:
      Text('The verification code was sent to the email address provided'),
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
    final theme = Theme.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(

        child: Form(
            key: forgotKey,
            child: Column(
              children: [
                SizedBox(
                    height: 80),
                Flexible(
                  flex: 1,
                  child: Container(

                    height: 250,
                    width: 300.0,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/forgotpassword.jpg"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.0),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(children: [
                              TextSpan(
                                  text: "Reset Password\n\n",
                                  style: kPageHeading),
                              TextSpan(
                                  text:
                                  "Please enter your email address. You will receive a link to reset your password via email.\n\n",
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal)),
                            ]),
                          ),
                          TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please Enter your Email Address';
                              }
                              if (!RegExp(
                                  "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                  .hasMatch(value)) {
                                return 'Please Enter a valid Email';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderSide:
                                  BorderSide(color: kButtonColor, width: 2),
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                              hintText: "Email Address",
                              prefixIcon: Icon(
                                Icons.email,
                                color: kButtonColor,
                              ),
                            ),
                            onSaved: (String ?value) {
                              email = value!;
                            },
                          ),
                          SizedBox(height: 38.0),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 300,
                  height: 45.0,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                      MaterialStateProperty.all<Color>(kButtonColor),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40.0),
                            side: BorderSide(color: kButtonColor),
                          )),
                    ),
                    onPressed: () async {
                      if (forgotKey.currentState!.validate()) {
                        forgotKey.currentState!.save();
                        final sendResponse = await http.post(
                            Uri.parse(
                                'https://automovehicle.herokuapp.com/recovery'),
                            body: json.encode({'email': email}));

                        final decoded = json.decode(sendResponse.body) as Map<
                            String,
                            dynamic>; //converting it from json to key value pair
                        serverResponse = decoded[
                        'response']; //changing the state of our widget on data update

                        print(serverResponse);

                        //shows the dialog box after validating the form and is returned true
                        showResetPasswordDialog(context);
                      }
                    },
                    child: Text(
                      "SEND",
                      style: Theme.of(context).textTheme.button!.copyWith(
                        color: Colors.black,
                        fontSize: 22,
                      ),
                    ),
                  ),
                )
              ],
            )),
      ),
    );
  }
}