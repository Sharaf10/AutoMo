import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_final/OptionScreens/mainSettings.dart';
import 'package:flutter_final/User.dart';
import 'package:flutter_final/constants.dart';
import 'package:flutter_final/privacyPolicy.dart';

void main() {
  late User user1;
  user1 = new User.empty();
  runApp(Privacy(user: user1));
}

class Privacy extends StatefulWidget {
  late User user;
  Privacy({Key? key, required this.user}) : super(key: key);

  @override
  State<Privacy> createState() => _PrivacyState(user: user);
}

class _PrivacyState extends State<Privacy> {
  late User user;
  _PrivacyState({required this.user});

  bool isSwitchPrivateAccount = false;
  bool isSwitchMuteCall = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 1,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => MainSettingsPage(user: user),
            ));
          },
          icon: Icon(
            Icons.arrow_back,
            color: kButtonColor,
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage("assets/images/bg3.jpg"),
          fit: BoxFit.cover,
        )),
        padding: EdgeInsets.only(left: 16, top: 25, right: 16),
        child: ListView(
          children: [
            Text(
              "Privacy Settings",
              style: kPageHeading,
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              children: [
                Icon(
                  Icons.lock_rounded,
                  color: kButtonColor,
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  "Account Privacy",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: kButtonColor),
                ),
              ],
            ),
            Divider(
              height: 15,
              thickness: 2,
            ),
            SizedBox(
              height: 10,
            ),
            SwitchListTile(
                contentPadding: const EdgeInsets.all(0),
                value: isSwitchPrivateAccount,
                activeColor: Colors.lightBlueAccent,
                title: Text(
                  'Private Account',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.blueGrey[900],
                  ),
                ),
                onChanged: (bool val) {
                  setState(() {
                    isSwitchPrivateAccount = val;
                  });
                }),
            SizedBox(
              height: 40,
            ),
            Row(
              children: [
                Icon(
                  Icons.person_rounded,
                  color: kButtonColor,
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  "Interactions",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: kButtonColor),
                ),
              ],
            ),
            Divider(
              height: 15,
              thickness: 2,
            ),
            SizedBox(
              height: 10,
            ),
            buildPrivacyOptionRow(context, "Activity Status"),
            buildPrivacyOptionRow(context, "Guides"),
            buildPrivacyOptionRow(context, "Call History"),
            SizedBox(
              height: 40,
            ),
            Row(
              children: [
                Icon(
                  Icons.people_alt_rounded,
                  color: kButtonColor,
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  "Connections",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: kButtonColor),
                ),
              ],
            ),
            Divider(
              height: 15,
              thickness: 2,
            ),
            SizedBox(
              height: 10,
            ),
            SwitchListTile(
                contentPadding: const EdgeInsets.all(0),
                value: isSwitchMuteCall,
                activeColor: Colors.lightBlueAccent,
                title: Text(
                  'Opportunity',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.blueGrey[900],
                  ),
                ),
                onChanged: (bool val) {
                  setState(() {
                    isSwitchMuteCall = val;
                  });
                }),
            buildPrivacyOptionRow(context, "Blocked Accounts"),
            buildPrivacyOptionRow(context, "Muted Accounts"),
            SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }

  Row buildNotificationOptionRow(String title, bool isActive) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black),
        ),
        Transform.scale(
            scale: 0.7,
            child: CupertinoSwitch(
              activeColor: kButtonColor,
              value: isActive,
              onChanged: (bool isActive) {
                setState(() {
                  isActive = !isActive;
                });
              },
            ))
      ],
    );
  }

  GestureDetector buildPrivacyOptionRow1(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => PrivacyPolicyPage(user: user),
        ));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Privacy Policy",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.blueGrey[900],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.blueGrey[900],
            ),
          ],
        ),
      ),
    );
  }

  GestureDetector buildPrivacyOptionRow(BuildContext context, String title) {
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(title),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Option 1"),
                    Text("Option 2"),
                    Text("Option 3"),
                  ],
                ),
                actions: [
                  ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text("Close")),
                ],
              );
            });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.blueGrey[900],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.blueGrey[900],
            ),
          ],
        ),
      ),
    );
  }
}
