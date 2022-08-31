import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_final/User.dart';
import 'package:flutter_final/loadingScreen.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants.dart';

//String number;

class Call extends StatelessWidget {
  User user;

  Call({required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 1,
        title: Text(
          'Call Expert',
          style: TextStyle(color: kButtonColor),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_outlined,
            color: kButtonColor,
          ),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => LoadingPage(),
            ));
          },
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(top: 20, bottom: 20),
            child: Column(
              children: <Widget>[
                CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('assets/images/user1.jpg'),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Robert Hoogmoed'.toUpperCase(),
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 15,
                  width: 200,
                  child: Divider(
                    color: Colors.blue,
                  ),
                ),
                Text('flutter_finalbile Engineer'),
                SizedBox(
                  height: 10,
                ),
                Card(
                  color: Colors.white60,
                  shadowColor: Colors.blue[800],
                  margin: EdgeInsets.all(20),
                  child: ListTile(
                      leading: Icon(
                        Icons.phone,
                        color: Colors.blue[700],
                      ),
                      onTap: () {
                        customLaunch('tel:+94 76 327 4506');
                      },
                      title: Text('+94 76 327 4506')),
                ),
                CircleAvatar(
                  radius: 50,
                  backgroundImage:
                      AssetImage('assets/ExpertProfPics/expert.jpg'),
                ),
                SizedBox(
                  height: 10,
                ),
                Text('Andrew Jhonson'.toUpperCase(),
                    style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(
                  height: 15,
                  width: 200,
                  child: Divider(
                    color: Colors.blue,
                  ),
                ),
                Text('flutter_finalbile Engineer'),
                SizedBox(
                  height: 10,
                ),
                Card(
                  color: Colors.white60,
                  shadowColor: Colors.blue[800],
                  margin: EdgeInsets.all(20),
                  child: ListTile(
                      leading: Icon(
                        Icons.phone,
                        color: Colors.blue[700],
                      ),
                      onTap: () {
                        customLaunch('tel:+94 76 902 1688');
                      },
                      title: Text('+94 76 902 1688')),
                ),
                CircleAvatar(
                  radius: 50,
                  backgroundImage:
                      AssetImage('assets/ExpertProfPics/expert1.jpg'),
                ),
                SizedBox(
                  height: 10,
                ),
                Text('John Mathew'.toUpperCase(),
                    style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(
                  height: 15,
                  width: 200,
                  child: Divider(
                    color: Colors.blue,
                  ),
                ),
                Text('flutter_finalbile Dealer'),
                SizedBox(
                  height: 10,
                ),
                Card(
                  color: Colors.white60,
                  shadowColor: Colors.blue[800],
                  margin: EdgeInsets.all(20),
                  child: ListTile(
                      leading: Icon(
                        Icons.phone,
                        color: Colors.blue[700],
                      ),
                      onTap: () {
                        customLaunch('tel:+94 77 447 5760');
                      },
                      title: Text('+94 77 447 5760')),
                ),
                CircleAvatar(
                  radius: 50,
                  backgroundImage:
                      AssetImage('assets/ExpertProfPics/expert2.png'),
                ),
                SizedBox(
                  height: 10,
                ),
                Text('Shane Marshal'.toUpperCase(),
                    style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(
                  height: 15,
                  width: 200,
                  child: Divider(
                    color: Colors.blue,
                  ),
                ),
                Text('flutter_finalbile Dealer'),
                SizedBox(
                  height: 10,
                ),
                Card(
                  color: Colors.white60,
                  shadowColor: Colors.blue[800],
                  margin: EdgeInsets.all(20),
                  child: ListTile(
                      leading: Icon(
                        Icons.phone,
                        color: Colors.blue[700],
                      ),
                      onTap: () {
                        customLaunch('tel:+94 76 905 0491');
                      },
                      title: Text('+94 76 905 0491')),
                ),
                CircleAvatar(
                  radius: 50,
                  backgroundImage:
                      AssetImage('assets/ExpertProfPics/expert3.jpg'),
                ),
                SizedBox(
                  height: 10,
                ),
                Text('Emilie Wilson'.toUpperCase(),
                    style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(
                  height: 15,
                  width: 200,
                  child: Divider(
                    color: Colors.blue,
                  ),
                ),
                Text('flutter_finalbile Engineer'),
                SizedBox(
                  height: 10,
                ),
                Card(
                  color: Colors.white60,
                  shadowColor: Colors.blue[800],
                  margin: EdgeInsets.all(20),
                  child: ListTile(
                      leading: Icon(
                        Icons.phone,
                        color: Colors.blue[700],
                      ),
                      onTap: () {
                        customLaunch('tel:+94 77 706 8021');
                      },
                      title: Text('+94 77 706 8021')),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void customLaunch(command) async {
  await launch(command);
}
