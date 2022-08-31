import 'package:flutter/material.dart';
import 'package:flutter_final/MainScreens/option.dart';
import 'package:flutter_final/User.dart';
import 'package:flutter_final/constants.dart';

class QuestionsPage extends StatefulWidget {
  User user;
  QuestionsPage({Key? key, required this.user}) : super(key: key);

  @override
  State<QuestionsPage> createState() => _QuestionsPageState(user: user);
}

class _QuestionsPageState extends State<QuestionsPage> {
  User user;
  _QuestionsPageState({required this.user});
  UniqueKey? keyTile;
  bool isExpanded = false;

  void expandTile() {
    setState(() {
      isExpanded = true;
      keyTile = UniqueKey();
    });
  }

  void shrinkTile() {
    setState(() {
      isExpanded = false;
      keyTile = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 1,
          title: Text(
            "FAQ",
            style: TextStyle(color: kButtonColor),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: kButtonColor,
            ),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => Option(user: user),
              ));
            },
          ),
        ),
        body: ListView(
          padding: EdgeInsets.all(16),
          children: [
            buildImageInteractionCard(),
            buildRoundedCard(),
            buildRoundedCard2(),
            buildRoundedCard3(),
            buildRoundedCard4(),
          ],
        ),
      );

  Widget buildRoundedCard() => Card(
        shadowColor: kCardColor,
        elevation: 8,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [kCardColor2, kButtonColor],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildQuestion1(context),
            ],
          ),
        ),
      );

  Widget buildRoundedCard2() => Card(
        shadowColor: kCardColor,
        elevation: 8,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [kCardColor2, kButtonColor],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildQuestion2(context),
            ],
          ),
        ),
      );
  Widget buildRoundedCard3() => Card(
        shadowColor: kCardColor,
        elevation: 8,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [kCardColor2, kButtonColor],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildQuestion3(context),
            ],
          ),
        ),
      );

  Widget buildRoundedCard4() => Card(
        shadowColor: kCardColor,
        elevation: 8,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [kCardColor2, kButtonColor],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildQuestion4(context),
            ],
          ),
        ),
      );

  Widget buildQuestion1(BuildContext context) => Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          key: keyTile,
          initiallyExpanded: isExpanded,
          childrenPadding: EdgeInsets.all(16).copyWith(top: 0),
          title: Text(
            'What type of Vehicles does AutoMo give predictions?',
            style: kFAQheadingText,
          ),
          children: [
            Text(
              "AutoMo mainly focuses on Toyota cars only. Therefore it doesn't offer predictions for other types of vehicles",
              style: kFAQbodyText,
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      );

  Widget buildQuestion2(BuildContext context) => Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          key: keyTile,
          initiallyExpanded: isExpanded,
          childrenPadding: EdgeInsets.all(16).copyWith(top: 0),
          title: Text(
            'Who are the experts we can call?',
            style: kFAQheadingText,
          ),
          children: [
            Text(
              "AutoMo partners with a few realiable vehicle dealers who have a vast knowledge of the market and will be able to clear any doubts you have about the vehicle. ",
              style: kFAQbodyText,
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      );

  Widget buildQuestion3(BuildContext context) => Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          key: keyTile,
          initiallyExpanded: isExpanded,
          childrenPadding: EdgeInsets.all(16).copyWith(top: 0),
          title: Text(
            'Can we get the price predicted for a new car?',
            style: kFAQheadingText,
          ),
          children: [
            Text(
              "No. AutoMo only focuses on used vehicles. ",
              style: kFAQbodyText,
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      );

  Widget buildQuestion4(BuildContext context) => Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          key: keyTile,
          initiallyExpanded: isExpanded,
          childrenPadding: EdgeInsets.all(16).copyWith(top: 0),
          title: Text(
            'Can we find a vehicle for the price given by AutoMo?',
            style: kFAQheadingText,
          ),
          children: [
            Text(
              "AutoMo only gives an estimate of the price. If theres a very high difference between the two prices it's likely that the dealer is keeping a huge profit. Also the prices can always change according to the import policies in the country",
              style: kFAQbodyText,
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      );

  Widget buildImageInteractionCard() => Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: [
            Stack(
              children: [
                Ink.image(
                  image: AssetImage("assets/images/Q2.jpg"),
                  child: InkWell(
                    onTap: () {},
                  ),
                  height: 240,
                  fit: BoxFit.cover,
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(16).copyWith(bottom: 0),
              child: Center(
                child: Text('Frequently Asked Questions',
                    textAlign: TextAlign.center, style: kPageHeading),
              ),
            ),
          ],
        ),
      );
}
