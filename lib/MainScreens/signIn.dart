import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_final/MainScreens/forgotPassword.dart';
import 'package:flutter_final/MainScreens/signup.dart';
import 'package:flutter_final/MainScreens/option.dart';
import 'package:flutter_final/User.dart';
import 'package:flutter_final/constants.dart';
import 'package:flutter_final/loadingScreen.dart';
import 'package:http/http.dart' as http;

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  late User user;
  bool loading = false;
  late String email;
  late String pass;
  late String serverResponse;
  bool PasswordHidden = true;
  late bool isPasswordTextField;
  void _togglePasswordView() {
    PasswordHidden = !PasswordHidden;
    setState(() {});
  }

  //TextController to read text entered in text field
  TextEditingController password = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    showAlertDialog(BuildContext context) {
      // set up the buttons
      Widget okButton = ElevatedButton(
        child: Text("OK"),
        onPressed: () {
          Navigator.of(context, rootNavigator: true).pop();
        },
      );
      // set up the AlertDialog
      AlertDialog alert = AlertDialog(
        title: Text(
          "Authentication Failed",
          style: TextStyle(color: Colors.red),
        ),
        content: Text(
          "Incorrect Email or Password",
          style: TextStyle(color: Colors.red),
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

    return loading
        ? LoadingPage()
        : Scaffold(
            resizeToAvoidBottomInset: true,
            body: Container(
              child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Flexible(
                        flex: 3,
                        child: Container(
                          height: 250,
                          width: 300.0,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/images/car.jpg"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 50),
                          child: Column(
                            children: <Widget>[
                              SizedBox(height: 20.0),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text("SIGN IN",
                                      style: TextStyle(
                                        fontSize: 20.0,
                                          fontWeight: FontWeight.bold),

                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(context, MaterialPageRoute(
                                        builder: (context) {
                                          return Signup();
                                        },
                                      ));
                                    },
                                    child: Text(
                                      "SIGNUP",
                                      style: TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold,
                                        color: Color(0xFF80DEEA)),
                                      ),
                                    ),

                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 3,
                        child: SingleChildScrollView(
                          child: Container(
                            padding: EdgeInsets.all(30),
                            child: Column(
                              children: [
                                TextFormField(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please Enter your Email Address';
                                    }
                                    if (!RegExp(
                                            "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                        .hasMatch(value)) {
                                      return 'Please a valid Email';
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: kButtonColor, width: 2),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20))),
                                    hintText: "Email Address",
                                    hintStyle: TextStyle(fontSize: 18),
                                    prefixIcon: Icon(
                                      Icons.email,
                                      color: kButtonColor,
                                    ),
                                  ),
                                  onSaved: (value) {
                                    email = value!;
                                  },
                                ),
                                SizedBox(height: 20.0),
                                TextFormField(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please Enter a Password';
                                    }
                                    return null;
                                  },
                                  obscureText: PasswordHidden,
                                  controller: password,
                                  keyboardType: TextInputType.text,
                                  onSaved: (value) {
                                    pass = value!;
                                  },
                                  decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: kButtonColor, width: 2),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20))),
                                      hintText: "Password",
                                      hintStyle: TextStyle(fontSize: 18),
                                      prefixIcon: Icon(
                                        Icons.lock,
                                        color: kButtonColor,
                                      ),
                                      suffixIcon: InkWell(
                                        onTap: _togglePasswordView,
                                        child: Icon(
                                          Icons.visibility,
                                          color: kButtonColor,
                                        ),
                                      )),
                                ),
                                SizedBox(height: 38.0),
                              ],
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              user=User.empty();
                              return ForgotPasswordPage(user: user);
                            },
                          ));
                        },
                        child: Text(
                          'Forgot Password',
                          style: TextStyle(
                              fontSize: 18,
                              color: kButtonColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 15, bottom: 20),
                        child: SizedBox(
                          width: 300,
                          height: 45.0,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  kButtonColor),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40.0),
                                side: BorderSide(color: kButtonColor),
                              )),
                            ),
                            onPressed: () async {
                              if (formKey.currentState!.validate()) {
                                setState(() => loading = true);
                                formKey.currentState!.save();
                                final sendResponse = await http.post(
                                    Uri.parse(
                                        'https://automovehicle.herokuapp.com/signin'),
                                    body: json.encode(
                                        {'email': email, 'password': pass}));

                                final decoded = json
                                    .decode(
                                        sendResponse.body) as Map<String,
                                    dynamic>; //converting it from json to key value pair
                                serverResponse = decoded[
                                    'response']; //changing the state of our widget on data update

                                print(serverResponse);

                                if (serverResponse == "valid") {
                                  //User user=new User(userName:decoded['username'],email:decoded['email'],photoURL:decoded['photoURL']);
                                  User user = new User(
                                      decoded['username'],
                                      decoded['email'],
                                      decoded['photoURL'],
                                      decoded['photoPath']);
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => Option(user: user),
                                  ));
                                } else {
                                  password.clear();
                                  showAlertDialog(context);
                                  //added newly to check loading
                                  setState(() {
                                    loading = false;
                                    // error="Incorrect User Credentials";
                                  });
                                  print(
                                      "please enter valid username and password");
                                }
                              }
                            },
                            child: Text(
                              "SIGN IN",
                              style:
                                  Theme.of(context).textTheme.button!.copyWith(
                                        color: Colors.black,
                                        fontSize: 22,
                                      ),
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
