import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:foodie_app/routes/router.gr.dart';
import 'package:foodie_app/values/values.dart';

class GetStartedScreen extends StatelessWidget {
  const GetStartedScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.red,
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                flex: 3,
                child: _buildHeaderSection(context),
              ),
              Flexible(
                flex: 5,
                child: _buildContentSection(),
              ),
              Flexible(
                flex: 1,
                child: _buildButtonSection(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Align _buildButtonSection(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: SizedBox(
        width: MediaQuery.of(context).size.width - Sizes.SIZE_150,
        height: Sizes.SIZE_60,
        child: TextButton(
          onPressed: () {
            ExtendedNavigator.root.push(Routes.authScreen);
          },
          style: TextButton.styleFrom(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Sizes.SIZE_30),
            ),
            primary: AppColors.primaryColor,
          ),
          child: Text(StringConst.GET_STARTED),
        ),
      ),
    );
  }

  Stack _buildContentSection() {
    return Stack(
      fit: StackFit.expand,
      children: [
        Align(
          alignment: Alignment.bottomRight,
          child: Image.asset(ImagePath.TOY_FACE_BOY),
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: Image.asset(ImagePath.TOY_FACE_GIRL),
        ),
        FractionallySizedBox(
          heightFactor: 0.335,
          widthFactor: 0.4,
          alignment: Alignment.bottomRight,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromRGBO(255, 71, 11, 0.51),
                  Color.fromRGBO(255, 71, 11, 1)
                ],
                transform: GradientRotation(-0.0349),
              ),
            ),
          ),
        ),
        FractionallySizedBox(
          heightFactor: 0.35,
          widthFactor: 0.6,
          alignment: Alignment.bottomLeft,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromRGBO(255, 71, 11, 0.1),
                  Color.fromRGBO(255, 71, 11, 1)
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Container _buildHeaderSection(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: Sizes.SIZE_36,
        left: Sizes.SIZE_48,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: Sizes.SIZE_72,
            height: Sizes.SIZE_72,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(Sizes.SIZE_72 / 2),
            ),
            child: Image.asset(
              ImagePath.LOGO,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: Sizes.SIZE_30),
            child: Text(
              StringConst.FOOD_FOR_EVERYONE,
              style: Theme.of(context).textTheme.headline1.copyWith(
                    color: Colors.white,
                    height: 0.8,
                  ),
            ),
          )
        ],
      ),
    );
  }
}
