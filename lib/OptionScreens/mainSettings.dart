import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_final/MainScreens/option.dart';
import 'package:flutter_final/MainScreens/signIn.dart';
import 'package:flutter_final/SettingsScreens/changePassword.dart';
import 'package:flutter_final/SettingsScreens/editProfile.dart';
import 'package:flutter_final/SettingsScreens/privacySettings.dart';
import 'package:flutter_final/User.dart';
import 'package:flutter_final/constants.dart';

class MainSettingsPage extends StatefulWidget {
  User user;
  MainSettingsPage({Key? key, required this.user}) : super(key: key);

  @override
  State<MainSettingsPage> createState() => _MainSettingsPageState(user: user);
}

class _MainSettingsPageState extends State<MainSettingsPage> {
  User user;
  _MainSettingsPageState({required this.user});
  bool isSwitchNewForYou = false;
  bool isSwitchedAccountActivity = false;
  bool isSwitchOpportunity = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 1,
        title: Text(
          "Settings",
          style: TextStyle(color: kButtonColor),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => Option(user: user),
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
              "Settings",
              style: kPageHeading,
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              children: [
                Icon(
                  Icons.person,
                  color: kButtonColor,
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  "Account",
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
            buildSettingsOptionRow1(context),
            buildSettingsOptionRow2(context),
            buildSettingsOptionRow3(context),
            SizedBox(
              height: 40,
            ),
            Row(
              children: [
                Icon(
                  Icons.volume_up_outlined,
                  color: kButtonColor,
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  "Notifications",
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
                value: isSwitchNewForYou,
                activeColor: Colors.lightBlueAccent,
                title: Text(
                  'New for you',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.blueGrey[900],
                  ),
                ),
                onChanged: (bool val) {
                  setState(() {
                    isSwitchNewForYou = val;
                  });
                }),
            // buildNotificationOptionRow("New for you", true),
            SwitchListTile(
                contentPadding: const EdgeInsets.all(0),
                value: isSwitchedAccountActivity,
                activeColor: Colors.lightBlueAccent,
                title: Text(
                  'Account Activity',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.blueGrey[900],
                  ),
                ),
                onChanged: (bool val) {
                  setState(() {
                    isSwitchedAccountActivity = val;
                  });
                }),
            SwitchListTile(
                contentPadding: const EdgeInsets.all(0),
                value: isSwitchOpportunity,
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
                    isSwitchOpportunity = val;
                  });
                }),
            SizedBox(
              height: 50,
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: OutlinedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(kButtonColor),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40.0),
                      side: BorderSide(color: kButtonColor),
                    )),
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return SignInPage();
                    }));
                  },
                  child: Text("SIGN OUT",
                      style: TextStyle(
                          fontSize: 16,
                          letterSpacing: 2.2,
                          color: Colors.black)),
                ),
              ),
            )
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

  GestureDetector buildSettingsOptionRow1(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => EditProfile(user: user),
        ));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Edit Profile",
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

  GestureDetector buildSettingsOptionRow2(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ChangePasswordPage(user: user),
        ));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Change password",
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

  GestureDetector buildSettingsOptionRow3(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => Privacy(user: user),
        ));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Privacy and security",
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
