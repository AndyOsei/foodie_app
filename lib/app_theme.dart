import 'package:flutter/material.dart';
import 'package:foodie_app/values/values.dart';

class AppTheme {
  static const _heavy = FontWeight.w900;
  static const _bold = FontWeight.w700;
  static const _semiBold = FontWeight.w600;
  static const _regular = FontWeight.w400;
  // static const _extraBold = FontWeight.w800;
  // static const _medium = FontWeight.w500;
  // static const _light = FontWeight.w300;

  static ThemeData themeData = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.primaryColor,
    accentColor: AppColors.accentColor,
    fontFamily: StringConst.SF_PRO_ROUNDED,
    textTheme: _textTheme,
  );

  static TextTheme _textTheme = TextTheme(
    headline1: TextStyle(
      fontSize: Sizes.TEXT_SIZE_60,
      fontWeight: _heavy,
    ),
    headline2: TextStyle(
      fontSize: Sizes.TEXT_SIZE_34,
      fontWeight: _heavy,
    ),
    headline3: TextStyle(
      fontSize: Sizes.TEXT_SIZE_28,
      fontWeight: _bold,
    ),
    headline4: TextStyle(
      fontSize: Sizes.TEXT_SIZE_22,
      fontWeight: _semiBold,
    ),
    headline5: TextStyle(
      fontSize: Sizes.TEXT_SIZE_17,
      fontWeight: _bold,
    ),
    subtitle1: TextStyle(
      fontSize: Sizes.TEXT_SIZE_18,
      fontWeight: _semiBold,
    ),
    subtitle2: TextStyle(
      fontSize: Sizes.TEXT_SIZE_10,
      fontWeight: _semiBold,
    ),
    button: TextStyle(
      fontSize: Sizes.TEXT_SIZE_17,
      fontWeight: _semiBold,
    ),
    bodyText1: TextStyle(
      fontSize: Sizes.TEXT_SIZE_17,
      fontWeight: _semiBold,
    ),
    bodyText2: TextStyle(
      fontSize: Sizes.TEXT_SIZE_17,
      fontWeight: _regular,
    ),
  );
}
