import 'package:flutter/material.dart';
import 'package:flutter_final/User.dart';
import 'package:flutter_final/constants.dart';

class DisplayImage extends StatefulWidget {
  User user;
  String url;

  DisplayImage({Key? key, required this.user, required this.url})
      : super(key: key);

  @override
  State<DisplayImage> createState() => _DisplayImageState(user: user, url: url);
}

class _DisplayImageState extends State<DisplayImage> {
  late User user;
  late String url;
  _DisplayImageState({required this.user, required this.url});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            appBar: AppBar(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              title: Text(
                "Predictor Graph",
                style: TextStyle(fontSize: 20, color: kButtonColor),
              ),
              centerTitle: true,
            ),
            body:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(
                "Graph",
                style: TextStyle(fontSize: 28, fontFamily: 'FontTitle'),
              ),
              Padding(padding: EdgeInsets.only(bottom: 30)),
              Container(
                // padding: EdgeInsets.symmetric(horizontal: 50),
                width: MediaQuery.of(context).size.width,

                child: Image.network(
                  url,
                  fit: BoxFit.cover,
                ),
              ),
            ])));
  }
}
