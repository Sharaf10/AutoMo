import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_final/Graph.dart';
import 'package:flutter_final/OptionScreens/predictor.dart';
import 'package:flutter_final/User.dart';
import 'package:flutter_final/constants.dart';

class ResultPage extends StatelessWidget {
  String finalResponse;
  User user;
  String url;

  ResultPage(
      {required this.finalResponse, required this.user, required this.url});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: Text(
                'Results',
                style: TextStyle(fontSize: 20, color: kButtonColor),
              ),
              centerTitle: true,
              leading: IconButton(
                icon: Icon(Icons.arrow_back_outlined),
                color: kButtonColor,
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => DropDown(user: user),
                  ));
                },
              ),
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            ),
            backgroundColor: Colors.white,
            body: Container(
              constraints: BoxConstraints.expand(),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/background.gif"),
                      fit: BoxFit.cover)),
              child: SingleChildScrollView(
                child: SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SlideFadeTransition(
                        delayStart: Duration(milliseconds: 500),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 60, vertical: 200),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width - 2 * 34,
                            child: Card(
                                shadowColor: Colors.blue,
                                elevation: 8,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                color: kCardColor1,
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(10),
                                        child: Image(
                                          image: AssetImage(
                                            'assets/images/result.gif',
                                          ),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Padding(
                                          padding: EdgeInsets.all(20),
                                          child: Text(
                                            'Estimated Price = ' +
                                                finalResponse,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20,
                                                fontFamily: 'FontTitle'),
                                          )),
                                      Align(
                                        alignment: Alignment.center,
                                        child: ElevatedButton(
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all<
                                                    Color>(Colors.lightBlue),
                                            shape: MaterialStateProperty.all<
                                                    RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(18.0),
                                            )),
                                          ),
                                          onPressed: () {
                                            Navigator.of(context)
                                                .push(MaterialPageRoute(
                                              builder: (context) =>
                                                  DisplayImage(
                                                      user: user, url: url),
                                            ));
                                          },
                                          child: Text(
                                            "Predictor Graph",
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                                fontFamily: 'FontSubTitle'),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                          padding: EdgeInsets.only(bottom: 20))
                                    ])),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )));
  }
}

enum Direction { vertical, horizontal }

class SlideFadeTransition extends StatefulWidget {
  ///The child on which to apply the given [SlideFadeTransition]
  final Widget child;

  ///The offset by which to slide and [child] into view from [Direction].
  ///Defaults to 1.0
  final double offset;

  ///The curve used to animate the [child] into view.
  ///Defaults to [Curves.easeIn]
  final Curve curve;

  ///The direction from which to animate the [child] into view. [Direction.horizontal]
  ///will make the child slide on x-axis by [offset] and [Direction.vertical] on y-axis.
  ///Defaults to [Direction.vertical]
  final Direction direction;

  ///The delay with which to animate the [child]. Takes in a [Duration] and
  /// defaults to 0.0 seconds
  final Duration delayStart;
  final Duration animationDuration;

  SlideFadeTransition({
    required this.child,
    this.offset = 1.0,
    this.curve = Curves.easeIn,
    this.direction = Direction.vertical,
    this.delayStart = const Duration(seconds: 0),
    this.animationDuration = const Duration(milliseconds: 800),
  });

  @override
  _SlideFadeTransitionState createState() => _SlideFadeTransitionState();
}

class _SlideFadeTransitionState extends State<SlideFadeTransition>
    with SingleTickerProviderStateMixin {
  late Animation<Offset> _animationSlide;

  late AnimationController _animationController;

  late Animation<double> _animationFade;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );

    //configure the animation controller as per the direction
    if (widget.direction == Direction.vertical) {
      _animationSlide =
          Tween<Offset>(begin: Offset(0, widget.offset), end: Offset(0, 0))
              .animate(CurvedAnimation(
        curve: widget.curve,
        parent: _animationController,
      ));
    } else {
      _animationSlide =
          Tween<Offset>(begin: Offset(widget.offset, 0), end: Offset(0, 0))
              .animate(CurvedAnimation(
        curve: widget.curve,
        parent: _animationController,
      ));
    }

    _animationFade =
        Tween<double>(begin: -1.0, end: 1.0).animate(CurvedAnimation(
      curve: widget.curve,
      parent: _animationController,
    ));

    Timer(widget.delayStart, () {
      _animationController.forward();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animationFade,
      child: SlideTransition(
        position: _animationSlide,
        child: widget.child,
      ),
    );
  }
}
