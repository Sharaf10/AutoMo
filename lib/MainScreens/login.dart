import 'dart:convert';

import 'package:flutter_final/User.dart';
import 'package:flutter/src/material/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_final/MainScreens/signIn.dart';
import 'package:flutter_final/constants.dart';
import 'package:flutter_final/loadingScreen.dart';
import 'package:http/http.dart' as http;

import 'option.dart';

class Login extends StatefulWidget {
  @override
  _Login createState() => _Login();
}

class _Login extends State<Login> {
  bool loading = false;
  String? userName;
  String? email;
  String? pass;
  late String serverResponse;
  TextEditingController password = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();
  bool pwdHidden = true;
  bool confirmpwd = true;

  void _togglePasswordView() {
    pwdHidden = !pwdHidden;
    setState(() {});
  }

  void _togglePasswordView2() {
    confirmpwd = !confirmpwd;
    setState(() {});
  }

  final formKey = GlobalKey<FormState>();

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please Enter Your Name';
    }
    String pattern = r'^[A-Za-z0-9]+(?:[ _-][A-Za-z0-9]+)*$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Enter a valid Name';
    } else {
      return null;
    }
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter some text';
    }
    String pattern = "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]";
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Please provide a valid Email';
    } else
      return null;
  }

  String? validatePassword(String? password_a) {
    if (password_a == null || password_a.isEmpty) {
      return 'Please Enter Password';
    }
    if (password_a.length < 5) {
      return 'password must contain at least 5 characters';
    }
    String pattern = r'^(?=.[0-9]+.)(?=.[a-zA-Z]+.)[0-9a-zA-Z]{5,}$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(password_a)) {
      return 'should contain letters and numeric values';
    } else {
      return null;
    }
  }

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please Re-enter Password';
    }
    if (password.text != confirmpassword.text) {
      return "Password does not match";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? LoadingPage()
        : Scaffold(
            body: SingleChildScrollView(
              child: Container(
                color: Colors.white,
                padding: EdgeInsets.only(top: 20),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: <Widget>[
                      Text(
                        'Welcome To AutoMo',
                        style: TextStyle(
                          color: Color.fromRGBO(0, 150, 234, 1),
                          fontWeight: FontWeight.bold,
                          fontSize: 28,
                        ),
                      ),
                      Container(
                          padding: EdgeInsets.only(top: 10),
                          child: Image(
                              image: AssetImage("assets/images/car_deal.jpg"))),
                      Container(
                        margin: EdgeInsets.only(top: 0),
                        child: Center(
                          child: Text(
                            'Sign up and get price predictions for your vehicle',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.all(20.0),
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
                                      validator: (value) =>
                                          validateName(value),
                                      // if (value!.isEmpty) {
                                      //   return 'Please Enter Your Name';
                                      // }
                                      // Pattern pattern =
                                      //     r'^[A-Za-z0-9]+(?:[ _-][A-Za-z0-9]+)*$';
                                      // RegExp regex = new RegExp(pattern);
                                      // if (!regex.hasMatch(value))
                                      //   return 'Invalid username';
                                      // else
                                      //   return null;
                                      // },
                                      onSaved: (value) {
                                        userName = value;
                                      },
                                      autofocus: true,
                                      decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 5, horizontal: 3),
                                          icon: Icon(Icons.person,
                                              color: kButtonColor),
                                          border: InputBorder.none,
                                          hintText: 'User Name',
                                          hintStyle: TextStyle(fontSize: 18)),
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
                                      style: TextStyle(color: Colors.black),
                                      validator: (value) =>
                                          validateEmail(value),
                                      // if (value.isEmpty) {
                                      //   return 'Please Enter Your Email';
                                      // }
                                      // //EmailValidator.validate(value)? null:"Invalid email address";
                                      //
                                      // if (!RegExp(
                                      //     "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                      //     .hasMatch(value)) {
                                      //   return 'Please provide a valid Email';
                                      // }
                                      // return null;
                                      // },
                                      autofocus: true,
                                      onSaved: (value) {
                                        email = value;
                                      },
                                      decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 5, horizontal: 3),
                                          icon: Icon(
                                            Icons.mail,
                                            color: kButtonColor,
                                          ),
                                          border: InputBorder.none,
                                          hintText: 'Email Address',
                                          hintStyle: TextStyle(fontSize: 18)),
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
                                      validator: (password_a) =>
                                          validatePassword(password_a),
                                      autofocus: true,
                                      obscureText: pwdHidden,
                                      decoration: InputDecoration(
                                        errorStyle: TextStyle(
                                          height: 0.1,
                                        ),
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 5, horizontal: 3),
                                        icon: Icon(Icons.person,
                                            color: kButtonColor),
                                        suffixIcon: InkWell(
                                          onTap: _togglePasswordView,
                                          child: Icon(
                                            Icons.visibility,
                                            color: kButtonColor,
                                          ),
                                        ),
                                        border: InputBorder.none,
                                        hintText: 'Enter Password',
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
                                      obscureText: confirmpwd,
                                      validator: (value) =>
                                          validateConfirmPassword(value),
                                      autofocus: true,
                                      onSaved: (value) {
                                        pass = value;
                                      },
                                      decoration: InputDecoration(
                                          errorStyle: TextStyle(
                                            height: 0.1,
                                          ),
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 5, horizontal: 3),
                                          icon: Icon(Icons.lock,
                                              color: kButtonColor),
                                          suffixIcon: InkWell(
                                            onTap: _togglePasswordView2,
                                            child: Icon(
                                              Icons.visibility,
                                              color: kButtonColor,
                                            ),
                                          ),
                                          border: InputBorder.none,
                                          hintText: 'Confirm Password',
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
                                    setState(() => loading = true);
                                    formKey.currentState!.save();
                                    final sendResponse = await http.post(
                                        Uri.parse(
                                            'https://automovehicle.herokuapp.com/register'),
                                        body: json.encode({
                                          'username': userName,
                                          'email': email,
                                          'password': pass
                                        }));

                                    final decoded = json
                                        .decode(
                                            sendResponse.body) as Map<String,
                                        dynamic>; //converting it from json to key value pair
                                    serverResponse = decoded[
                                        'response']; //changing the state of our widget on data update

                                    print("Server Response " + serverResponse);

                                    //User user=new User(userName:userName,email:email,photoURL:"");
                                    User user =
                                        User.fromUser1(userName, email, "");
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) => Option(user: user),
                                      //builder: (context) => Option(user: user),
                                    ));
                                  }
                                  ;
                                },
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          kButtonColor),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(26.0),
                                    side: BorderSide(color: kButtonColor),
                                  )),
                                ),
                                child: new Text(
                                  'REGISTER',
                                  style: TextStyle(
                                      fontSize: 18,
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
                                    Navigator.push(context, MaterialPageRoute(
                                      builder: (context) {
                                        return SignInPage();
                                      },
                                    ));
                                  },
                                  child: Text(
                                    'Already have an account? Sign In ',
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
