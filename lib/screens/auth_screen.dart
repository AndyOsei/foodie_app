import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:foodie_app/routes/router.gr.dart';
import 'package:foodie_app/values/values.dart';
import 'package:foodie_app/widgets/rounded_button.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextTheme _textTheme = Theme.of(context).textTheme;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.white200,
      body: SingleChildScrollView(
        child: DefaultTabController(
          length: 2,
          child: Column(
            children: [
              Container(
                height: height * 0.4,
                child: _buildHeader(_textTheme),
              ),
              Container(
                height: height * 0.6,
                child: TabBarView(
                  children: [
                    _buildLogin(context, _textTheme),
                    _buildSignUp(context, _textTheme),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container _buildHeader(TextTheme _textTheme) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: Sizes.SIZE_40),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [Shadows.authHeader],
        borderRadius: BorderRadius.vertical(
          bottom: const Radius.circular(Sizes.SIZE_30),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            ImagePath.LOGO_2,
            scale: 1,
          ),
          SizedBox(height: Sizes.SIZE_8),
          TabBar(
            indicatorPadding: const EdgeInsets.symmetric(
              horizontal: Sizes.SIZE_20,
            ),
            tabs: [
              Tab(
                child: Text(
                  StringConst.LOGIN,
                  style: _textTheme.subtitle1.copyWith(
                    fontFamily: StringConst.SF_PRO_TEXT,
                  ),
                ),
              ),
              Tab(
                child: Text(
                  StringConst.SIGNUP,
                  style: _textTheme.subtitle1.copyWith(
                    fontFamily: StringConst.SF_PRO_TEXT,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _goToHome() {
    ExtendedNavigator.root.push(Routes.homeScreen);
  }

  Padding _buildLogin(BuildContext context, TextTheme _textTheme) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: Sizes.SIZE_40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Spacer(flex: 1),
            TextField(
              decoration: InputDecoration(
                labelStyle: _textTheme.bodyText1.copyWith(
                  fontFamily: StringConst.SF_PRO_TEXT,
                  color: AppColors.black50,
                  fontSize: Sizes.TEXT_SIZE_15,
                ),
                labelText: StringConst.EMAIL_ADDRESS,
              ),
            ),
            Spacer(flex: 1),
            TextField(
              obscureText: true,
              obscuringCharacter: StringConst.AETERISKS,
              decoration: InputDecoration(
                labelStyle: _textTheme.bodyText1.copyWith(
                  fontFamily: StringConst.SF_PRO_TEXT,
                  color: AppColors.black50,
                  fontSize: Sizes.TEXT_SIZE_15,
                ),
                labelText: StringConst.PASSWORD,
              ),
            ),
            Spacer(flex: 1),
            TextButton(
              onPressed: () {},
              child: Text(
                StringConst.FORGOT_PASSWORD,
                style: _textTheme.button.copyWith(
                  fontFamily: StringConst.SF_PRO_TEXT,
                  color: AppColors.red200,
                  fontSize: Sizes.TEXT_SIZE_15,
                ),
              ),
            ),
            Spacer(flex: 3),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: Sizes.SIZE_30),
                child: RoundedButton(
                  width: MediaQuery.of(context).size.width - Sizes.SIZE_150,
                  height: Sizes.SIZE_60,
                  label: StringConst.LOGIN,
                  onPressed: _goToHome,
                ),
              ),
            ),
          ],
        ),
      );

  Padding _buildSignUp(BuildContext context, TextTheme _textTheme) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: Sizes.SIZE_40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Spacer(flex: 1),
            TextField(
              decoration: InputDecoration(
                labelStyle: _textTheme.bodyText1.copyWith(
                  fontFamily: StringConst.SF_PRO_TEXT,
                  color: AppColors.black50,
                  fontSize: Sizes.TEXT_SIZE_15,
                ),
                labelText: StringConst.EMAIL_ADDRESS,
              ),
            ),
            Spacer(flex: 1),
            TextField(
              obscureText: true,
              obscuringCharacter: StringConst.AETERISKS,
              decoration: InputDecoration(
                labelStyle: _textTheme.bodyText1.copyWith(
                  fontFamily: StringConst.SF_PRO_TEXT,
                  color: AppColors.black50,
                  fontSize: Sizes.TEXT_SIZE_15,
                ),
                labelText: StringConst.PASSWORD,
              ),
            ),
            Spacer(flex: 1),
            TextField(
              obscureText: true,
              obscuringCharacter: StringConst.AETERISKS,
              decoration: InputDecoration(
                labelStyle: _textTheme.bodyText1.copyWith(
                  fontFamily: StringConst.SF_PRO_TEXT,
                  color: AppColors.black50,
                  fontSize: Sizes.TEXT_SIZE_15,
                ),
                labelText: StringConst.CONFIRM_PASSWORD,
              ),
            ),
            Spacer(flex: 3),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: Sizes.SIZE_30),
                child: RoundedButton(
                  onPressed: _goToHome,
                  width: MediaQuery.of(context).size.width - Sizes.SIZE_150,
                  height: Sizes.SIZE_60,
                  label: StringConst.SIGNUP,
                ),
              ),
            ),
          ],
        ),
      );
}
