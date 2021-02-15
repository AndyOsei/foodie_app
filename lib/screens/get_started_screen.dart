import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:foodie_app/routes/router.gr.dart';
import 'package:foodie_app/values/values.dart';
import 'package:foodie_app/widgets/rounded_button.dart';

class GetStartedScreen extends StatelessWidget {
  const GetStartedScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: AppColors.red,
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                flex: 3,
                child: _buildHeader(context),
              ),
              Flexible(
                flex: 5,
                child: _buildContent(),
              ),
              Flexible(
                flex: 1,
                child: _buildButton(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToAuthPage() {
    ExtendedNavigator.root.push(Routes.authScreen);
  }

  Align _buildButton(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(bottom: Sizes.SIZE_8),
        child: RoundedButton(
          onPressed: _navigateToAuthPage,
          width: MediaQuery.of(context).size.width - Sizes.SIZE_150,
          height: Sizes.SIZE_60,
          label: StringConst.GET_STARTED,
          labelColor: AppColors.primaryColor,
          backgroundColor: Colors.white,
        ),
      ),
    );
  }

  Stack _buildContent() {
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
                  AppColors.orange51,
                  AppColors.orange100,
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

  Container _buildHeader(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: Sizes.SIZE_20,
        left: Sizes.SIZE_48,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: Sizes.SIZE_60,
            height: Sizes.SIZE_60,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(Sizes.SIZE_60 / 2),
            ),
            child: Image.asset(
              ImagePath.LOGO,
            ),
          ),
          Spacer(),
          Text(
            StringConst.FOOD_FOR_EVERYONE,
            style: Theme.of(context).textTheme.headline1.copyWith(
                  color: Colors.white,
                  height: 0.8,
                ),
          ),
          Spacer(),
        ],
      ),
    );
  }
}
