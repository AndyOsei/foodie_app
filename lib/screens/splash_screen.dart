import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:foodie_app/routes/router.gr.dart';
import 'package:foodie_app/values/values.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final splashDelay = 5;

  @override
  void initState() {
    super.initState();

    _loadWidget();
  }

  _loadWidget() async {
    var _duration = Duration(seconds: splashDelay);
    return Timer(_duration, navigationPage);
  }

  void navigationPage() {
    ExtendedNavigator.root.push(Routes.getStartedScreen);
  }

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width - Sizes.SIZE_120;

    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(
          ImagePath.BACKGROUND,
          fit: BoxFit.cover,
        ),
        Align(
          alignment: Alignment.center,
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(size / 2),
              color: Colors.white,
            ),
            child: Stack(
              fit: StackFit.expand,
              children: [
                Positioned(
                  top: -30,
                  left: 10,
                  child: Image.asset(
                    ImagePath.BELLA_OLONJE_LOGO,
                  ),
                ),
                Positioned(
                  top: size / 2 + 10,
                  left: size / 3,
                  child: Text(
                    StringConst.FOOD_FOR_EVERYONE,
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                ),
                Positioned(
                  bottom: size / 6,
                  right: size / 2 - 20,
                  child: CircularProgressIndicator(),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
