import 'package:flutter/material.dart';
import 'package:flutter_final/constants.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

void main() {
  runApp(LoadingPage());
}

class LoadingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Center(
        child: SpinKitFadingCircle(
          color: kButtonColor,
          size: 100,
        ),
      ),
    );
  }
}
