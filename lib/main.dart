import 'package:flutter_final/MainScreens/option.dart';
import 'package:flutter_final/MainScreens/signIn.dart';
import 'package:flutter_final/OptionScreens/callExpert.dart';
import 'package:flutter_final/OptionScreens/mainSettings.dart';
import 'package:flutter_final/User.dart';
import 'package:flutter/material.dart';

import 'MainScreens/signup.dart';
import 'constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AutoMo',
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: kButtonColor,
        scaffoldBackgroundColor: kBackgroundColor,
        textTheme: TextTheme(
          headline1: TextStyle(
              fontSize: 50.0,
              color: Colors.blue,
              fontFamily: "FontTitle",
              fontWeight: FontWeight.normal),
          button: TextStyle(color: kButtonColor),
          headline2: TextStyle(
              fontSize: 30.0,
              color: Colors.black,
              fontFamily: "FontTitle",
              fontWeight: FontWeight.bold),
          headline6: TextStyle(
              fontSize: 22.0,
              color: Colors.blueGrey,
              fontFamily: "FontSubTitle",
              fontWeight: FontWeight.normal),
        ),
        inputDecorationTheme: InputDecorationTheme(
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white.withOpacity(.2),
            ),
          ),
        ),
      ),
      home: WelcomeScreen(),
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 1.0),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/welcome.jpg"),
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
          ),
          Expanded(
            child: Column(
              children: <Widget>[
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "AutoMo\n\n",
                        style: Theme.of(context).textTheme.headline1,
                      ),
                      TextSpan(
                        text: "Want to buy a Vehicle?\n",
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      TextSpan(
                        text: " Get it's Price Predicted",
                        style: TextStyle(
                          fontSize: 22.0,
                          color: Colors.blueGrey,
                          fontFamily: "FontSubTitle",
                          fontWeight: FontWeight.normal,
                          letterSpacing: 2,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 50.0),
                FittedBox(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return SignInPage();
                        },
                      ));
                    },
                    child: Container(
                      margin: EdgeInsets.only(bottom: 7),
                      padding:
                      EdgeInsets.symmetric(horizontal: 26, vertical: 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: kButtonColor,
                      ),
                      child: Row(
                        children: <Widget>[
                          Text(
                            "GET STARTED",
                            style: Theme.of(context).textTheme.button!.copyWith(
                              color: Colors.black,
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(width: 10),
                          Icon(
                            Icons.arrow_forward,
                            color: Colors.black,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
