import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:foodie_app/routes/router.gr.dart';
import 'package:foodie_app/values/values.dart';

class AuthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TextTheme _textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: Container(
        color: AppColors.white100,
        child: SafeArea(
          top: false,
          bottom: true,
          child: DefaultTabController(
            length: 2,
            child: Column(
              children: [
                Flexible(
                  flex: 3,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: Sizes.SIZE_40),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.06),
                          offset: const Offset(0, 4.0),
                          blurRadius: Sizes.SIZE_30,
                        )
                      ],
                      borderRadius: BorderRadius.vertical(
                        bottom: const Radius.circular(30),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          ImagePath.LOGO_2,
                        ),
                        SizedBox(height: Sizes.SIZE_8),
                        TabBar(
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
                  ),
                ),
                Flexible(
                  flex: 5,
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
      ),
    );
  }

  Padding _buildLogin(BuildContext context, TextTheme _textTheme) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: Sizes.SIZE_40),
        child: Column(
          children: [
            Flexible(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextField(
                    decoration: InputDecoration(
                      labelStyle: _textTheme.bodyText1.copyWith(
                        fontFamily: StringConst.SF_PRO_TEXT,
                      ),
                      hintText: StringConst.EMAIL_ADDRESS,
                    ),
                  ),
                  TextField(
                    obscureText: true,
                    obscuringCharacter: StringConst.AETERISKS,
                    decoration: InputDecoration(
                      labelStyle: _textTheme.bodyText1.copyWith(
                        fontFamily: StringConst.SF_PRO_TEXT,
                      ),
                      hintText: StringConst.PASSWORD,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      StringConst.FORGOT_PASSWORD,
                      style: _textTheme.button.copyWith(
                        fontFamily: StringConst.SF_PRO_TEXT,
                        color: AppColors.red200,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              flex: 1,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width - Sizes.SIZE_150,
                  height: Sizes.SIZE_60,
                  child: TextButton(
                    onPressed: () {
                      ExtendedNavigator.root.push(Routes.authScreen);
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: AppColors.red200,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(Sizes.SIZE_30),
                      ),
                      primary: Colors.white,
                    ),
                    child: Text(StringConst.LOGIN),
                  ),
                ),
              ),
            ),
          ],
        ),
      );

  Padding _buildSignUp(BuildContext context, TextTheme _textTheme) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: Sizes.SIZE_40),
        child: Column(
          children: [
            Flexible(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextField(
                    decoration: InputDecoration(
                      labelStyle: _textTheme.bodyText1.copyWith(
                        fontFamily: StringConst.SF_PRO_TEXT,
                      ),
                      hintText: StringConst.EMAIL_ADDRESS,
                    ),
                  ),
                  TextField(
                    obscureText: true,
                    obscuringCharacter: '*',
                    decoration: InputDecoration(
                      labelStyle: _textTheme.bodyText1.copyWith(
                        fontFamily: StringConst.SF_PRO_TEXT,
                      ),
                      hintText: StringConst.PASSWORD,
                    ),
                  ),
                  TextField(
                    obscureText: true,
                    obscuringCharacter: '*',
                    decoration: InputDecoration(
                      labelStyle: _textTheme.bodyText1.copyWith(
                        fontFamily: StringConst.SF_PRO_TEXT,
                      ),
                      hintText: StringConst.CONFIRM_PASSWORD,
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              flex: 1,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width - Sizes.SIZE_150,
                  height: Sizes.SIZE_60,
                  child: TextButton(
                    onPressed: () {
                      ExtendedNavigator.root.push(Routes.authScreen);
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: AppColors.red200,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(Sizes.SIZE_30),
                      ),
                      primary: Colors.white,
                    ),
                    child: Text(StringConst.SIGNUP_ALT),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}
